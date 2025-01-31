import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedValue;
  final ValueChanged<T?> onChanged;
  final String Function(T) displayText;
  final String hintText;
  final bool isLoading;
  final bool disabled;

  const CustomDropdown(
      {super.key,
        required this.items,
        required this.onChanged,
        required this.displayText,
        this.selectedValue,
        this.hintText = 'Select national type',
        this.isLoading = false,
        this.disabled = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18),
      child:IgnorePointer(
        ignoring: disabled || isLoading,
        child: DropdownButtonFormField<T>(
            value: selectedValue,
            hint: Text(hintText),
            isExpanded: true,
          items: items.map((T item){
        return DropdownMenuItem<T>(
        value: item,
        child: Text(displayText(item),
        overflow: TextOverflow.ellipsis));
        }).toList(),
          onChanged:onChanged,
        )
      )
    );
  }
}
