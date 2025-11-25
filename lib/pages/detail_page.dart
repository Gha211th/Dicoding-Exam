import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/pokemon.dart';

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
        body: Column(children: [Center(child: Image.asset(p.image))]),
      ),
    );
  }
}
