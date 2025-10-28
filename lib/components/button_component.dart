import 'package:flutter/material.dart';

class ButtonComponent extends StatefulWidget {
  final bool loading;
  final String texto;
  final Color? backgroundColor;
  final Color? fontColor;
  final double? fontSize;
  final Widget? iconeEsquerda; // agora aceita Icon OU Image.asset
  final Widget? iconeDireita; // idem
  final VoidCallback? onPressed;

  const ButtonComponent({
    required this.loading,
    required this.texto,
    this.backgroundColor = Colors.black,
    this.fontColor = Colors.white,
    this.fontSize = 18,
    this.iconeEsquerda,
    this.iconeDireita,
    this.onPressed,
    super.key,
  });

  @override
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
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
                : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      widget.iconeEsquerda ?? Container(),
                      if (widget.texto.isNotEmpty)
                        Container(
                          child: Expanded(
                            child: Center(
                              child: Text(
                                widget.texto,
                                style: TextStyle(
                                  color: widget.fontColor,
                                  fontSize: widget.fontSize,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                      widget.iconeDireita ?? Container(),
                    ],
                  ),
                ),
      ),
    );
  }
}
