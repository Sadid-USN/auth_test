import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;

  final String hintText;
  final IconButton? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;

  const AppTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: true,
      controller: textEditingController,
      decoration: InputDecoration(
        
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xffC3C3C3),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        isDense: true,

        border: InputBorder.none,
       

        filled: true,
        fillColor: Colors.white,

     
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }
}
