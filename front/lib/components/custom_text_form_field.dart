import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CustomTextFormField extends StatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final bool? obscureText;
  final bool required;
  final int? maxLength;
  final bool multilined;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const CustomTextFormField({ Key? key, this.validator, this.onChanged,
    this.controller, this.initialValue, this.labelText, this.hintText,
    this.obscureText, this.required = false, this.keyboardType,
    this.multilined = false, this.inputFormatters = const [], this.maxLength
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool obscured;

  @override
  void initState() {
    obscured = widget.obscureText ?? false;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscured,
      onChanged: widget.onChanged,
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      maxLines: widget.multilined ? 4 : 1,
      maxLength: widget.maxLength,
      validator: widget.validator ?? _requiredWidget(),
      inputFormatters: widget.inputFormatters,
      style: TextStyle(color: Colors.grey[800]),
      decoration: InputDecoration(
        suffixIcon: _obscureIcon(),
        label: _label(),
        hintText: widget.hintText,
        border: const OutlineInputBorder(gapPadding: 20)
      ),
    );
  }

  Widget? _label() {
    if (widget.labelText != null) {
      if (widget.required) {
        return Text.rich(TextSpan(
          text: widget.labelText!,
          children: [
            TextSpan(text: " *", 
              style: TextStyle(color: Colors.red))
          ]
        ));
      } else {
        return Text(widget.labelText!);
      }
    }
    return null;
  }

  String? Function(String?)? _requiredWidget() {
    if (widget.required) {
      return (text) {
        if (text == null || text.trim().isEmpty) {
          String genderArticle = 'o';
          if (widget.labelText != null && widget.labelText!.endsWith('a')
          || widget.labelText!.endsWith('as')) {
            genderArticle = 'a';
          }
          return 'Insira $genderArticle ${widget.labelText ?? 'campo obrigatório.'}';
        }
        return null;
      };
    }
    return null;
  } 

  Widget? _obscureIcon() => widget.obscureText == true ? InkWell(
    onTap: () => setState(() { obscured = !obscured; }),
    child: Icon(obscured ? Feather.eye : Feather.eye_off),
  ) : null;
}