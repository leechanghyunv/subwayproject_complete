import 'package:flutter/material.dart';

class ColorContainer extends StatelessWidget {

  final String StringNumber;

  const ColorContainer({
    required this.StringNumber,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      color: StringNumber == 'Line1'? const Color(0xff2a4193)
          : StringNumber == 'Line2'?  const Color(0xff027a31)
          : StringNumber == 'Line3'?  const Color(0xffd75e02)
          : StringNumber == 'Line4'?  const Color(0xff028bb9)
          : StringNumber == 'Line5'?  const Color(0xff9637b6)
          : StringNumber == 'Line6'?  const Color(0xff885408)
          : StringNumber == 'Line7'?  const Color(0xff525d02)
          : StringNumber == 'Line8'?  const Color(0xfff62d37)
          : StringNumber == 'Line9'?  const Color(0xff916a2a)
          : StringNumber == '서해'?    const Color(0xff8FC31F)
          : StringNumber == '공항'?    const Color(0xff0090D2)
          : StringNumber == '경의중앙'? const Color(0xff77C4A3)
          : StringNumber == '경춘'?    const Color(0xff0C8E72)
          : StringNumber == '수인분당'? const Color(0xFFE7E727)
          : StringNumber == '신분당'?   const Color(0xffD4003B)
          : StringNumber == '경강선'?   const Color(0xff003DA5)
          : StringNumber == '인천1선'?  const Color(0xff7CA8D5)
          : StringNumber == '인천2선'?  const Color(0xffED8B00)
          : StringNumber == '에버라인'?  const Color(0xff6FB245)
          : StringNumber == '의정부'?   const Color(0xffFDA600)
          : StringNumber == '우이신설'? const Color(0xffB7C452)
          : StringNumber == '김포골드'? const Color(0xffA17800)
          : StringNumber == '신림'?   const Color(0xff6789CA)
          : Colors.black,
    );
  }
}