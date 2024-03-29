import 'dart:convert';
import 'dart:io';

import 'package:actual_project/common/const/colors.dart';
import 'package:actual_project/common/const/data.dart';
import 'package:actual_project/common/layout/default_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../common/component/custom_text_form_field.dart';
import '../../common/view/root_tab.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    return DefaultLayout(
      child: SingleChildScrollView(
        // SingleChildScrollView를 통해서 올라오는 키보드에 따라 오류가 안걸리게 된다.
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        // onDrag시에 올라오는 키보드를 드래그를 함으로써 자동으로 내려가게 한다.
        child: SafeArea(
          top: true,
          bottom: false,
          // SafeArea 사용시 안보이는 부분에 대한 최적의 부분 제공
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                const SizedBox(height: 16.0),
                _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
              // 현재 화면의 너비 2/3 크기를 가진다. width:폭(가로) / height: 높이(세로)
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요.',
                  errorText: '에러가 있습니다.',
                  onChanged: (String value) {
                    username = value;
                  },
                ),
                const SizedBox(height: 5.0),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요.',
                  errorText: '에러가 있습니다.',
                  onChanged: (String value) {
                    password = value;
                  }, // (String value) 값에서 value를 출력하면 CustomTextFormField에 입력되는 값을 죄다 출력,
                     // 이것을 username(or password)로 rawString에 넣어서 인코딩하면 access(and refresh) 토큰 발급되는 형태
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    // '$username:$password'; = 'example인 test@codefactory.ai:testtest
                    final rawString = '$username:$password';

                    Codec<String, String> stringToBase64 = utf8.fuse(base64);
                    // utf8은 일반적으로쓰는 인코딩 코덱, 이부분은 반복사용(Base64로 인코딩하는법)

                    String token = stringToBase64.encode(rawString);

                    final resp = await dio.post(
                      'http://$ip/auth/login',
                      options: Options(
                        headers: {
                          'authorization': 'Basic $token',
                        },
                      ),
                    );
                    final refreshToken = resp.data['refreshToken'];
                    final accessToken = resp.data['accessToken'];
                    //resp.data는 무조건 위의 header 부분에서 생성이 되기 때문에 키값으로 불러올 수 있다.

                    await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
                    await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RootTab(),
                      ),
                    ); // Navigator를 사용하여 페이지 슬라이딩
                  },
                  style: ElevatedButton.styleFrom(
                    primary: PRIMARY_COLOR,
                  ),
                  child: Text('로그인'),
                ),
                TextButton(
                  onPressed: () async {

                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: Text('회원가입'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길 :)',

      // \n은 줄바꿈을 의미한다, String 값안에서 줄바꿈가능
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
