// FutureBuilder(
//             future: loadapi(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else if (datadsxedukientheokehoach.data != null &&
//                   datadslaixedukientheokehoach != null &&
//                   datachitietkehoach.data != null &&
//                   datadsxedukientheokehoach.message == 'Thành công' &&
//                   datadslaixedukientheokehoach.message == 'Thành công' &&
//                   datachitietkehoach.message == 'Thành công') {
//                 return Column(
//                   // mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.max,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(10),
//                       child: Column(
//                         children: [
//                           RowTextItem(
//                               'asset/icons/road-variant.svg', 24, widget.lotrinh),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               RowTextItem('asset/icons/calendar.svg', 24,
//                                   widget.time.substring(0, widget.time.length - 3)),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               RowTextItem('asset/icons/bus-stop.svg', 24,
//                                   widget.tenbenxedi),
//                             ],
//                           ),
//                           formsuakehoach(
//                               bienkiemsoatkey: bienkiemsoatkey,
//                               datadsxedukientheokehoach: datadsxedukientheokehoach,
//                               datadslaixedukientheokehoach:
//                                   datadslaixedukientheokehoach),
//                           DropdownButtonFormField(
//                             decoration:
//                                 InputDecoration(labelText: 'Lái xe đi cùng'),
//                             items: datadslaixedukientheokehoach.data.map((text) {
//                               return new DropdownMenuItem(
//                                 child:  Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Checkbox(
//                                           value: text.check, onChanged: (value) {}),
//                                       Container(
//                                           child: Text(text.hoTen,
//                                               style: TextStyle(
//                                                   fontFamily: 'Roboto Regular',
//                                                   fontSize: 16)))
//                                     ],
//                                   ),
                           
//                                 value: text.dienThoai,
//                               );
//                             }).toList(),
//                             // value: 'Bến xe Hà Nam',
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedItem.add(value);
//                               });
//                             },
//                             selectedItemBuilder: (context) {
//                               return selectedItem
//                                   .map((e) => Chip(
//                                           label: Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Text(e),
//                                           GestureDetector(
//                                             onTap: () {
//                                               setState(() {
//                                                 // selectedItem.remove(e);
//                                               });
//                                             },
//                                             child: Container(
//                                                 padding: EdgeInsets.all(1),
//                                                 decoration: BoxDecoration(
//                                                     shape: BoxShape.circle,
//                                                     color: Colors.grey),
//                                                 child: Icon(
//                                                   Icons.close,
//                                                   size: 15,
//                                                   color: Colors.white,
//                                                 )),
//                                           )
//                                         ],
//                                       )))
//                                   .toList();
//                             },

//                             menuMaxHeight: 400,
//                           ),
//                           Form(
//                             // key: formkey,
//                             child: TextFormField(
//                               decoration: InputDecoration(labelText: 'Phụ xe'),
//                               controller: phuxeController,
//                               inputFormatters: [],
//                               validator: (value) {},
//                               onChanged: (value) {},
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Spacer(),
//                     Divider(
//                       color: Colors.black54,
//                       thickness: 0.2,
//                     ),
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 25),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: Text(
//                               'HỦY',
//                               style: TextStyle(
//                                   fontFamily: 'Roboto Medium',
//                                   fontSize: 14,
//                                   letterSpacing: 1.25,
//                                   color: HexColor.fromHex('#D10909')),
//                             ),
//                           ),
//                           ElevatedButton(
//                               onPressed: () {
//                                 if (bienkiemsoatkey.currentState.validate() &&
//                                     laixetiepnhanlenhkey.currentState.validate()) {}
//                               },
//                               child: Text(
//                                 'XÁC NHẬN',
//                                 style: TextStyle(
//                                     fontFamily: 'Roboto Medium',
//                                     fontSize: 14,
//                                     letterSpacing: 1.25,
//                                     color: Colors.white),
//                               ))
//                         ],
//                       ),
//                     )
//                   ],
//                 );
//               }

//               return Center(
//                   child: Text(
//                 'Không có dữ liệu',
//                 style: TextStyle(fontFamily: 'Roboto Regular', fontSize: 14),
//               ));
//             },
//           )