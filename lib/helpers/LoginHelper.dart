// Test config
// {
//     "URL": "https://dangnhap.qc03.qlbx.sonphat.dev/auth",
//     "Realm": "Sbus.vn",
//     "ClientId": "BanVeTaiBen"
// }

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class LoginHelper {
  static const Base64Codec base64Url = Base64Codec.urlSafe();
  //https://dangnhap.qc03.qlbx.sonphat.dev/auth
// Cái này tạo thông tin chung, cấu hình theo mặc định, để toàn bộ chương trình, chố nào cũng có thể dung
// Đoạn này cũng áp dụng tương đối theo mô hình signleton, nhưng anh không lock hàm khởi tạo của class
  static LoginHelper Default = LoginHelper(
      "https://dangnhap.sonphat.dev/auth", "Sbus.vn", "BanVeTaiBen");

  String URL; // Thông tin server đăng nhập
  String Realm; // Thông tin cấu hình vùng dữ liệu đăng nhập
  String
      ClientId; // Mã ứng dụng tương ứng đã được cấu hình trên server đăng nhập
  // 3 thông tin trên sẽ do trưởng phòng hiện tại hoặc do nhân sự cấp SA trở lên cấp xuôgs cho bọn em.

// Thuộc tính tokenUrl có only-getter trả về đường dẫn tới api đăng nhập của server đăng nhập
  String get tokenUrl => "$URL/realms/$Realm/protocol/openid-connect/token";

// tạo chỗ để lưu trữ token, token mà máy chủ đăng nhập cấp gồm 2 loại:
  String access_token =
      ""; // loại 1, token chứa thông tin tài khoản, dùng để giao tiếp nghiệp vụ.
  String refresh_token =
      ""; // loại 2, token chỉ chứa thông tin giữ phiên, chỉ dùng để giao tiếp khi yêu cầu server đăng nhập trả mã phiên mới
  String error='';
// đoạn này anh lưu tạm memory. sau lúc nào có time thì em bổ sung getter/setter để lưu giá trị vào bộ nhớ dài hạn

  Timer timer; // Timer có tác dụng thực hiện các công việc theo thời gian

  UserTokenModel userToken =
      UserTokenModel(); // userToken chứa thông tin tài khoản hiện tại

  LoginHelper(this.URL, this.Realm,
      this.ClientId); // hàm khởi tạo LoginHelper với các thông số là cấu hình máy chủ đăng nhập

// hàm đăng nhập, truyền tên tài khoản và mật khẩu và thực hiện đăng nhập. Hàm bất đồng bộ (async) do truy vấn mạng là tác vụ bất đồng bộ.
  login(String username, String password) async {
    // 1 http request bao gồm 2 phần: headers và body.
    // thông thường thì các thư viện đã tạo sẵn headers nên chỉ việc truyền url và method name.
    // Nhưng do dùng hàm post để gửi dữ liệu có định dạng cụ thể lên server đăng nhập.
    // nên đoạn code sau truyền vào tham số headers 1 tập dữ liệu dạng key pair value để tuỳ chỉnh headers

    // sử dụng hàng post trong gói http. http.post để gửi truy vấn chứa đữ liệu tới api đăng nhập.
    http.Response resp = await http.post(Uri.parse(tokenUrl),
        headers: {
          "Content-Type":
              "application/x-www-form-urlencoded; charset=utf-8", // header Content-Type tuỳ chỉnh
        },
        body: // truyền giá trị cho request-body. định dạng là form-urlencoded
            "grant_type=password&client_id=$ClientId&username=$username&password=$password");

    // khi chương trình chạy được đến dòng này thì tức là truy vấn đã xong, do keyword await có nhiệm vụ đợi các hàm bất đồng bộ được chỉ định xong thì mới chạy tiếp.
    // lưu ý là chỉ có thể `await` bên trong `async`

    if (resp.statusCode == 200) {
      // kiểm tra máy chủ báo gì về, theo quy ước, http có mã 2xx là hợp lệ
      // trong đó 200 có nghĩa là truy vấn thành công và có dữ liệu trả ra.

      parseTokenResult(resp
          .body); // lấy kết quả trả về từ máy chủ đăng nhập và đưa vào hàm xử lý dữ liệu.
      error = ' No error';
      if (timer != null) {
        // kiểm tra xem đã có timer nào hoặt động chưa, nếu chưa có thì tạo timer

        // sử dụng hàm periodic của timer để tạo bộ hẹn giờ tự chạy sau mỗi 10 giây (seconds: 10).
        // nghĩa là cứ sao mỗi 10 giây, hàm refreshingToken sẽ được kích hoạt chạy.
        // Đảm bảo luôn truy vấn và lưu trữ phiên mới nhất của người dùng.
        timer = Timer.periodic(
            Duration(seconds: 10), (Timer timer) => refreshingToken());
      }
    } else if (resp.statusCode == 401) {
      // mã 4xx quy ước là các lỗi ở phía client. 401 là lỗi đăng nhập không hợp lệ
       error='Thông tin đăng nhập không hợp lệ.';
      throw Exception("Thông tin đăng nhập không hợp lệ");
     
    } else {
      error='Không kết có kết nối';
      // Theo quy ước riêng, api trên chỉ trả về mã hợp lệ là 200, tất cả mã khác được coi như không hợp lệ
      throw Exception(
          "Lỗi không xác định"); // Gọi là lỗi không xác định vì tạm tời chưa tách rõ lỗi, khi nào có thời gian thì tách rõ từng lỗi của api đăng nhập sau.
    }

    // chú ý khúc try..catch ở giao diện login, nếu catch được lỗi thì ngoài việc print lỗi, nên show thôgn báo lỗi lên giao diện.
  }

// hàm tự dộng truy vấn phiên mới nhất của người dùng.
  refreshingToken() async {
    if (refresh_token == "")
      return; // kiểm tra xem đang có phiên hợp lệ ở thời điểm hiện tại không. Nếu không có thì huỷ không thực hiện.

    try {
// Tương tự hàm post ở trên
      http.Response resp = await http.post(Uri.parse(tokenUrl),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
          },
          body: // Nội dung của hàm này sẽ khác hàm trên, do hàm này có nhiệm vụ là lấy access_token từ refresh_token.
              "grant_type=refresh_token&client_id=$ClientId&refresh_token=$refresh_token");

      if (resp.statusCode == 200) {
        print('aaa ${resp.body.toString()}');
        // tương tự ở trên
        parseTokenResult(resp.body);
        
      } else {
        throw Exception("Phiên đăng nhập không hợp lệ.");
      }
    } catch (ex) {
        // khác với hàm đăng nhập ở trên được kích hoạt do yếu tố người sử dụng. hàm refreshing_token này hoàn toàn chạy ngầm.
        // Do vậy khi lỗi thì huỷ phiên người dùng luôn, không cần thông báo hỏi.

      access_token = "";
      refresh_token = "";
      userToken = UserTokenModel();
    }
  }


  parseTokenResult(String result) {

      // đọc dữ liệu json mà api đăng nhập trả về
    Map<String, dynamic> data = jsonDecode(result);
// lấy 2 thuộc tính token tương ứng.
    access_token = data['access_token'];
    refresh_token = data['refresh_token'];


// lấy phân đoạn dữ liệu chứa thông tin tài khoan hiện tại.
    String b64 =
        access_token.split('.')[1].replaceAll("-", "+").replaceAll("_", "/");

// fix lỗi bù bytes của thuật toán base64 khi dùng trong jwt. Token hiện tại dùng theo chuẩn JSON Web Token (jwt.io)
    if (b64.length % 4 > 0) {
      b64 = b64.padRight(b64.length + 4 - b64.length % 4, '=');
    }
var decoded = base64Url.decode("$b64");
// Chuyển đổi và đọc dữ liệu từ base64 trong phân đoạn dữ liệu của token.
    Map<String, dynamic> tokenParsed =jsonDecode(utf8.decode(decoded));
        //jsonDecode(String.fromCharCodes(base64Decode(b64)));


    // lưu trữ thông tin cần lấy của tài khoản vào dùng nhớ.
    userToken.GuidDoanhNghiep = tokenParsed["GuidDoanhNghiep"];
    userToken.TenDoanhNghiep = tokenParsed["TenDoanhNghiep"];
    userToken.ID_BenXeSuDung = tokenParsed["GuidDoanhNghiep"];
    userToken.SuDungDichVu = tokenParsed["SuDungDichVu"];
    userToken.preferred_username = tokenParsed["preferred_username"];
    userToken.name = tokenParsed["name"];
    userToken.given_name = tokenParsed["given_name"];
    userToken.exp = tokenParsed['exp'];
    // ngoài thông tin chung, có thể bổ sung thuộc tính vào class UserTokenModel và lấy thêm.
  }
}

class UserTokenModel {
  String GuidDoanhNghiep;
  String TenDoanhNghiep;
  String ID_BenXeSuDung;
  String SuDungDichVu;
  String given_name;
  String name;
  String preferred_username;
  int exp;
  UserTokenModel({this.GuidDoanhNghiep,this.TenDoanhNghiep,this.ID_BenXeSuDung,this.SuDungDichVu,this.given_name,this.name,this.preferred_username,this.exp});
 UserTokenModel.fromJson(Map<String, dynamic> json) {
    GuidDoanhNghiep = json['GuidDoanhNghiep'];
    TenDoanhNghiep = json['TenDoanhNghiep'];
    ID_BenXeSuDung = json['ID_BenXeSuDung'];
    SuDungDichVu = json['SuDungDichVu'];
    given_name = json['given_name'];
    name = json['name'];
    preferred_username = json['preferred_username'];
    exp =json['exp'];
  }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['GuidDoanhNghiep'] = this.GuidDoanhNghiep;
    data['TenDoanhNghiep'] =this.TenDoanhNghiep;
    data['ID_BenXeSuDung'] = this.ID_BenXeSuDung;
    data['SuDungDichVu'] = this.SuDungDichVu;
    data['given_name'] = this.given_name;
    data['name'] = this.name;
    data['preferred_username'] = this.preferred_username;
    data['exp'] = this.exp;
    return data;
  }
 
}
