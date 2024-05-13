import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui_web' as ui;
import 'dart:html' as html;

class RecaptchaWidget extends StatefulWidget {
  @override
  _RecaptchaWidgetState createState() => _RecaptchaWidgetState();
}

class _RecaptchaWidgetState extends State<RecaptchaWidget> {
  String createdViewId = 'recaptcha_element';
  String _token="empty";
  bool isContainerVisible = false;
bool isLoading=false;
  void toggleContainerVisibility() {
    setState(() {
      isContainerVisible = !isContainerVisible;
    });
  }
  void loadi() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    ui.platformViewRegistry.registerViewFactory(
      createdViewId,
          (int viewId) =>
      html.IFrameElement()
        ..style.height = 200.toString()
        ..style.width = 200.toString()
        ..src = '/assets/recaptcha.html'
        ..style.border = 'none',
    );
    html.window.onMessage.listen((msg) {
      String token = msg.data;
      print('Token received: $token');
      loadi();
      toggleContainerVisibility();
      setState(() {
        _token=token;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            Column(
                children: [
                  Text(_token,style: TextStyle(fontSize: 12),),

                  ElevatedButton(onPressed: () {
                    toggleContainerVisibility();
                  }, child: Text("hii")),

                ]),
            Visibility(
              visible: isLoading,
              child: GestureDetector(
                onTap: loadi,
                child: Container(
                  color: Colors.black.withOpacity(0.2), // Transparent red
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Center(child: Text("Success")),
                ),
              ),
            ),
          ],
        ),

        Visibility(
          visible: isContainerVisible,
          child: GestureDetector(
            onTap: toggleContainerVisibility,
            child: Container(
              color: Colors.black.withOpacity(0.2), // Transparent red
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Container(height:400,width:300,child: HtmlElementView(viewType: createdViewId)),
            ),
          ),
        ),
      ],


    );
  }
//   Future<void> _showRecaptchaDialog() async{
//     Completer<void> completer = Completer<void>();
//
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Dialog(
//           insetPadding: EdgeInsets.all(10.0),
//           child: Container(
//             width: double.infinity,
//             height: double.infinity,
//             constraints: BoxConstraints(
//               maxHeight: MediaQuery.of(context).size.height * 0.8,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 HtmlElementView(viewType: createdViewId),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     completer.complete();
//                   },
//                   child: Text("Close"),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//
//     // Wait until the dialog is closed
//     await completer.future;
//     // await showDialog(
//     //   context: context,
//     //   barrierDismissible: false,
//     //   builder: (BuildContext context) {
//     //     return Center(
//     //       child: HtmlElementView(viewType: createdViewId),
//     //
//     //       );
//     //   },
//     // );
//   }
// }
}

