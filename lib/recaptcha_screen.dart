import 'package:flutter/material.dart';
import 'package:flutter_recaptcha_v2_compat/flutter_recaptcha_v2_compat.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final RecaptchaV2Controller _recaptchaV2Controller = RecaptchaV2Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('reCAPTCHA v2 Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RecaptchaV2(
              apiKey: 'YOUR_RECAPTCHA_SITE_KEY',
              controller: _recaptchaV2Controller,
              onVerifiedSuccessfully: () {
                String? token = _recaptchaV2Controller.getResponseToken();
                if (token != null) {
                  _sendTokenToBackend(token);
                } else {
                  print('Failed to get reCAPTCHA token');
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Get the reCAPTCHA response token
                String? token = await _recaptchaV2Controller.getVerifiedToken();

                if (token != null) {
                  // Token obtained successfully, now send it to the backend API
                  await _sendTokenToAPI(token);
                } else {
                  // Token retrieval failed
                  print('Failed to get reCAPTCHA token');
                }
              },
              child: Text('Verify and Send Token'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendTokenToAPI(String token) async {
    final url = 'YOUR_BACKEND_API_URL'; // Replace with your backend API endpoint
    final response = await http.post(
      Uri.parse(url),
      body: {
        'token': token,
      },
    );

    if (response.statusCode == 200) {
      // API call successful
      print('Token verification successful!');
      _showDialog('Token Verification', 'Token verified successfully.');
    } else {
      // API call failed
      print('Token verification failed. Status code: ${response.statusCode}');
      _showDialog('Token Verification', 'Token verification failed.');
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}