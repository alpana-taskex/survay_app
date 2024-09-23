import 'dart:convert';
import 'package:crew_app/models/complete_job_model.dart';
import 'package:crew_app/providers/base_provider.dart';
import 'package:crew_app/shared/constants/constants.dart';

class DashboardProvider extends BaseProvider {
  Future<List<CompleteJob>?> notifications({
    int page = 1,
    int limit = 10,
    String type = 'TODAY',
    List<String>? jobTypeIds,
    String? creationStart,
    String? creationEnd,
    String? searchKeyword,
  }) async {
    final query = {
      'page': page.toString(),
      'limit': limit.toString(),
      'type': type,
    };

    final employeeId = Constants.user?.employeeId;
    if (employeeId != null) {
      query['employeeId'] = employeeId;
    }

    if (jobTypeIds != null && jobTypeIds.isNotEmpty) {
      query['jobTypeIds'] = jobTypeIds.join(',');
    }

    if (creationStart != null) {
      query['creationStart'] = creationStart;
    }

    if (creationEnd != null) {
      query['creationEnd'] = creationEnd;
    }

    if (searchKeyword != null && searchKeyword.isNotEmpty) {
      query['searchKeyword'] = searchKeyword;
    }

      final response = await get('/app-jobs/jobs', query: query);
      if (response.status.isOk) {
        final decodedJson = json.decode(response.bodyString!);

        if (decodedJson is Map<String, dynamic> &&
            decodedJson.containsKey('data') &&
            decodedJson['data'].containsKey('docs')) {
          final jobsList = <CompleteJob>[];
          for (var jobJson in decodedJson['data']['docs']) {
            jobsList.add(CompleteJob.fromJson(jobJson));
          }
          return jobsList;
        } else {
          return [];
        }
      } else {
        return null;
      }
  }

  Future<Map<String, List<Map<String, String>>>> filterOption() async {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) {
        return map;
      }
      return {};
    };

    final employeeId = Constants.user!.employeeId;
    final query = {'employeeId': employeeId};

    final response = await get('/app-jobs/filter-options', query: query);

    if (response.status.isOk) {
      final Map<String, dynamic> body = response.body;
      return {
        'jobTypes': (body['jobTypes'] as List<dynamic>?)
            ?.map((e) => Map<String, String>.from(e))
            .toList() ?? [],
      };
    } else {
      return {'jobTypes': []};
    }
  }
}