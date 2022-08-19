class DonGiaTheoTuyen {
  bool status;
  String message;
  int errorCode;
  List<DataDonGiaTheoTuyen> data;

  DonGiaTheoTuyen({this.status, this.message, this.errorCode, this.data});

  DonGiaTheoTuyen.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <DataDonGiaTheoTuyen>[];
      json['data'].forEach((v) {
        data.add(new DataDonGiaTheoTuyen.fromJson(v));
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

class DataDonGiaTheoTuyen {
  String guidDonGia;
  String guidLuongTuyen;
  int giaVe;
  String createdAt;
  String createdBy;
  String updatedAt;
  String updatedBy;
  bool isDelete;
  bool chipselected=false;
  String guidLuongTuyenNavigation;

  DataDonGiaTheoTuyen(
      {this.guidDonGia,
      this.guidLuongTuyen,
      this.giaVe,
      this.createdAt,
      this.createdBy,
      this.updatedAt,
      this.updatedBy,
      this.isDelete,
      this.guidLuongTuyenNavigation,
      this.chipselected});

  DataDonGiaTheoTuyen.fromJson(Map<String, dynamic> json) {
    guidDonGia = json['guidDonGia'];
    guidLuongTuyen = json['guidLuongTuyen'];
    giaVe = json['giaVe'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
    isDelete = json['isDelete'];
    guidLuongTuyenNavigation = json['guidLuongTuyenNavigation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guidDonGia'] = this.guidDonGia;
    data['guidLuongTuyen'] = this.guidLuongTuyen;
    data['giaVe'] = this.giaVe;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    data['isDelete'] = this.isDelete;
    data['guidLuongTuyenNavigation'] = this.guidLuongTuyenNavigation;
    return data;
  }
}
