class ChiTietKeHoach {
  bool status;
  String message;
  int errorCode;
  List<Data> data;

  ChiTietKeHoach({this.status, this.message, this.errorCode, this.data});

  ChiTietKeHoach.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  String iDKeHoach;
  String idDnvtTuyen;
  String idTuyen;
  String idBenXeDi;
  String idBenXeDen;
  String tenBenXeDi;
  String tenBenXeDen;
  String loTrinh;
  String not;
  String ngayDuong;
  String ngayXuatBenKeHoach;
  int ngayTrongTuan;
  String maTuyen;
  String tenTuyen;
  String bienSoXe;
  NgayAm ngayAm;
  XeThucHien xeThucHien;
  List<DSLaiXeThucHien> danhSachLaiXeThucHien;
  String hoTenPhuXe;
  bool checked = false;
  Data(
      {this.iDKeHoach,
      this.idDnvtTuyen,
      this.idTuyen,
      this.idBenXeDi,
      this.idBenXeDen,
      this.tenBenXeDi,
      this.tenBenXeDen,
      this.loTrinh,
      this.not,
      this.ngayDuong,
      this.ngayXuatBenKeHoach,
      this.ngayTrongTuan,
      this.maTuyen,
      this.tenTuyen,
      this.bienSoXe,
      this.ngayAm,
      this.xeThucHien,
      this.danhSachLaiXeThucHien,
      this.hoTenPhuXe});

  Data.fromJson(Map<String, dynamic> json) {
    iDKeHoach = json['ID_KeHoach'];
    idDnvtTuyen = json['IdDnvtTuyen'];
    idTuyen = json['IdTuyen'];
    idBenXeDi = json['IdBenXeDi'];
    idBenXeDen = json['IdBenXeDen'];
    tenBenXeDi = json['TenBenXeDi'];
    tenBenXeDen = json['TenBenXeDen'];
    loTrinh = json['LoTrinh'];
    not = json['Not'];
    ngayDuong = json['NgayDuong'];
    ngayXuatBenKeHoach = json['NgayXuatBenKeHoach'];
    ngayTrongTuan = json['NgayTrongTuan'];
    maTuyen = json['MaTuyen'];
    tenTuyen = json['TenTuyen'];
    bienSoXe = json['BienSoXe'];
    ngayAm =
        json['NgayAm'] != null ? new NgayAm.fromJson(json['NgayAm']) : null;
    xeThucHien = json['XeThucHien'] != null
        ? new XeThucHien.fromJson(json['XeThucHien'])
        : null;
    if (json['DanhSachLaiXeThucHien'] != null) {
      danhSachLaiXeThucHien = <DSLaiXeThucHien>[];
      json['DanhSachLaiXeThucHien'].forEach((v) {
        danhSachLaiXeThucHien.add(new DSLaiXeThucHien.fromJson(v));
      });
    }
    hoTenPhuXe = json['HoTenPhuXe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID_KeHoach'] = this.iDKeHoach;
    data['IdDnvtTuyen'] = this.idDnvtTuyen;
    data['IdTuyen'] = this.idTuyen;
    data['IdBenXeDi'] = this.idBenXeDi;
    data['IdBenXeDen'] = this.idBenXeDen;
    data['TenBenXeDi'] = this.tenBenXeDi;
    data['TenBenXeDen'] = this.tenBenXeDen;
    data['LoTrinh'] = this.loTrinh;
    data['Not'] = this.not;
    data['NgayDuong'] = this.ngayDuong;
    data['NgayXuatBenKeHoach'] = this.ngayXuatBenKeHoach;
    data['NgayTrongTuan'] = this.ngayTrongTuan;
    data['MaTuyen'] = this.maTuyen;
    data['TenTuyen'] = this.tenTuyen;
    data['BienSoXe'] = this.bienSoXe;
    if (this.ngayAm != null) {
      data['NgayAm'] = this.ngayAm.toJson();
    }
    if (this.xeThucHien != null) {
      data['XeThucHien'] = this.xeThucHien.toJson();
    }
    if (this.danhSachLaiXeThucHien != null) {
      data['DanhSachLaiXeThucHien'] =
          this.danhSachLaiXeThucHien.map((v) => v.toJson()).toList();
    }
    data['HoTenPhuXe'] = this.hoTenPhuXe;
    return data;
  }
}

class NgayAm {
  int year;
  int month;
  bool isLeapMonth;
  int day;
  String solarDate;
  bool isTermBeginThisDay;
  int solarTermIndex;
  String yearName;
  String monthName;
  String monthShortName;
  String monthLongName;
  String monthFullName;
  String dayName;
  String solarTerm;
  String fullDayInfo;

  NgayAm(
      {this.year,
      this.month,
      this.isLeapMonth,
      this.day,
      this.solarDate,
      this.isTermBeginThisDay,
      this.solarTermIndex,
      this.yearName,
      this.monthName,
      this.monthShortName,
      this.monthLongName,
      this.monthFullName,
      this.dayName,
      this.solarTerm,
      this.fullDayInfo});

  NgayAm.fromJson(Map<String, dynamic> json) {
    year = json['Year'];
    month = json['Month'];
    isLeapMonth = json['IsLeapMonth'];
    day = json['Day'];
    solarDate = json['SolarDate'];
    isTermBeginThisDay = json['IsTermBeginThisDay'];
    solarTermIndex = json['SolarTermIndex'];
    yearName = json['YearName'];
    monthName = json['MonthName'];
    monthShortName = json['MonthShortName'];
    monthLongName = json['MonthLongName'];
    monthFullName = json['MonthFullName'];
    dayName = json['DayName'];
    solarTerm = json['SolarTerm'];
    fullDayInfo = json['FullDayInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Year'] = this.year;
    data['Month'] = this.month;
    data['IsLeapMonth'] = this.isLeapMonth;
    data['Day'] = this.day;
    data['SolarDate'] = this.solarDate;
    data['IsTermBeginThisDay'] = this.isTermBeginThisDay;
    data['SolarTermIndex'] = this.solarTermIndex;
    data['YearName'] = this.yearName;
    data['MonthName'] = this.monthName;
    data['MonthShortName'] = this.monthShortName;
    data['MonthLongName'] = this.monthLongName;
    data['MonthFullName'] = this.monthFullName;
    data['DayName'] = this.dayName;
    data['SolarTerm'] = this.solarTerm;
    data['FullDayInfo'] = this.fullDayInfo;
    return data;
  }
}

class XeThucHien {
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

  XeThucHien(
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

  XeThucHien.fromJson(Map<String, dynamic> json) {
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

class DSLaiXeThucHien {
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

  DSLaiXeThucHien(
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
      this.laiXeHoatDongTrenTuyen});

  DSLaiXeThucHien.fromJson(Map<String, dynamic> json) {
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
