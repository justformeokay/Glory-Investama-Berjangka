import 'package:get/get.dart';
import 'package:gifx/app/controllers/set_password_controller.dart';

class SetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetPasswordController>(() => SetPasswordController());
  }
}
