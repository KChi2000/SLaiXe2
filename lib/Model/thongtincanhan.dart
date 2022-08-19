class thongtincanhan {
  bool status;
  String message;
  int errorCode;
  Data data;

  thongtincanhan({this.status, this.message, this.errorCode, this.data});

  thongtincanhan.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'].toString();
    errorCode = json['errorCode'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['errorCode'] = this.errorCode;
    data['data'] = this.data.toJson();
    
    return data;
  }
}

class Data {
  String hoTen;
  String ngaySinh;
  String soDienThoai;
  String email;
  String idTinh;
  String idHuyen;
  String diaChi;
  String diaChiThuongTru;
  int namBatDauHanhNghe;
  int soNamKinhNghiem;
  String soGPLX;
  String hangBang;
  String ngayBatDauHieuLuc;
  String thoiHanHieuLuc;
  String coQuanCap;
  String ngayCap;

  Data(
      {this.hoTen,
      this.ngaySinh,
      this.soDienThoai,
      this.email,
      this.idTinh,
      this.idHuyen,
      this.diaChi,
      this.diaChiThuongTru,
      this.namBatDauHanhNghe,
      this.soNamKinhNghiem,
      this.soGPLX,
      this.hangBang,
      this.ngayBatDauHieuLuc,
      this.thoiHanHieuLuc,
      this.coQuanCap,
      this.ngayCap});

  Data.fromJson(Map<String, dynamic> json) {
    hoTen = json['hoTen'].toString();
    ngaySinh = json['ngaySinh'].toString();
    soDienThoai = json['soDienThoai'].toString();
    email = json['email'].toString();
    idTinh = json['idTinh'].toString();
    idHuyen = json['idHuyen'].toString();
    diaChi = json['diaChi'].toString();
    diaChiThuongTru = json['diaChiThuongTru'].toString();
    namBatDauHanhNghe = json['namBatDauHanhNghe'];
    soNamKinhNghiem = json['soNamKinhNghiem'];
    soGPLX = json['soGPLX'].toString();
    hangBang = json['hangBang'].toString();
    ngayBatDauHieuLuc = json['ngayBatDauHieuLuc'].toString();
    thoiHanHieuLuc = json['thoiHanHieuLuc'].toString();
    coQuanCap = json['coQuanCap'].toString();
    ngayCap = json['ngayCap'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hoTen'] = this.hoTen.toString();
    data['ngaySinh'] = this.ngaySinh.toString();
    data['soDienThoai'] = this.soDienThoai.toString();
    data['email'] = this.email.toString();
    data['idTinh'] = this.idTinh.toString();
    data['idHuyen'] = this.idHuyen.toString();
    data['diaChi'] = this.diaChi.toString();
    data['diaChiThuongTru'] = this.diaChiThuongTru.toString();
    data['namBatDauHanhNghe'] = this.namBatDauHanhNghe;
    data['soNamKinhNghiem'] = this.soNamKinhNghiem;
    data['soGPLX'] = this.soGPLX.toString();
    data['hangBang'] = this.hangBang.toString();
    data['ngayBatDauHieuLuc'] = this.ngayBatDauHieuLuc.toString();
    data['thoiHanHieuLuc'] = this.thoiHanHieuLuc.toString();
    data['coQuanCap'] = this.coQuanCap.toString();
    data['ngayCap'] = this.ngayCap.toString();
    return data;
  }
}