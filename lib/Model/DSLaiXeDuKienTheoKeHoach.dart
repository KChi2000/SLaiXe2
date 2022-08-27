class DSLaiXeDuKienTheoKeHoach {
  bool status;
  String message;
  int errorCode;
  List<ThongTinLaiXe> data;

  DSLaiXeDuKienTheoKeHoach(
      {this.status, this.message, this.errorCode, this.data});

  DSLaiXeDuKienTheoKeHoach.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <ThongTinLaiXe>[];
      json['data'].forEach((v) {
        data.add(new ThongTinLaiXe.fromJson(v));
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

class ThongTinLaiXe {
  String idDnvtLaiXeHoatDongTuyen;
  String idDnvtLaiXe;
  String idDnvtTuyen;
  String ngayBatDau;
  String ngayKetThuc;
  String hdSo;
  String hdNgayHieuLuc;
  String hdNgayHetHan;
  String hoTen;
  String gplxMaSo;
  String gplxHang;
  String gplxNgayCap;
  String gplxThoiHanHieuLuc;
  String gplxNoiCap;
  String gioiTinh;
  String ngaySinh;
  String dienThoai;
  String diaChi;
  int laiXeHoatDongTrenTuyen;
  bool check = false;

  ThongTinLaiXe(
      {this.idDnvtLaiXeHoatDongTuyen,
      this.idDnvtLaiXe,
      this.idDnvtTuyen,
      this.ngayBatDau,
      this.ngayKetThuc,
      this.hdSo,
      this.hdNgayHieuLuc,
      this.hdNgayHetHan,
      this.hoTen,
      this.gplxMaSo,
      this.gplxHang,
      this.gplxNgayCap,
      this.gplxThoiHanHieuLuc,
      this.gplxNoiCap,
      this.gioiTinh,
      this.ngaySinh,
      this.dienThoai,
      this.diaChi,
      this.laiXeHoatDongTrenTuyen,
      this.check});

  ThongTinLaiXe.fromJson(Map<String, dynamic> json) {
    idDnvtLaiXeHoatDongTuyen = json['IdDnvtLaiXeHoatDongTuyen'];
    idDnvtLaiXe = json['IdDnvtLaiXe'];
    idDnvtTuyen = json['IdDnvtTuyen'];
    ngayBatDau = json['NgayBatDau'];
    ngayKetThuc = json['NgayKetThuc'];
    hdSo = json['HdSo'];
    hdNgayHieuLuc = json['HdNgayHieuLuc'];
    hdNgayHetHan = json['HdNgayHetHan'];
    hoTen = json['HoTen'];
    gplxMaSo = json['GplxMaSo'];
    gplxHang = json['GplxHang'];
    gplxNgayCap = json['GplxNgayCap'];
    gplxThoiHanHieuLuc = json['GplxThoiHanHieuLuc'];
    gplxNoiCap = json['GplxNoiCap'];
    gioiTinh = json['GioiTinh'];
    ngaySinh = json['NgaySinh'];
    dienThoai = json['DienThoai'];
    diaChi = json['DiaChi'];
    laiXeHoatDongTrenTuyen = json['LaiXeHoatDongTrenTuyen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdDnvtLaiXeHoatDongTuyen'] = this.idDnvtLaiXeHoatDongTuyen;
    data['IdDnvtLaiXe'] = this.idDnvtLaiXe;
    data['IdDnvtTuyen'] = this.idDnvtTuyen;
    data['NgayBatDau'] = this.ngayBatDau;
    data['NgayKetThuc'] = this.ngayKetThuc;
    data['HdSo'] = this.hdSo;
    data['HdNgayHieuLuc'] = this.hdNgayHieuLuc;
    data['HdNgayHetHan'] = this.hdNgayHetHan;
    data['HoTen'] = this.hoTen;
    data['GplxMaSo'] = this.gplxMaSo;
    data['GplxHang'] = this.gplxHang;
    data['GplxNgayCap'] = this.gplxNgayCap;
    data['GplxThoiHanHieuLuc'] = this.gplxThoiHanHieuLuc;
    data['GplxNoiCap'] = this.gplxNoiCap;
    data['GioiTinh'] = this.gioiTinh;
    data['NgaySinh'] = this.ngaySinh;
    data['DienThoai'] = this.dienThoai;
    data['DiaChi'] = this.diaChi;
    data['LaiXeHoatDongTrenTuyen'] = this.laiXeHoatDongTrenTuyen;
    return data;
  }
}
