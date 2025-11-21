import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/pokemon.dart';
import 'package:flutter_application_1/widgets/type_chip.dart';

class PokemonListTile extends StatelessWidget {
  final Pokemon pokemon;
  final bool IsFavorite;
  final VoidCallback onTap;
  final VoidCallback onTapFavorite;

  // this is constructor
  const PokemonListTile({
    super.key,
    required this.onTap,
    required this.onTapFavorite,
    required this.IsFavorite,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        leading: Hero(
          tag: pokemon.name,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              pokemon.image,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          pokemon.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: PokemonTypeChip(type: pokemon.type),
        trailing: IconButton(
          icon: Icon(
            IsFavorite ? Icons.favorite : Icons.favorite_border,
            color: IsFavorite ? Colors.pink : Colors.grey,
          ),

          onPressed: onTapFavorite,
        ),
      ),
    );
  }
}
