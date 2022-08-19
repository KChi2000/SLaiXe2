import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slaixe2/lenh/LenhVanChuyen.dart';

import 'hang/Hang.dart';
import 'home/Home.dart';
import 'lenh/Lenh.dart';
import 'taikhoan/TaiKhoan.dart';
import 'thongbao/ThongBao.dart';
import 've/Ve.dart';

class BottomBar extends StatefulWidget {
   int index;
  BottomBar(this.index);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
   var _selectedIndex=0;

  final _tabPages = [
    Home(),
    Ve(),
    Lenh(),
    Hang(),
    ThongBao(),
    TaiKhoan(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.index== 2){
      _selectedIndex = 2;
    }
   else if(widget.index==3){
      _selectedIndex = 3;
    }
   else if(widget.index==1){
      _selectedIndex = 1;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _tabPages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "asset/icons/homereal.svg",
                color: _selectedIndex == 0
                    ? Colors.black
                    : Color.fromARGB(255, 83, 82, 82),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("asset/icons/ticket.svg",
                  color: _selectedIndex == 1
                      ? Colors.black
                      : Color.fromARGB(255, 83, 82, 82)),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("asset/icons/home.svg",
                  color: _selectedIndex == 2
                      ? Colors.black
                      : Color.fromARGB(255, 83, 82, 82)),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("asset/icons/h.svg",
                  color: _selectedIndex == 3
                      ? Colors.black
                      : Color.fromARGB(255, 83, 82, 82)),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("asset/icons/bell.svg",
                  color: _selectedIndex == 4
                      ? Colors.black
                      : Color.fromARGB(255, 83, 82, 82)),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("asset/icons/account.svg",
                  color: _selectedIndex == 5
                      ? Colors.black
                      : Color.fromARGB(255, 83, 82, 82)),
              label: ''),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.brown,
        onTap: (_onItemTapped),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
    void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
   
  }
}



