import 'dart:convert';

import 'package:crew_app/models/profile_model.dart';
import 'package:crew_app/providers/base_provider.dart';
import 'package:crew_app/shared/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class AccountProvider extends BaseProvider {
  final logger = Logger();

  Future<ProfileModel?> getProfile() async {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic> && map.containsKey('data')) {
        return ProfileModel.fromJson(map['data']);
      }
      defaultDecoderWhenError(map);
      return null;
    };
    final response = await get('/app-crew-profile/user-profile', );
    return response.body;
  }

  Future<bool> uploadAvatar(XFile file) async {
    try {
      var headers = {
        'auth-token': Constants.token ?? '',
      };

      var request = http.MultipartRequest('POST', Uri.parse('${httpClient.baseUrl}/app-crew-profile/profile-upload'));
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();

        Map<String, dynamic> jsonResponse = json.decode(responseBody);
        if (jsonResponse.containsKey('success') && jsonResponse['success'] == true) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      logger.e('Error uploading avatar: $e');
      return false;
    }
  }

  Future<bool> resetPassword(Map<String, String> body) async {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic> && map.containsKey('success')) {
        return map['success'];
      }
      defaultDecoderWhenError(map);
      return false;
    };
    final response = await post('/app-authentication/reset-password', body);
    return response.body;
  }



  Future<bool> updateProfile(Map<String, dynamic> profileData) async {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic> && map.containsKey('success')) {
        return map['success'];
      }
      defaultDecoderWhenError(map);
      return false;
    };
    final response = await put('/app-crew-profile/update-profile', profileData);
    return response.body;
  }
}

