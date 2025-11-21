import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/pokemon.dart';
import 'package:flutter_application_1/widgets/type_chip.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final bool IsFavorite;
  final VoidCallback onTap;
  final VoidCallback onTapFavorite;

  const PokemonCard({
    super.key,
    required this.onTap,
    required this.onTapFavorite,
    required this.IsFavorite,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Hero(
            tag: pokemon.name,
            child: Image.asset(
              pokemon.image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pokemon.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      PokemonTypeChip(type: pokemon.type),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    IsFavorite ? Icons.favorite : Icons.favorite_border,
                    color: IsFavorite ? Colors.pink : Colors.grey,
                  ),

                  onPressed: onTapFavorite,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
