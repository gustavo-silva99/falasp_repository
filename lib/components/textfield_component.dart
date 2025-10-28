import 'package:flutter/material.dart';

class TextFieldComponent extends StatefulWidget {
  final String? hintText;
  final Color? backgroundColor;
  final Color? fontColor;
  final TextEditingController? controller;
  final Widget? iconeEsquerda;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  const TextFieldComponent({
    this.hintText,
    this.backgroundColor = Colors.black,
    this.fontColor = Colors.white,
    this.controller,
    this.iconeEsquerda,
    this.obscureText = false,
    this.onChanged,
    super.key,
  });

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  late TextEditingController _controller;
  bool _temTexto = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _temTexto = _controller.text.isNotEmpty;
    _controller.addListener(() {
      setState(() {
        _temTexto = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          controller: _controller,
          obscureText: widget.obscureText,
          onChanged: widget.onChanged,
          style: TextStyle(
            color: widget.fontColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: widget.fontColor?.withOpacity(0.5),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: widget.iconeEsquerda,
            suffixIcon:
                _temTexto
                    ? GestureDetector(
                      onTap: () {
                        _controller.clear();
                        widget.onChanged?.call('');
                      },
                      child: Icon(Icons.close, color: widget.fontColor),
                    )
                    : null,
          ),
        ),
      ),
    );
  }
}
