import 'package:flutter/material.dart';

class bottomsheet {
  static void showbottomsheet(context) {
    Size size = MediaQuery.of(context).size;
    final passController = TextEditingController();
    final passKey = GlobalKey<FormState>();
    bool hide = false;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context,setState) {
              return Container(
                padding: EdgeInsets.all(10),
                // color: Colors.pink,
                height: 180,
                width: size.width,
                child: Column(
                  children: [
                    Text(
                      'Nhập mã bảo mật',
                      style: TextStyle(
                        fontFamily: 'Roboto Medium',
                        fontSize: 20,
                      ),
                    ),
                    Form(
                      key: passKey,
                      child: TextFormField(
                        obscureText: hide,
                        obscuringCharacter:'*',
                        controller: passController,
                        decoration:
                            InputDecoration(suffixIcon: IconButton(onPressed: (){
                              setState(() {
                                 hide = !hide;
                              },);
                             
                            },icon: Icon(hide?Icons.visibility_off:Icons.visibility))),
                        validator: (value) {
                          if (value.isEmpty || value == null) {
                            return 'Mã bảo mật không được để trống';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'HỦY',
                            style: TextStyle(
                                fontFamily: 'Roboto Medium',
                                fontSize: 14,
                                letterSpacing: 1.25,
                                color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if(passKey.currentState.validate()){
                                
                              }

                            },
                            child: Text(
                              'XÁC NHẬN',
                              style: TextStyle(
                                  fontFamily: 'Roboto Medium',
                                  fontSize: 14,
                                  letterSpacing: 1.25,
                                  color: Colors.white),
                            )),
                      ],
                    ),
                  ],
                ),
              );
            }
          );
        });
  }
}
