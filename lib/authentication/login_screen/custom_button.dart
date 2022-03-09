import 'package:flutter/material.dart';

// ignore: unused_import

class CustomButton extends StatelessWidget {
  final String text;
  final BorderRadius? radius;
  final Function function;
  final double buttonWidth;
  const CustomButton({
    required this.text,
    required this.buttonWidth,
    required this.function,
    this.radius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => function(),
      child: Material(
        elevation: 10,
        borderRadius: radius ?? BorderRadius.circular(20),
        color: const Color.fromARGB(255, 52, 216, 208),
        child: SizedBox(
            height: size.height / 16,
            width: size.width / buttonWidth,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width / 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )),
      ),
    );
  }
}
