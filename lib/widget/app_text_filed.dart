import 'package:auth_test/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import the necessary package

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
    return  TextFormField(
    
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
          // errorBorder: _loginTextFieldBorder(),
          // focusedBorder: _loginTextFieldBorder(),
          //enabledBorder: _loginTextFieldBorder(),
         
          filled: true,
          fillColor: Colors.white,
    
          // labelText: labelText,
        ),
        obscureText: obscureText,
        validator: validator,
      );
   
  }

  OutlineInputBorder _loginTextFieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(width: 1, color: Colors.white),
    );
  }
}
