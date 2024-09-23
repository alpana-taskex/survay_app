import 'package:crew_app/models/user_model.dart';
import 'package:crew_app/providers/base_provider.dart';

class AuthProvider extends BaseProvider {

  Future<User?> login(String email, String password) async {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic> && map.containsKey('data')) {
        return User.fromJson(map['data']);
      }
      defaultDecoderWhenError(map);

      return null;
    };
    final body = {'password':password, 'username':email};
    final response = await post('/app-authentication/login', body);
    return response.body;
  }

  Future<bool?> sendVerificationCode(String email) async {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic> && map.containsKey('checked')) {
        return true;
      }
      defaultDecoderWhenError(map);
      return false;
    };

    final response = await post('/auth/SendVerification', {'text':email});
    return response.body;
  }

  Future<bool?> verifyCode(String email, String otp) async {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic> && map.containsKey('success')) {
        return map['success']==true;
      }
      defaultDecoderWhenError(map);
      return false;
    };

    final response = await post('/auth/OTPVerification', {'email':email, 'otp':otp});
    return response.body;
  }

  Future<bool> changePassword(Map<String, String> body) async {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic> && map.containsKey('checked')) {
        return true;
      }
      defaultDecoderWhenError(map);
      return false;
    };

    final response = await post('/auth/UpdatePassword', body);
    return response.body;
  }

}
