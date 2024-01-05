import 'package:actual_project/common/const/data.dart';
import 'package:actual_project/common/layout/default_layout.dart';
import 'package:actual_project/common/view/root_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../user/view/login_screen.dart';
import '../const/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // initState는 await할 수 없다.
    super.initState();


    //deleteToken();
    checkToken();
  }

  void deleteToken() async {
    await storage.deleteAll();
  }


  void checkToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    // 만약에 꺼지지 않은채로 하루이상 켜져 있으면 refresh token 검증은? 아직 하지 않았다 나중에
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final dio = Dio();

    try {
      final resp = await dio.post(
        'http://$ip/auth/token',
        options: Options(
          headers: {
            'authorization': 'Bearer $refreshToken',
          },
        ),
      );

      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.data['accessToken']);
      // refreshToken이 accessToken 갱신해서 -> 이제는 5분이 지나도 splashScreen에서 오류가 뜨지 않는다.강의 중간에 가면 자동갱신 추가된다.

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => RootTab(),
        ),
            (route) => false,
      );
    } catch (e) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        ),
            (route) => false,
      );
    }
  }
    // checkToken 함수를 통해 login이냐 rootTab이냐를 결정 / 유효성 검증도 필요하기에 추후 코드 작성 할것
    @override
    Widget build(BuildContext context) {
      return DefaultLayout(
        backgroundColor: PRIMARY_COLOR,
        child: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/img/logo/logo.png',
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2,
              ),
              const SizedBox(height: 16.0),
              CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ),
      );
    }
  }

