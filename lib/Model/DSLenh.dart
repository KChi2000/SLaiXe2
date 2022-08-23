class dsLenh {
  bool status;
  String message;
  int errorCode;
  Data data;

  dsLenh({this.status, this.message, this.errorCode, this.data});

  dsLenh.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  List<LenhDataDetail> list;

  Data({this.list});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      list = <LenhDataDetail>[];
      json['data'].forEach((v) {
        list.add(new LenhDataDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['data'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LenhDataDetail {
  String idLenhDienTu;
  String idDnvt;
  int idLoaiLenh;
  String idDnvtTuyen;
  String idTuyen;
  String idDnvtXe;
  String idXe;
  String maSoLenh;
  String ngayCapLenh;
  String ngayXuatBen;
  List<DanhSachBenXe> danhSachBenXe;
  int idTrangThaiLenh;
  String maTrangThaiLenh;
  String tenTrangThaiLenh;
  String maMauTrangThaiLenh;
  List<DanhSachLaiXe> danhSachLaiXe;
  String bienSoXe;
  String gioXuatBen;
  String hoTenPhuXe;
  String maTuyen;
  String tenTuyen;
  String linkXemBanTheHienPdf;
  bool truyenTaiXuatBenThanhCong;
  bool truyenTaiDenBenThanhCong;
  bool laiXeHoanThanhHanhTrinh;
  bool trangThaiKyLenh;
  String tenTrangThaiKyLenh;
  String maMauTrangThaiKyLenh;
  bool trangThaiChuyenDiBanVe;
  String trangThaiChuyenDiVDT;
  String maMauTrangThaiChuyenDiVDT;

  LenhDataDetail(
      {this.idLenhDienTu,
      this.idDnvt,
      this.idLoaiLenh,
      this.idDnvtTuyen,
      this.idTuyen,
      this.idDnvtXe,
      this.idXe,
      this.maSoLenh,
      this.ngayCapLenh,
      this.ngayXuatBen,
      this.danhSachBenXe,
      this.idTrangThaiLenh,
      this.maTrangThaiLenh,
      this.tenTrangThaiLenh,
      this.maMauTrangThaiLenh,
      this.danhSachLaiXe,
      this.bienSoXe,
      this.gioXuatBen,
      this.hoTenPhuXe,
      this.maTuyen,
      this.tenTuyen,
      this.linkXemBanTheHienPdf,
      this.truyenTaiXuatBenThanhCong,
      this.truyenTaiDenBenThanhCong,
      this.laiXeHoanThanhHanhTrinh,
      this.trangThaiKyLenh,
      this.tenTrangThaiKyLenh,
      this.maMauTrangThaiKyLenh,
      this.trangThaiChuyenDiBanVe,
      this.trangThaiChuyenDiVDT,
      this.maMauTrangThaiChuyenDiVDT});

  LenhDataDetail.fromJson(Map<String, dynamic> json) {
    idLenhDienTu = json['IdLenhDienTu'];
    idDnvt = json['IdDnvt'];
    idLoaiLenh = json['IdLoaiLenh'];
    idDnvtTuyen = json['IdDnvtTuyen'];
    idTuyen = json['IdTuyen'];
    idDnvtXe = json['IdDnvtXe'];
    idXe = json['IdXe'];
    maSoLenh = json['MaSoLenh'];
    ngayCapLenh = json['NgayCapLenh'];
    ngayXuatBen = json['NgayXuatBen'];
    if (json['DanhSachBenXe'] != null) {
      danhSachBenXe = <DanhSachBenXe>[];
      json['DanhSachBenXe'].forEach((v) {
        danhSachBenXe.add(new DanhSachBenXe.fromJson(v));
      });
    }
    idTrangThaiLenh = json['IdTrangThaiLenh'];
    maTrangThaiLenh = json['MaTrangThaiLenh'];
    tenTrangThaiLenh = json['TenTrangThaiLenh'];
    maMauTrangThaiLenh = json['MaMauTrangThaiLenh'];
    if (json['DanhSachLaiXe'] != null) {
      danhSachLaiXe = <DanhSachLaiXe>[];
      json['DanhSachLaiXe'].forEach((v) {
        danhSachLaiXe.add(new DanhSachLaiXe.fromJson(v));
      });
    }
    bienSoXe = json['BienSoXe'];
    gioXuatBen = json['GioXuatBen'];
    hoTenPhuXe = json['HoTenPhuXe'];
    maTuyen = json['MaTuyen'];
    tenTuyen = json['TenTuyen'];
    linkXemBanTheHienPdf = json['LinkXemBanTheHienPdf'];
    truyenTaiXuatBenThanhCong = json['TruyenTaiXuatBenThanhCong'];
    truyenTaiDenBenThanhCong = json['TruyenTaiDenBenThanhCong'];
    laiXeHoanThanhHanhTrinh = json['LaiXeHoanThanhHanhTrinh'];
    trangThaiKyLenh = json['TrangThaiKyLenh'];
    tenTrangThaiKyLenh = json['TenTrangThaiKyLenh'];
    maMauTrangThaiKyLenh = json['MaMauTrangThaiKyLenh'];
    trangThaiChuyenDiBanVe = json['TrangThaiChuyenDiBanVe'];
    trangThaiChuyenDiVDT = json['TrangThaiChuyenDiVDT'];
    maMauTrangThaiChuyenDiVDT = json['MaMauTrangThaiChuyenDiVDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdLenhDienTu'] = this.idLenhDienTu;
    data['IdDnvt'] = this.idDnvt;
    data['IdLoaiLenh'] = this.idLoaiLenh;
    data['IdDnvtTuyen'] = this.idDnvtTuyen;
    data['IdTuyen'] = this.idTuyen;
    data['IdDnvtXe'] = this.idDnvtXe;
    data['IdXe'] = this.idXe;
    data['MaSoLenh'] = this.maSoLenh;
    data['NgayCapLenh'] = this.ngayCapLenh;
    data['NgayXuatBen'] = this.ngayXuatBen;
    if (this.danhSachBenXe != null) {
      data['DanhSachBenXe'] =
          this.danhSachBenXe.map((v) => v.toJson()).toList();
    }
    data['IdTrangThaiLenh'] = this.idTrangThaiLenh;
    data['MaTrangThaiLenh'] = this.maTrangThaiLenh;
    data['TenTrangThaiLenh'] = this.tenTrangThaiLenh;
    data['MaMauTrangThaiLenh'] = this.maMauTrangThaiLenh;
    if (this.danhSachLaiXe != null) {
      data['DanhSachLaiXe'] =
          this.danhSachLaiXe.map((v) => v.toJson()).toList();
    }
    data['BienSoXe'] = this.bienSoXe;
    data['GioXuatBen'] = this.gioXuatBen;
    data['HoTenPhuXe'] = this.hoTenPhuXe;
    data['MaTuyen'] = this.maTuyen;
    data['TenTuyen'] = this.tenTuyen;
    data['LinkXemBanTheHienPdf'] = this.linkXemBanTheHienPdf;
    data['TruyenTaiXuatBenThanhCong'] = this.truyenTaiXuatBenThanhCong;
    data['TruyenTaiDenBenThanhCong'] = this.truyenTaiDenBenThanhCong;
    data['LaiXeHoanThanhHanhTrinh'] = this.laiXeHoanThanhHanhTrinh;
    data['TrangThaiKyLenh'] = this.trangThaiKyLenh;
    data['TenTrangThaiKyLenh'] = this.tenTrangThaiKyLenh;
    data['MaMauTrangThaiKyLenh'] = this.maMauTrangThaiKyLenh;
    data['TrangThaiChuyenDiBanVe'] = this.trangThaiChuyenDiBanVe;
    data['TrangThaiChuyenDiVDT'] = this.trangThaiChuyenDiVDT;
    data['MaMauTrangThaiChuyenDiVDT'] = this.maMauTrangThaiChuyenDiVDT;
    return data;
  }
}

class DanhSachBenXe {
  String idBenXe;
  String tenBenXe;
  bool laBenDi;
  String trangThai;
  String maMauTrangThai;
  bool trangThaiTruyenTai;

  DanhSachBenXe(
      {this.idBenXe,
      this.tenBenXe,
      this.laBenDi,
      this.trangThai,
      this.maMauTrangThai,
      this.trangThaiTruyenTai});

  DanhSachBenXe.fromJson(Map<String, dynamic> json) {
    idBenXe = json['IdBenXe'];
    tenBenXe = json['TenBenXe'];
    laBenDi = json['LaBenDi'];
    trangThai = json['TrangThai'];
    maMauTrangThai = json['MaMauTrangThai'];
    trangThaiTruyenTai = json['TrangThaiTruyenTai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdBenXe'] = this.idBenXe;
    data['TenBenXe'] = this.tenBenXe;
    data['LaBenDi'] = this.laBenDi;
    data['TrangThai'] = this.trangThai;
    data['MaMauTrangThai'] = this.maMauTrangThai;
    data['TrangThaiTruyenTai'] = this.trangThaiTruyenTai;
    return data;
  }
}

class DanhSachLaiXe {
  String iDDnvtLaiXe;
  String hoTen;
  bool tiepNhanLenh;

  DanhSachLaiXe({this.iDDnvtLaiXe, this.hoTen, this.tiepNhanLenh});

  DanhSachLaiXe.fromJson(Map<String, dynamic> json) {
    iDDnvtLaiXe = json['ID_DnvtLaiXe'];
    hoTen = json['HoTen'];
    tiepNhanLenh = json['TiepNhanLenh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID_DnvtLaiXe'] = this.iDDnvtLaiXe;
    data['HoTen'] = this.hoTen;
    data['TiepNhanLenh'] = this.tiepNhanLenh;
    return data;
  }
}

