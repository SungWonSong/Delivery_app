import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// localhost - 기본 emulatorIp / simulatorIp
final emulatorIp = '10.0.2.2:3000';
final simulatorIp = '127.0.0.1:3000';


// 모바일 Ios / android 사용을 한다 (삼항 연산자)
final ip = Platform.isIOS ? simulatorIp : emulatorIp;

final storage = FlutterSecureStorage();

