import 'package:flutter/material.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';

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
        this.hintText = '',
        this.isLoading = false,
        this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
          ignoring: disabled || isLoading,
          child: DropdownButtonFormField<T>(
            decoration: InputDecoration(
              //filled: true,
              //fillColor: AppColorsLight.primaryColor,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: AppColorsLight.grayColor))),
            value: selectedValue,
            hint: Text(hintText),
            isExpanded: false,
            items: items.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(
                    displayText(item),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppColorsLight.blackColor,
                        fontWeight: FontWeight.bold),
                  ),

              );
            }).toList(),
            onChanged: onChanged,
            style: TextStyle(fontWeight: FontWeight.bold),
            dropdownColor: AppColorsLight.whiteColor,
          ),
    );
  }
}
