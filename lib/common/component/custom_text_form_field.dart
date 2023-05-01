import 'package:flutter/material.dart';
import 'package:actual_project/common/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
    required this.onChanged,
    Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
        borderSide: BorderSide(
          color: INPUT_BORDER_COLOR,
          width: 1.0,
        )
    );

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      // 비밀번호 입력할때
      obscureText: obscureText,
      // 자동으로 focus 되는거
      autofocus: autofocus,
      onChanged: onChanged,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: hintText,
          errorText: errorText,
          hintStyle: TextStyle(
            color: BODY_TEXT_COLOR,
            fontSize: 14.0,
          ),
          fillColor: INPUT_BG_COLOR,
          filled: true,
          // true - 배경색 있음 / false - 배경색 없음
          border: baseBorder,
          focusedBorder: baseBorder.copyWith(
              borderSide: baseBorder.borderSide.copyWith(
                color: PRIMARY_COLOR,
              )
          )
        // border 파라미터는 모든 INPUT 상태의 기본 스타일 세팅
      ),
    );
  }
}
