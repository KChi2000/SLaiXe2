final backend_url = 'https://api.qc03.lenh.sonphat.dev/';
class servicesAPI{
  
  static final API_KiemSoatVeTaiBen = backend_url + 'be_api/kiemsoatvetaiben/';
  static final API_Print = backend_url;
  static final API_TuyenDuong = backend_url + 'be_api/tuyenduong/';
  static final API_ThanhToan = backend_url + 'be_api/thanhtoan/';
  static final API_PhongChongDich = backend_url + 'be_api/phongchongdich/';
  static final API_DoiSoat = backend_url + 'be_api/chuyendi/doi-soat/';
  static final API_ThongTin = backend_url + 'api/';
  static final API_PhienBan = backend_url + 'PhienBan/api/';
  static final API_HangHoa = 'https://api-hanghoa.nguyencongtuyen.sonphat.dev/api/';
  static final API_LenhDienTu = 'https://api.qc03.lenh.sonphat.dev/api/Driver/';
  static final API_File = 'https://file-ve.nguyencongtuyen.sonphat.dev/api/';
  static final API_DoanhNghiepVanTai = backend_url + 'be_api/doanhnghiepvantai/';
  static final API_CauHinhHeThong = backend_url + 'be_api/cauhinhhethong/';
  static final API_BaoCao = backend_url + 'be_api/baocao/';
  static final API_Ve = backend_url + 'be_api/ve/';
  static final API_Xe = backend_url + 'be_api/xe/';
  static final API_TaiKhoan = backend_url + 'api/taikhoan/';
  static final API_ChuyenDi = backend_url + 'be_api/chuyendi/ChuyenDi/';
  static final API_DiemXuongCuaKhachHang = backend_url;
  static final API_Default_BaseUrl = backend_url + 'be_api/chuyendi/';
  static final API_DonHang = backend_url + 'be_api/donhang/';
  static final API_BaseUrl = backend_url + 'be_api/chuyendi/';
  static final API_BenXe = backend_url + 'be_api/benxe/';
}
final qllenhurl = 'ql-lenh-van-chuyen/api/LenhVanChuyen/';
class apilenh{

  static final apidskehoach = backend_url+qllenhurl+'danh-sach-ke-hoach';
  static final apidsdacaplenh = backend_url + qllenhurl+'danh-sach-lenh-da-cap-cho-lai-xe';
  static final apidslenhdangthuchien = backend_url + qllenhurl+'danh-sach-lenh-dang-thuc-hien';
   static final apidslenhdahoanthanh = backend_url + qllenhurl+'danh-sach-lenh-da-hoan-thanh';
   static final apidslenhkhonghoanthanh = backend_url + qllenhurl+'danh-sach-lenh-khong-hoan-thanh';
   static final apidsluongtuyen = backend_url + 'ql-thong-tin/api/QuanLyThongTin/danh-sach-luong-tuyen-cap-tuyen';
   
 }
 class apiSuaKeHoach{
  static String apidsxedukien(String idkehoach){
    final url = backend_url+qllenhurl+'Danh-Sach-Xe-Du-Kien-Theo-Ke-Hoach?IdKeHoach=$idkehoach';
    return url;
  }
  static String apidslaixedukien(String idkehoach){
    final url = backend_url+qllenhurl+'Danh-Sach-Lai-Xe-Du-Kien-Theo-Ke-Hoach?IdKeHoach=$idkehoach';
    return url;
  }
   static String apidchitietkehoach(String tungay,String denngay,String idkehoach){
    final url = backend_url+qllenhurl+'Chi-Tiet-Ke-Hoach?TuNgay=$tungay&DenNgay=$denngay&idKeHoach=$idkehoach';
    return url;
  }
 }