
import 'package:crew_app/models/complete_job_model.dart';
import 'package:crew_app/providers/base_provider.dart';

class JobProvider extends BaseProvider {

  Future<CompleteJob?> fetchJobSummary({required String jobId}) async {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic> && map.containsKey('data')) {
        return CompleteJob.fromJson(map['data']);
      }
      defaultDecoderWhenError(map);
      return null;
    };
    final response = await get('/app-jobs/summary/$jobId',);
    return response.body;
  }
}