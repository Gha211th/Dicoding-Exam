import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/data/pokemon_data.dart';
import 'package:flutter_application_1/widgets/pokemon_card.dart';

class PokemonHomePage extends StatefulWidget {
  const PokemonHomePage({super.key});

  @override
  State<PokemonHomePage> createState() => _PokemonHomePageState();
}

class _PokemonHomePageState extends State<PokemonHomePage> {
  String _searchQuery = '';
  bool _showDavoriteOnly = false;
  final Set<String> _favorite = {};
  final TextEditingController _searchControler = TextEditingController();

  void _toggleFavorite(String PokemonName) {
    setState(() {
      if (_favorite.contains(PokemonName)) {
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    // filter search
    final filtered = datapokemon.where((p) {
      final q = _searchQuery.toLowerCase();
      final matchesSearch = p.name.toLowerCase().contains(q);

      // check favorite
      final matchesFavorite = !_showDavoriteOnly || _favorite.contains(p.name);

      return matchesSearch && matchesFavorite;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Wiki Pokemon')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[]),
            const SizedBox(height: 10),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // layar sempit (mobile)
                  if (constraints.maxWidth < 600) {}
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
                        onTap: () {},
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
