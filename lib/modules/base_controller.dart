import 'package:get/get.dart';

class BaseController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingSecond = false.obs;

  void setLoading(bool loading) => isLoading.value = loading;

  void showLoader()=> isLoading.value = true;
  void hideLoader()=> isLoading.value = false;


}
