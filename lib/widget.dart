
import 'package:flutter/material.dart';

var size, height, width;

const textInputDecorationwhite = InputDecoration(
  errorStyle: TextStyle(fontWeight: FontWeight.w500),
  hintStyle: TextStyle(color: Colors.white),
  labelStyle: TextStyle(color: Colors.white),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(12))),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(12))),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        // width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(12))),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(12))),
);
const textInputDecorationgrey = InputDecoration(
  errorStyle: TextStyle(fontWeight: FontWeight.w400),
  hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
  labelStyle: TextStyle(color: Colors.grey),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(12))),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(12))),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        // width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(12))),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(12))),
);
const textInputDecorationblue= InputDecoration(
  errorStyle: TextStyle(fontWeight: FontWeight.w400),
  hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
  labelStyle: TextStyle(color: Colors.grey),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(12))),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(12))),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        // width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(12))),
  focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(12))),
);
nextscreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}
void successSnackbar(context, text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      // padding: EdgeInsets.only(top: 150),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 150,
        left: 10,
        right: 10,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.green,
      elevation: 10,
      content: Row(
        children: [
          Icon(
            Icons.verified,
            color: Colors.white,
          ),
          SizedBox(width: 5),
          Text(text),
        ],
      )));
}

AnimationController? localAnimationController;
// void errorSnackbar(context, text) {
//   Flushbar(
//     title: text,
//     backgroundColor: Colors.green,
//     flushbarPosition: FlushbarPosition.TOP,
//   );
// }
void errorSnackbar(context, text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100,
        left: 10,
        right: 10,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.red,
      elevation: 10,
      content: Row(
        children: [
          Icon(
            Icons.error,
            color: Colors.white,
          ),
          SizedBox(width: 5),
          Column(
            children: [
              Text(text),
            ],
          ),
        ],
      )));
}
