import 'package:flutter/material.dart';

class ButtonSquareComponent extends StatefulWidget {
  final bool loading;
  final String texto;
  final Color? backgroundColor;
  final Color? fontColor;
  final Widget? icone;
  final VoidCallback? onPressed;

  const ButtonSquareComponent({
    required this.loading,
    required this.texto,
    this.backgroundColor = Colors.black,
    this.fontColor = Colors.white,
    this.icone,
    this.onPressed,
    super.key,
  });

  @override
  State<ButtonSquareComponent> createState() => _ButtonSquareComponentState();
}

class _ButtonSquareComponentState extends State<ButtonSquareComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
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
      child: MaterialButton(
        onPressed: widget.loading ? null : widget.onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        padding: EdgeInsets.zero,
        child:
            widget.loading
                ? Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: widget.fontColor,
                      ),
                    ),
                  ],
                )
                : Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [widget.icone ?? Container()],
                ),
      ),
    );
  }
}
