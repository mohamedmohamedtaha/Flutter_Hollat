import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime> onDateSelected;
  final double borderRadius;
  final Color primaryColor;
  final Color headerTextColor;

  const CustomDatePicker({
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    required this.onDateSelected,
    this.borderRadius = 20,
    this.primaryColor = Colors.deepPurple,
    this.headerTextColor = Colors.white,
  });

  static Future<DateTime?> show({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    double borderRadius = 20,
    Color primaryColor = Colors.deepPurple,
    Color headerTextColor = Colors.white,
  }) async {
    // Set safe defaults with validation
    final now = DateTime.now();
    final safeFirstDate = firstDate ?? DateTime(1900);
    final safeLastDate = lastDate ?? now.add(const Duration(days: 365 * 10));
    DateTime safeInitialDate = initialDate ?? now;

    // Ensure date range validity
    if (safeFirstDate.isAfter(safeLastDate)) {
      throw ArgumentError('firstDate cannot be after lastDate');
    }

    // Clamp initial date between first and last dates
    safeInitialDate = safeInitialDate.isBefore(safeFirstDate)
        ? safeFirstDate
        : safeInitialDate.isAfter(safeLastDate)
        ? safeLastDate
        : safeInitialDate;

    return showDatePicker(
      context: context,
      initialDate: safeInitialDate,
      firstDate: safeFirstDate,
      lastDate: safeLastDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: headerTextColor,
            ),
          ),
          child: child!,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.calendar_today, color: primaryColor),
      onPressed: () async {
        final selectedDate = await CustomDatePicker.show(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          borderRadius: borderRadius,
          primaryColor: primaryColor,
          headerTextColor: headerTextColor,
        );
        if (selectedDate != null) {
          onDateSelected(selectedDate);
        }
      },
    );
  }
}
// Usage example with date display
class DateSelectionExample extends StatefulWidget {
  const DateSelectionExample({super.key});

  @override
  _DateSelectionExampleState createState() => _DateSelectionExampleState();
}

class _DateSelectionExampleState extends State<DateSelectionExample> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            final date = await CustomDatePicker.show(
              context: context,
              lastDate: DateTime.now(), // For birth dates
            );
            if (date != null) {
              setState(() => _selectedDate = date);
            }
          },
          child: const Text('Select Birth Date'),
        ),
        const SizedBox(height: 20),
        _buildDateDisplay(),
      ],
    );
  }

  Widget _buildDateDisplay() {
    return _selectedDate != null
        ? Column(
      children: [
        Text(
          'Selected Date:',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          DateFormat.yMMMMd().format(_selectedDate!),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Age: ${_calculateAge(_selectedDate!)} years',
          style: TextStyle(
            fontSize: 16,
            color: Colors.blue[700],
          ),
        ),
      ],
    )
        : Text(
      'No date selected',
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[400],
      ),
    );
  }

  int _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}
// Future<DateTime?> showCustomDatePicker(
//     BuildContext context, int firstDate, int lastDate) async {
//   return showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(firstDate),
//       lastDate: DateTime(lastDate),
//       builder: (context, child) {
//         return Theme(
//             data: ThemeData.light().copyWith(
//               dialogTheme: DialogTheme(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16))),
//               colorScheme: ColorScheme.light(
//                   primary: Colors.deepPurple,
//                   onPrimary: Colors.white,
//                   surface: Colors.amber,
//                   onSurface: Colors.black),
//               textButtonTheme: TextButtonThemeData(
//                   style: TextButton.styleFrom(foregroundColor: Colors.red)),
//               dialogBackgroundColor: Colors.blue[50],
//             ),
//             child: child!);
//       });
// }