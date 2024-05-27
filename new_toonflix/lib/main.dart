import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_toonflix/button_main.dart';

void main(){
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  // List<int> numbers =[];

  // void onCliked(){
  //   setState(() { // dart를 다시 실행하면서 ui build를 하게함
  //     //데이터 코드는 굳이 안에 넣지 않아도 동작은 되지만 가독성이나 수정의 용이성을위해 함수 내에 작성
  //     numbers.add(numbers.length);
  //   });
    
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //buildContext에서 다른 함수에서도 build에 있는값을 사용할수 있도록하기위해 선언해아여 사용함 
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.red,
          )
          )
        ),
      home: const Scaffold(
        backgroundColor: Color(0xFFF4EDDB),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               MyLargeTitle()
            ],
          ),
        ),
      ),
    );
  }
}

//이벤트를 인식하도록 하기위해 StatelessWidget -> StatefulWidget으로변경
class MyLargeTitle extends StatefulWidget {
  const MyLargeTitle({
    super.key,
  });

  @override
  State<MyLargeTitle> createState() => _MyLargeTitleState();
}

class _MyLargeTitleState extends State<MyLargeTitle> {

  int coutn = 0; 
  // 필드변수로 초기화 가능하기 때문에 해당 함수를 override해줄 필요는 없음
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Text(
     'My Large Title '
     //colors:Theme.of(context).textTheme.titleLarge.color 를 쓸수있지만 dart는 null이 발생하기를 원하지 않기때문에 부모에 선언된 theme에 color값이 없을경우 null이기 때문에
     //color에 값이 있다는것을 명시해줄 필요가 있음  "!"는 해당 값이 꼭 존재한다는 강력한 확신을 의미함
     //"?"는 값이 있을경우 그 값을 사용하라는 의미함 ex)titleLarge?.color 라고 하면 titleLarge에 color값이 있다면 사용하세요 라는 의미  
     , style: TextStyle(fontSize: 30, color:Theme.of(context).textTheme.titleLarge!.color),
    );
  }
}
