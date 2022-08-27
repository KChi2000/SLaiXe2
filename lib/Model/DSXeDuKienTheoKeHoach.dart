class DSXeDuKienTheoKeHoach {
  bool status;
  String message;
  int errorCode;
  List<XeDuKienTheoKeHoach> data;

  DSXeDuKienTheoKeHoach({this.status, this.message, this.errorCode, this.data});

  DSXeDuKienTheoKeHoach.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <XeDuKienTheoKeHoach>[];
      json['data'].forEach((v) {
        data.add(new XeDuKienTheoKeHoach.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['errorCode'] = this.errorCode;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class XeDuKienTheoKeHoach {
  String idDnvtXePhuHieuTuyen;
  String idDnvtXe;
  int trongTai;
  String idDnvtTuyen;
  int soGiuong;
  String idXe;
  int soGhe;
  String bienKiemSoat;
  String phuHieuNgayCap;
  String phuHieuNgayHetHan;

  XeDuKienTheoKeHoach(
      {this.idDnvtXePhuHieuTuyen,
      this.idDnvtXe,
      this.trongTai,
      this.idDnvtTuyen,
      this.soGiuong,
      this.idXe,
      this.soGhe,
      this.bienKiemSoat,
      this.phuHieuNgayCap,
      this.phuHieuNgayHetHan});

  XeDuKienTheoKeHoach.fromJson(Map<String, dynamic> json) {
    idDnvtXePhuHieuTuyen = json['IdDnvtXePhuHieuTuyen'];
    idDnvtXe = json['IdDnvtXe'];
    trongTai = json['TrongTai'];
    idDnvtTuyen = json['IdDnvtTuyen'];
    soGiuong = json['SoGiuong'];
    idXe = json['IdXe'];
    soGhe = json['SoGhe'];
    bienKiemSoat = json['BienKiemSoat'];
    phuHieuNgayCap = json['PhuHieu_NgayCap'];
    phuHieuNgayHetHan = json['PhuHieu_NgayHetHan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdDnvtXePhuHieuTuyen'] = this.idDnvtXePhuHieuTuyen;
    data['IdDnvtXe'] = this.idDnvtXe;
    data['TrongTai'] = this.trongTai;
    data['IdDnvtTuyen'] = this.idDnvtTuyen;
    data['SoGiuong'] = this.soGiuong;
    data['IdXe'] = this.idXe;
    data['SoGhe'] = this.soGhe;
    data['BienKiemSoat'] = this.bienKiemSoat;
    data['PhuHieu_NgayCap'] = this.phuHieuNgayCap;
    data['PhuHieu_NgayHetHan'] = this.phuHieuNgayHetHan;
    return data;
  }
}
