import 'package:order_search/constant/api_constant.dart';
import 'app_enums.dart';

class Env {
  static bool isDebugMode = false;

  static void setEnv(ENV_CONSTANTS mode) {
    switch (mode) {
      case ENV_CONSTANTS.LOCAL:
        isDebugMode = false;
        ApiConstant.currentEnv = "PROD";
        ApiConstant.baseUrl = "http://192.168.50.221:3000/";

      case ENV_CONSTANTS.STAGE:
        isDebugMode = true;
        ApiConstant.currentEnv = "STAGE";
        ApiConstant.baseUrl = "https://stage.fleetenable.com/";

      case ENV_CONSTANTS.BETA:
        isDebugMode = true;
        ApiConstant.currentEnv = "BETA";
        ApiConstant.baseUrl = "https://fe-beta.fleetenable.com/";

      case ENV_CONSTANTS.PROD:
        isDebugMode = false;
        ApiConstant.currentEnv = "PROD";
        ApiConstant.baseUrl = "https://app.fleetenable.com/";
    }
  }
}
