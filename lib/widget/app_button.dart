import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final double padding; // Add this line

  const AppButton({
    Key? key,
    required this.title,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
    this.padding = 20, // Default padding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.symmetric(horizontal: padding), // Use the padding provided
      margin: const EdgeInsets.only(bottom: 12),
      height: 65,
      width: MediaQuery.of(context).size.width, // Use MediaQuery.of(context).size.width
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        child: Align(
          alignment: padding == 0 ? Alignment.centerLeft : Alignment.center,
          child: Text(
            title,
            
            style:  TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: padding == 0 ? FontWeight.w400 :FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
