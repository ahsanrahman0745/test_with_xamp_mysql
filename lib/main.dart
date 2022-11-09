import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trying Xammp First Time',
      home: const Xampp(),
      theme: ThemeData(
          colorScheme: const ColorScheme.highContrastDark()
      ),
    );
  }
}

class Xampp extends StatefulWidget {
  const Xampp({Key? key}) : super(key: key);

  @override
  State<Xampp> createState() => _XamppState();
}

class _XamppState extends State<Xampp> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  Future<void> _login() async {
    var success = false;
    var data =<String, String> {
      "name": namecontroller.text,
      'password': passwordcontroller.text,
    };
    if (namecontroller.text != '' || passwordcontroller.text != '') {
      try {
        final baseurl = "http://192.168.64.2";
        final url = "$baseurl/practice_api/insert_record.php";
        var res = await http.post(
            Uri.parse(url),
            body: data);
        final response = jsonDecode(res.body);
        success = response["result"] == "Success";
      } catch (e) {
        print("Catched an error!");
        print(e);
        success = false;
      }
    }
    if (success == "true") {
      print('Record Inserted');
      namecontroller.text = "";
      passwordcontroller.text = "";
    }
    else {
      print('Some issue');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        child:Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: namecontroller,
              decoration:const InputDecoration(
                hintText: 'Enter What people call you i-e name ',
                icon: Icon(Icons.account_circle_sharp),
                labelText: 'Name',

              ) ,
            ),
            TextFormField(
              controller: passwordcontroller,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                icon: Icon(Icons.lock),
                labelText: 'Password',
              ),
            ),
            ElevatedButton(onPressed: (){
              _login();
            },
                child: const Text('Insert')
            ),
          ],
        ) ,
      ),
    );
  }
}
