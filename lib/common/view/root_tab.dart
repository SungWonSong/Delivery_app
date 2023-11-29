import 'package:actual_project/common/const/colors.dart';
import 'package:actual_project/common/layout/default_layout.dart';
import 'package:actual_project/restaurant/view/restaurant_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab>
    with
        SingleTickerProviderStateMixin {
  late TabController controller;
  // late를 사용하는 목적 : late키워드는 값의 초기화를 뒤로 미루지만, 개발자가 null을 실수로 사용하는것을 막아준다.

  int index = 0;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 4, vsync: this);
    // this를 사용할때에는 SingleTickerProviderStateMixin을 무조건 넣어줘야 한다.

    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener(){
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
          // physics에 위의 값을 넣으면 옆으로 스와이프가 되지 않는다.
          controller: controller,
          children: [
            RestaurantScreen(),
            Center(child: Container(child: Text('음식'))),
            Center(child: Container(child: Text('주문'))),
            Center(child: Container(child: Text('프로필'))),
          ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        //type은 values, shifting, fixed로 animation효과라 생각하면 좋다.

        onTap: (int index) {
          controller.animateTo(index);
        }, // set
        currentIndex: index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood_outlined), label: '음식'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined), label: '주문'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined), label: '프로필'),
        ],
      ),
    );
  }
}
