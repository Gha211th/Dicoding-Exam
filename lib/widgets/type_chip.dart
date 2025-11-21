import 'package:flutter/material.dart';

class PokemonTypeChip extends StatelessWidget {
  final String type;
  const PokemonTypeChip({super.key, required this.type});

  Color _typeColor() {
    if (type.contains("Electric")) return Colors.amber;
    if (type.contains("Water")) return Colors.blueAccent;
    if (type.contains("Fire")) return Colors.red;
    if (type.contains("Grass")) return Colors.green;
    if (type.contains("Ghost")) return Colors.deepPurple;
    if (type.contains("Poison")) return Colors.purple;
    if (type.contains("Fairy")) return Colors.redAccent;
    if (type.contains("Dragon")) return Colors.indigo;
    if (type.contains("Steel")) return Colors.blueGrey;
    if (type.contains("Fighting")) return Colors.orange;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: _typeColor(), width: 1),
      ),
      child: Text(
        type,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: _typeColor(),
        ),
      ),
    );
  }
}
