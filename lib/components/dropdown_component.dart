import 'package:flutter/material.dart';

class DropdownComponent extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final Color? backgroundColor;
  final Color? fontColor;
  final ValueChanged<String>? onChanged;

  const DropdownComponent({
    required this.items,
    this.initialValue,
    this.backgroundColor = Colors.black,
    this.fontColor = Colors.white,
    this.onChanged,
    super.key,
  });

  @override
  State<DropdownComponent> createState() => _DropdownComponentState();
}

class _DropdownComponentState extends State<DropdownComponent> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue ?? widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: widget.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 20,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          dropdownColor: widget.backgroundColor,
          iconEnabledColor: widget.fontColor,
          style: TextStyle(
            color: widget.fontColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          items:
              widget.items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => selectedValue = value);
              widget.onChanged?.call(value);
            }
          },
          icon: const Icon(Icons.arrow_drop_down), // ícone à esquerda
          isExpanded: true,
        ),
      ),
    );
  }
}
