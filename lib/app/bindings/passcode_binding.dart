import 'package:get/get.dart';
import 'package:gifx/app/controllers/passcode_controller.dart';

class PasscodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasscodeController>(() => PasscodeController());
  }
}
