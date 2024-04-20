import 'package:flutter/material.dart';
import 'package:flutter_recaptcha_v2_compat/flutter_recaptcha_v2_compat.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Google ReCaptcha Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String verifyResult = "";

  RecaptchaV2Controller recaptchaV2Controller = RecaptchaV2Controller();

  @override
  void dispose() {
    recaptchaV2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RecaptchaV2(
                    apiKey: "6LfXp1UpAAAAAEku9BSeBt6JJxXrlvtYjh--X4D7",
                    apiSecret: "6LfXp1UpAAAAAIFVynIPkooVWZi5qN8u16SYJTVt",
                    controller: recaptchaV2Controller,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 24),
                    onVerifiedError: (err) {
                      print(err);
                    },
                    onVerifiedSuccessfully: (success) {
                      setState(() {
                        if (success) {
                          verifyResult = "You've been verified successfully.";
                        } else {
                          verifyResult = "Failed to verify.";
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    child: Text("Reload ReCAPTCHA"),
                    onPressed: () => recaptchaV2Controller.reload(),
                  ),
                  Text(verifyResult),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}