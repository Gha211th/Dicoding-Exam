import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/data/pokemon_data.dart';
import 'package:flutter_application_1/models/pokemon.dart';
import 'package:flutter_application_1/pages/detail_page.dart';
import 'package:flutter_application_1/widgets/pokemon_card.dart';
import 'package:flutter_application_1/widgets/pokemon_list_tile.dart';

class PokemonHomePage extends StatefulWidget {
  const PokemonHomePage({super.key});

  @override
  State<PokemonHomePage> createState() => _PokemonHomePageState();
}

class _PokemonHomePageState extends State<PokemonHomePage> {
  String _searchQuery = '';
  bool _showFavoriteOnly = false;
  final Set<String> _favorite = {};
  final TextEditingController _searchControler = TextEditingController();

  Future<void> _openDetailPage(pokemon, bool isFav) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            (pokemonDetailPage(pokemon: pokemon, isFavorite: isFav)),
      ),
    );

    if (result != null) {
      setState(() {
        if (result) {
          _favorite.add(pokemon.name);
        } else {
          _favorite.remove(pokemon.name);
        }
      });
    }
  }

  void _toggleFavorite(String PokemonName) {
    setState(() {
      if (_favorite.contains(PokemonName)) {
      } else {
        _favorite.add(PokemonName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // filter search
    final filtered = datapokemon.where((p) {
      final q = _searchQuery.toLowerCase();
      final matchesSearch = p.name.toLowerCase().contains(q);

      // check favorite
      final matchesFavorite = !_showFavoriteOnly || _favorite.contains(p.name);

      return matchesSearch && matchesFavorite;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Wiki Pokemon')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _searchControler,
                    decoration: InputDecoration(
                      hintText: 'Search Pokemon...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                Switch(
                  value: _showFavoriteOnly,
                  onChanged: (val) {
                    setState(() {
                      _showFavoriteOnly = val;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // layar sempit (mobile)
                  if (constraints.maxWidth < 600) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final pokemon = filtered[index];
                        final isFav = _favorite.contains(pokemon.name);
                        return PokemonListTile(
                          pokemon: pokemon,
                          IsFavorite: isFav,
                          onTap: () => _openDetailPage(pokemon, isFav),
                          onTapFavorite: () => _toggleFavorite(pokemon.name),
                        );
                      },
                      itemCount: filtered.length,
                    );
                  }
                  // layar lebar (tablet)
                  int count = 2;
                  if (constraints.maxWidth >= 600)
                    count = 4;
                  else if (constraints.maxWidth >= 650)
                    count = 3;
                  return GridView.builder(
                    itemCount: filtered.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: count,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 3 / 4,
                    ),
                    itemBuilder: (context, index) {
                      final pokemon = filtered[index];
                      final isFav = _favorite.contains(pokemon.name);
                      return PokemonCard(
                        pokemon: pokemon,
                        IsFavorite: isFav,
                        onTap: () => _openDetailPage(pokemon, isFav),
                        onTapFavorite: () => _toggleFavorite(pokemon.name),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
