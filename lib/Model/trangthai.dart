class tenTrangthai {
  String trong;
  String dangThanhToan;
  String daDat;
  String daNgoi;
  String daMua;

  tenTrangthai(
      {this.trong, this.dangThanhToan, this.daDat, this.daNgoi, this.daMua});

  tenTrangthai.fromJson(Map<String, dynamic> json) {
    trong = json['Trong'];
    dangThanhToan = json['DangThanhToan'];
    daDat = json['DaDat'];
    daNgoi = json['DaNgoi'];
    daMua = json['DaMua'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Trong'] = this.trong;
    data['DangThanhToan'] = this.dangThanhToan;
    data['DaDat'] = this.daDat;
    data['DaNgoi'] = this.daNgoi;
    data['DaMua'] = this.daMua;
    return data;
  }
}
