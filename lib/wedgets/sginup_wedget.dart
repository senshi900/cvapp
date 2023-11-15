import 'package:flutter/material.dart';

class SinUpWedget extends StatefulWidget {
  const SinUpWedget({
    super.key,
    required this.Controller,
    required this.labelText,
    this.validator,
  });

  final TextEditingController Controller;
  final String labelText;
  final String? Function(String?)? validator; // Add a validator function

  @override
  _SinUpWedgetState createState() => _SinUpWedgetState();
}

class _SinUpWedgetState extends State<SinUpWedget> {
  late FocusNode _focusNode;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {}); // Rebuild the widget on focus change
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool shouldHideLabel =
        _focusNode.hasFocus || widget.Controller.text.isNotEmpty;

    return TextFormField(
      focusNode: _focusNode,
      controller: widget.Controller,
      style: TextStyle(
          color: _isError ? Colors.red : Colors.black,
          decorationColor: Colors.black),
      validator: (value) {
        String? validationResult = widget.validator?.call(value);
        if (validationResult != null) {
          setState(() => _isError = true); // Set error state
        } else {
          setState(() => _isError = false); // Reset error state
        }
        return validationResult;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.only(left: 10),
        hintText: widget.labelText,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
