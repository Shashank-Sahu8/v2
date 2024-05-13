import 'package:flutter/material.dart';
import 'package:recaptcha_testing/recaptcha_screen.dart';

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
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>RecaptchaWidget()));},child: Text("verify"),),
      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Container Stack'),
//         ),
//         body: ContainerStack(),
//       ),
//     );
//   }
// }
//
// class ContainerStack extends StatefulWidget {
//   @override
//   _ContainerStackState createState() => _ContainerStackState();
// }
//
// class _ContainerStackState extends State<ContainerStack> {
//   bool isContainerVisible = false;
//
//   void toggleContainerVisibility() {
//     setState(() {
//       isContainerVisible = !isContainerVisible;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Bottom container
//         Container(
//           color: Colors.blue,
//           height: 200,
//           width: MediaQuery.of(context).size.width,
//         ),
//         // Top container (may be invisible)
//         Visibility(
//           visible: isContainerVisible,
//           child: GestureDetector(
//             onTap: toggleContainerVisibility,
//             child: Container(
//               color: Colors.black.withOpacity(0.2), // Transparent red
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               child: Center(
//                   child:CircularProgressIndicator()
//               ),
//             ),
//           ),
//         ),
//         // Button to toggle visibility
//         Positioned(
//           bottom: 20,
//           left: MediaQuery.of(context).size.width / 2 - 50,
//           child: ElevatedButton(
//             onPressed: toggleContainerVisibility,
//             child: Text(isContainerVisible ? 'Hide' : 'Show'),
//           ),
//         ),
//       ],
//     );
//   }
// }
