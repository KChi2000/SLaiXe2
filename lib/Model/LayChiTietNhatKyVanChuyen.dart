class LayChiTietNhatKyVanChuyen {
  bool status;
  String message;
  int errorCode;
  DataNhatKyChiTiet data;

  LayChiTietNhatKyVanChuyen(
      {this.status, this.message, this.errorCode, this.data});

  LayChiTietNhatKyVanChuyen.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    data = json['data'] != null ? new DataNhatKyChiTiet.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['errorCode'] = this.errorCode;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DataNhatKyChiTiet {
  String maTraCuu;
  int tongTien;
  String linkTraCuu;
  String tenDiemNhanHang;
  String soDienThoaiGui;
  String soDienThoaiNhan;
  String thoiGianGiaoHangDuKien;
  String thoiGianGiaoHangThucTe;
  String trangThaiVanChuyen;
  String maMauVanChuyen;
  String trangThaiThanhToan;
  String maMauThanhToan;


  DataNhatKyChiTiet(
      {this.maTraCuu,
      this.tongTien,
      this.linkTraCuu,
      this.tenDiemNhanHang,
      this.soDienThoaiGui,
      this.soDienThoaiNhan,
      this.thoiGianGiaoHangDuKien,
      this.thoiGianGiaoHangThucTe,
      this.trangThaiVanChuyen,
      this.maMauVanChuyen,
      this.trangThaiThanhToan,
      this.maMauThanhToan,
     });

  DataNhatKyChiTiet.fromJson(Map<String, dynamic> json) {
    maTraCuu = json['maTraCuu'];
    tongTien = json['tongTien'];
    linkTraCuu = json['linkTraCuu'];
    tenDiemNhanHang = json['tenDiemNhanHang'];
    soDienThoaiGui = json['soDienThoaiGui'];
    soDienThoaiNhan = json['soDienThoaiNhan'];
    thoiGianGiaoHangDuKien = json['thoiGianGiaoHangDuKien'];
    thoiGianGiaoHangThucTe = json['thoiGianGiaoHangThucTe'];
    trangThaiVanChuyen = json['trangThaiVanChuyen'];
    maMauVanChuyen = json['maMauVanChuyen'];
    trangThaiThanhToan = json['trangThaiThanhToan'];
    maMauThanhToan = json['maMauThanhToan'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maTraCuu'] = this.maTraCuu;
    data['tongTien'] = this.tongTien;
    data['linkTraCuu'] = this.linkTraCuu;
    data['tenDiemNhanHang'] = this.tenDiemNhanHang;
    data['soDienThoaiGui'] = this.soDienThoaiGui;
    data['soDienThoaiNhan'] = this.soDienThoaiNhan;
    data['thoiGianGiaoHangDuKien'] = this.thoiGianGiaoHangDuKien;
    data['thoiGianGiaoHangThucTe'] = this.thoiGianGiaoHangThucTe;
    data['trangThaiVanChuyen'] = this.trangThaiVanChuyen;
    data['maMauVanChuyen'] = this.maMauVanChuyen;
    data['trangThaiThanhToan'] = this.trangThaiThanhToan;
    data['maMauThanhToan'] = this.maMauThanhToan;
   
    return data;
  }
}