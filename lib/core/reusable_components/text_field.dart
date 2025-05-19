import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final IconData hintIcon;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.hintIcon,
    required this.controller,
    required this.keyboardType,
    required this.validator,
    this.obscureText = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText && passToggle,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        hintStyle: Theme.of(context).textTheme.labelSmall,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Icon(widget.hintIcon),
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
          onPressed: () {
            setState(() {
              passToggle = !passToggle;
            });
          },
          icon: Icon(
            passToggle
                ? Icons.visibility_rounded
                : Icons.visibility_off_rounded,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            size: 24,
          ),
        )
            : null,
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 25,
          maxWidth: 60,
        ),
        hintText: widget.hint,
      ),
    );
  }
}