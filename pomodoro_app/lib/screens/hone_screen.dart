import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer; // 데이터 형 앞에 late를 붙이면 초기화는 필요하지만 변수가 선언되었을때가 아닌 아닌다른 타이밍, 컨포넌트 사용전에 초기화할수 있도록 함

  void onTick(Timer timer){ // 매초마다 실행 되는 method

    if(totalSeconds == 1){
      // 0이면 이미 중지된상태이기떄문에 1초일때 초기화하도록 설정 
      setState(() {
        totalPomodoros += 1;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    }else{
      setState(() {
      totalSeconds -= 1;
    });
    }
  }

  void onStartPressed(){
      timer = Timer.periodic(
      const Duration(seconds: 1)
      , onTick);// 매초마다 onTick함수를 실행
      // Duration 시간마다 두의 매개변수(함수)실행
      // onTick뒤에 괄호가 없는 이유는 ()가 붙으면 지금 실행하겠다는 의미이지만 저 함수가 실행되는건 함수호출하자마자 바로 실행하는것이 아니기에 지움
      setState(() {
        isRunning = true;
      });
  }

  void onPausePressd(){
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onReset(){
    if(!isRunning){
      setState(() {
        totalSeconds = twentyFiveMinutes;
        totalPomodoros = 0;
      });

    }
    
  }

  String format(int seconds){
    var duration = Duration(seconds: seconds); 
    // 초단위로 표시하기 위해 00:00:00 형태로 변경 -> 밀리세컨드 단위자르기 위해 "."으로 문자열 나누고 -> 첫번째 "."을 제외하고 2번째부터 7번째까지 자르기
    return duration.toString().split(".").first.substring(2,7); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,//하드코딩 값을 만들어줌 각각 넣는것이아닌 ui별로 고정값을 생성해줌, 비율 지정
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600
                  ),
                ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: IconButton(
                iconSize: 120,
                color: Theme.of(context).cardColor,
                onPressed: isRunning? onPausePressd : onStartPressed,
                icon: Icon(isRunning? Icons.pause_circle_outline  : Icons.play_circle_outline),
              ),
          ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                            style: TextStyle(
                            fontSize: 20,
                            fontWeight : FontWeight.w600,
                            color: Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                        Text(
                          '$totalPomodoros',
                              style: TextStyle(
                              fontSize: 58,
                              fontWeight : FontWeight.w600,
                              color: Theme.of(context).textTheme.displayLarge!.color,
                            ),
                          ),  
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ) 
        ],
      ),
    );
  }
}