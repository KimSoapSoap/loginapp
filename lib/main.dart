import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/login",
      routes: {
        "/login": (context) => LoginPage(),
        "/home": (context) => HomePage(),
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Input은 Column이 아니라 ListView로 한다.
        body: ListView(
      children: [
        //이때 컨테이너의 가로 길이는 textFormField
        Container(
          height: 500,
          color: Colors.yellow,
        ),
        TextFormField(
          onTap: ScrollActivity.,
          controller: username,
          decoration: InputDecoration(
            hintText: "Username",
            prefixIcon: Icon(Icons.person),
          ),
        ),
        TextFormField(
          controller: password,
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Password",
            prefixIcon: Icon(Icons.password),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              // 여기에 통신, 화면이동을 모두 하면 SRP 위반이다.
              // 그렇기 때문에 Service, Repository같은 것들이 필요하다.
              // 그래서 userService.로그인(un, pw) 이런식으로 보내줘야 한다.

              // 이 1, 2, 3 과정은 동기로 처리해야 한다. 로그인이 안 됐는데 화면이 이동해버리면 정보를 출력 못 한다.
              // 만약 async await에서 이 로그인 과정이 있다 해도 이 1,2,3은 같은 트랜잭션으로 묶어야 한다.

              // 1.값 가져오기
              String un = username.text;
              String pw = password.text;
              print(un);
              print(pw);

              // 2.통신하기

              // 3.화면이동 (A -> B)
              // [A, B] pushName -> 이전 페이지 기록이 남는다.
              // [B] pushReplaceName -> 이전 페이지 기록을 대체한다.
              // [B] pushReplaceNameRevmoeUntil -> 이전 페이지 기록을 다 지운다.

              //뒤로가기가 가능하게 스택에 남기는 것
              Navigator.pushNamed(context, "/home");

              //이렇게 해주면 대체하기 때문에 뒤로가기가 되지 않는다. 첫 화면일 경우 앱이 종료됨
              //Navigator.pushReplacementNamed(context, "/home");
            },

            //버튼 이름
            child: Text("로그인"))
      ],
    ));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                //Navigator.pushNamed(context, "/login"); //[ A, B, A]
                //Navigator.pushReplacementNamed(context, "/login"); // [A, A]
                //Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => true); // [A]  -> 얘는 적어놨던 ssar, 1234 안 남아 있다.
                Navigator.pop(
                    context); // [A]  // appBar의 Navigator는 화면이 넘어왔을 때 뒤로가기 버튼이 생기는데 그 기능이 Navigator.pop()이다.
              },
              child: Text("뒤로가기"))),
    );
  }
}
