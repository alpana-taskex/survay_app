// controllers/job_controller.dart
import 'package:crew_app/models/complete_job_model.dart';
import 'package:crew_app/modules/base_controller.dart';
import 'package:get/get.dart';

import '../../gen/assets.gen.dart';

class MoversController extends BaseController {
  final List<SvgGenImage> addressSvgs = [
    Assets.svgs.iconOrigin,
    Assets.svgs.iconDestination,
  ];
  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} ${time.hour >= 12 ? 'PM' : 'AM'}';
  }

  var selectedIndex = 0.obs;
  var job = CompleteJob().obs;


  void call(){
    // Logic for call
  }

  void message(){
    // Logic fro message
  }

  void startJob() {
    // Logic for starting the job
  }

  void onTheWay() {
    // Logic for setting the job on the way
  }
}
