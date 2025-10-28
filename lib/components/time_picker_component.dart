import 'package:flutter/material.dart';

/// Mostra um TimePicker estilizado e retorna um DateTime
Future<DateTime?> timePickerComponent(
  BuildContext context, {
  DateTime? initialDateTime,
}) async {
  // Data base (hoje se null)
  final DateTime baseDate = initialDateTime ?? DateTime.now();

  // Converte DateTime para TimeOfDay
  final TimeOfDay initialTime = TimeOfDay(
    hour: baseDate.hour,
    minute: baseDate.minute,
  );

  // Mostra o TimePicker
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(
          timePickerTheme: TimePickerThemeData(
            backgroundColor: Colors.white,
            hourMinuteShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            hourMinuteTextColor: Colors.black,
            dialHandColor: Colors.black,
            dialBackgroundColor: Colors.grey[200],
            entryModeIconColor: Colors.green,
            dayPeriodTextColor: Colors.yellow,
          ),
          colorScheme: ColorScheme.light(
            primary: Colors.black26,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black87,
          ),
        ),
        child: child!,
      );
    },
  );

  // Retorna null se cancelado
  if (pickedTime == null) return null;

  // Cria um DateTime combinando a data base com hora/minuto escolhidos
  return DateTime(
    baseDate.year,
    baseDate.month,
    baseDate.day,
    pickedTime.hour,
    pickedTime.minute,
  );
}
