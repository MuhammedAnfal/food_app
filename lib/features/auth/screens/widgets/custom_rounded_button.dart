
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final EdgeInsetsGeometry padding ;
  final double buttonHeight;
  final double buttonWidth;
  final double borderRadius;
  final Color buttonColor;
  final VoidCallback onPressed;
  final String text;

  const CustomRoundedButton({
    super.key,
    this.padding =const  EdgeInsets.all(20),
    required this.buttonHeight ,
    required this.borderRadius,
    required this.buttonColor,
     required this.buttonWidth, required this.onPressed, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: buttonWidth,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(borderRadius),
            side: BorderSide(color: Colors.black),
          ),
          height: buttonHeight,
          onPressed: onPressed,
          color: buttonColor,
          child: Text(
           text,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
