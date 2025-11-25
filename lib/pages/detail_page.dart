import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/pokemon.dart';
import 'package:flutter_application_1/widgets/type_chip.dart';

class pokemonDetailPage extends StatefulWidget {
  final Pokemon pokemon;
  final bool isFavorite;
  const pokemonDetailPage({
    super.key,
    required this.pokemon,
    required this.isFavorite,
  });

  @override
  State<pokemonDetailPage> createState() => _pokemonDetailPageState();
}

class _pokemonDetailPageState extends State<pokemonDetailPage> {
  late bool _isFavorite;

  @override
  void initState() {
    _isFavorite = widget.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.pokemon;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _isFavorite);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(p.name),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.pink : Colors.grey,
              ),
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // variable layar lebar
            final _isWide = constraints.maxWidth >= 700;

            // widget imagebox
            final imageBox = Hero(
              tag: p.name,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  p.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            );

            // widget infobox
            final infoBox = Card(
              margin: EdgeInsets.all(15.0),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      p.name.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PokemonTypeChip(type: p.type),
                    const SizedBox(height: 10),
                    Text(
                      "Base Power: ${p.basePower}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10, width: 10),
                    Text(
                      "Deskripsi",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5, width: 10),
                    Text(p.description, textAlign: TextAlign.justify),
                    const SizedBox(height: 10, width: 10),
                    Text(
                      "skills",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5, width: 10),
                    Wrap(
                      spacing: 8.0,
                      children: p.skills.map((skills) {
                        return Chip(
                          label: Text(skills),
                          avatar: Icon(Icons.star),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );

            if (_isWide) {
              return Row(
                children: <Widget>[
                  Expanded(flex: 1, child: imageBox),
                  Expanded(flex: 1, child: infoBox),
                ],
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsetsGeometry.all(12.0),
                    child: imageBox,
                  ),
                  infoBox,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
