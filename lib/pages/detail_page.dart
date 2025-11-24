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
    return const Placeholder();
  }
}
