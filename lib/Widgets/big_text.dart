import 'package:bank_app/utilities/dimensions.dart';
import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overflow;
  final FontWeight fontWeight;
  const BigText({Key? key, this.color = const Color(0xFF332d2b) ,
    required this.text,
    this.size = 0,
    this.overflow = TextOverflow.ellipsis, this.fontWeight = FontWeight.normal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style:  TextStyle(
        color:  color,
        fontWeight: fontWeight,
        fontFamily: 'Roboto',
        fontSize: size == 0?Dimensions.font20:size,

      ),
    );
  }
}
