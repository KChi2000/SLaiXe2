class customModel{
  List danhSachGioXuatBen;
  String idLuongTuyen;
  String ngayXuatBenKeHoach;
  String timKiem;
  customModel(this.danhSachGioXuatBen,this.idLuongTuyen,this.ngayXuatBenKeHoach,this.timKiem);
   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['danhSachGioXuatBen'] = this.danhSachGioXuatBen;
    data['idLuongTuyen'] = this.idLuongTuyen;
    data['ngayXuatBenKeHoach'] = this.ngayXuatBenKeHoach;
    data['timKiem'] = this.timKiem;
   
}
}
class loadOptionsModel{
  String searchOperation;
  String searchValue;
    int skip;
    int take;
  Map<String,dynamic> userData; 
  loadOptionsModel(this.searchOperation,this.searchValue,this.skip,this.take,this.userData);
   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchOperation'] = this.searchOperation;
    data['searchValue'] = this.searchValue;
    data['skip'] = this.skip;
    data['take'] = this.take;
    data['userData'] = this.userData;
}
}
class postData{
 static customModel custom = customModel([], '', '2022-07-04T17:00:00.000Z', '');
 static loadOptionsModel loadOptions = loadOptionsModel('contains', null, 0, 20, {});
   static Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custom'] = custom.toJson();
    data['loadOptions'] = loadOptions.toJson(); 
}
}

 



    