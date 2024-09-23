import 'package:crew_app/models/notification_model.dart';
import 'package:crew_app/providers/base_provider.dart';
import 'package:crew_app/shared/constants/constants.dart';

class NotificationProvider extends BaseProvider {
  Future<List<NotificationModel>> notifications() async {
    httpClient.defaultDecoder = (map) {

      if (map is Map<String, dynamic> && map.containsKey('data')) {
        final notifications = <NotificationModel>[];
        for (var i in map['data']) {
          notifications.add(NotificationModel.fromJson(i));
        }
        return notifications;
      }
      return [];
    };
    final employeeId = Constants.user!.employeeId;
    final response = await get('/notifications/driver-app', query: {'employeeId': '$employeeId'});
    return response.body;
  }
}
