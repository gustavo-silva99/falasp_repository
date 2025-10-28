import 'package:flutter/material.dart';

class SnackBarComponent {
  static void show(
    BuildContext context, {
    required String message,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.black,
    Duration duration = const Duration(seconds: 3),
    double borderRadius = 18,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 80),
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(25),
                  blurRadius: 20,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Center(
                    child: Text(
                      message,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 1.0, end: 0.0),
                    duration: duration,
                    builder: (context, value, child) {
                      return LinearProgressIndicator(
                        value: value,
                        valueColor: AlwaysStoppedAnimation<Color>(textColor),
                        backgroundColor: textColor.withAlpha(20),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
