import 'package:flutter/material.dart';



var appBarHeight = AppBar().preferredSize.height;

callNext(var className, var context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => className),
  );
}

callNextReplacement(var className, var context){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => className),
  );
}
void finish(context) {
  Navigator.pop(context);
}

