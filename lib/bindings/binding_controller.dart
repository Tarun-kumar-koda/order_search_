
import 'package:get/get.dart';
import 'package:order_search/services/session_manager.dart';

import '../routes/login_screen/controller/login_screen_controller.dart';

class BindingController implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<SessionManager>(() => SessionManager(), fenix: true);
    // Get.lazyPut<SignaturePageController>(() => SignaturePageController(), fenix: true);
  }
}
