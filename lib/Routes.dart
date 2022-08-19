import 'package:flutter/material.dart';
import 'package:slaixe2/lenh/LenhVanChuyen.dart';

class Routes{


static void navigatetoQuanLiLenh(BuildContext context){
  Navigator.push(context, MaterialPageRoute(builder: (context)=> LenhVanChuyen()));
}
}