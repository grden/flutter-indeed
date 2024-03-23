// import 'package:flutter/material.dart';
// import 'package:self_project/model/model_teacher.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: ''),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   final String title;
//
//   const MyHomePage({
//     super.key,
//     required this.title,
//   });
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   List<bool> isSelected = [true, false, false];
//   List<Subject> subjectList = [Subject.math, Subject.english, Subject.korean];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Ink(
//           width: 200,
//           height: 100,
//           color: Colors.white,
//           child: GridView.count(
//             primary: true,
//             crossAxisCount: 2, //set the number of buttons in a row
//             crossAxisSpacing: 8, //set the spacing between the buttons
//             mainAxisSpacing: 8,
//             childAspectRatio: 2, //set the width-to-height ratio of the button,
//             physics: const NeverScrollableScrollPhysics(),
//             children: List.generate(isSelected.length, (newIndex) {
//               //using Inkwell widget to create a button
//               return InkWell(
//                   splashColor: Colors.yellow, //the default splashColor is grey
//                   onTap: () {
//                     //set the toggle logic
//                     final isOneSelected =
//                         isSelected.where((element) => element).length == 1;
//
//                     if (isOneSelected && isSelected[newIndex]) return;
//
//                     setState(() {
//                       // looping through the list of booleans
//                       for (int index = 0; index < isSelected.length; index++) {
//                         // checking for the index value
//                         if (index == newIndex) {
//                           // toggle between the old index and new index value
//                           isSelected[index] = !isSelected[index];
//                         }
//                       }
//                     });
//                   },
//                   child: Ink(
//                     decoration: BoxDecoration(
//                       //set the background color of the button when it is selected/ not selected
//                       color:
//                       isSelected[newIndex] ? const Color(0xffD6EAF8) : Colors.white,
//                       // here is where we set the rounded corner
//                       borderRadius: BorderRadius.circular(8),
//                       //don't forget to set the border,
//                       //otherwise there will be no rounded corner
//                       border: Border.all(color: Colors.red),
//                     ),
//                     child: Center(child: Text(subjectList[newIndex].subjectString),),
//                   ));
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }
