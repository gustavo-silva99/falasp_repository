import 'package:flutter/material.dart';

class TextBubble extends StatelessWidget {
  final String? texto;
  final Color? backgroundColor;
  final Color? fontColor;
  final double? fontSize;
  final Widget? iconeEsquerda;
  final Widget? iconeDireita;

  const TextBubble({
    this.texto,
    this.backgroundColor = Colors.black,
    this.fontColor = Colors.white,
    this.fontSize = 18.0,
    this.iconeEsquerda,
    this.iconeDireita,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool temTexto = texto != null && texto!.trim().isNotEmpty;

    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 20,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: temTexto ? 24 : 14,
        vertical: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (iconeEsquerda != null) iconeEsquerda!,
          if (temTexto && iconeEsquerda != null) const SizedBox(width: 8),
          if (temTexto)
            Text(
              texto!,
              style: TextStyle(
                color: fontColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          if (temTexto && iconeDireita != null) const SizedBox(width: 8),
          if (iconeDireita != null) iconeDireita!,
        ],
      ),
    );
  }
}
