import 'package:order_search/services/session_manager.dart';

class ApiConstant {
  // ApiConstant constant = internal._();
  SessionManager sessionManager = SessionManager();
  static EndPoint endPoint = EndPoint();
  static Param param = Param();
  static String currentEnv = "PROD";
  static String baseUrl = "https://app.fleetenable.com/";
  static final String clientId = "e8c0a7055c769e84d96a3230480efc258a5624c1101e7b30f8eb666b81242871";
  static final String clientSecretKey = "c0b3b76335eb06ea5d300a02be4dd8b32375877ba575620afec4dc79dec75a19";

  Map<String, String> getHeaders(accessToken) =>
      <String, String>{'Authorization': accessToken, 'content-type': 'application/json'};

  Future<Map<String, String>> getHeadersWithToken() async =>
      <String, String>{'Authorization': await sessionManager.getAccessToken(), 'content-type': 'application/json'};
}

class EndPoint {
  final String GET_ACCESS_TOKEN = "api/authentication/user_access_token";
  final String REFRESH_TOKEN = "oauth/token";

  final String UPDATE_FIRE_BASE_ID = "api/v1/users/add_push_notification_identity";
  final String GET_APP_SETTINGS = "/api/v2/app_settings";

  final String USER_SIGN_IN_OFF = "/api/v1/users/sign_in_off";
  final String GET_USER_PROFILE = "api/v1/users/me";
  final String UPDATE_USER_PROFILE = "api/v1/users/";
  final String UPLOAD_USER_IMAGE = "api/v1/users/";

  final String SEND_OTP = "api/authentication/send_verification_code";
  final String VERIFY_OTP = "api/authentication/verify_otp";
  final String GET_ROUTES = "/api/v2/nav_routes";
  final String GET_COMPLETE_ROUTE_DATA = "/api/v2/nav_routes/complete_nav_route";

  final String UPDATE_ROUTE_STATUS = "api/v2/nav_routes/";
  final String UPDATE_COMPLETE_OFFLINE_ROUTE_DATA = "/api/v2/drivers/store_off_line_data";

  static final String ARRIVED_AT_STOP = "api/v2/nav_routes/arrived_at_stop";
  final String GET_STOP_ACTIVITY = "/api/v2/nav_routes/stop_activity";
  final String GET_RECOVERY_STOP_ACTIVITY = "/api/v2/nav_routes/stop_activity";
  final String UPDATE_STOP = "api/v2/nav_routes/update_stop";
  final String UPDATE_STOPS_ORDER = "/api/v2/nav_routes/update_stop_sequence";
  final String SKIP_STOP = "/api/v2/customer_orders/skip_stop_orders";
  final String UPLOAD_OFFLINE_PHOTOS = "/api/v2/drivers/upload_offline_pictures";

  final String UPDATE_ORDER_ITEMS = "api/v2/nav_routes/update_order_items";
  final String UPLOAD_ORDER_ITEM_PHOTOS = "/api/v2/nav_routes/add_stop_order_pictures";

  final String UPLOAD_WAREHOUSE_PICTURES = "/api/v2/nav_routes/add_stop_order_pictures";

  final String GET_SURVEY_DETAILS = "api/v2/questions?survey_id={id}";
  final String POST_SURVEY_ANSWERS = "survey_responses";
  final String POST_Form_ANSWERS = "api/v2/form_responses";
  // final String POST_SURVEY_ANSWERS = "api/v2/survey_responses";
  final String SUBMIT_ANSWERS = "/survey_responses";
  final String UPDATE_FEED_BACK = "/api/v2/feedbacks";

  final String NOTIFY_DRIVER_NEAR_BY_TO_LOCATION = "/api/v1/notifications/notify_drivers_location_customer";
  final String GET_NOTIFICATIONS = "/api/v1/notifications";
  final String DISMISS_NOTIFICATION = "/api/v1/notifications/{id}";

  final String UPDATE_ROUTE_TRACKS = "/api/v2/nav_routes/{nav_route_id}/route_location_tracking";
  final String UPDATE_USER_TRACK = "/api/v1/driver_latest_locations";

  final String GET_ACCOUNT_SETTINGS = "/api/v2/organization/org_id/settings?nav_route_id=nav_id";
  final String GET_ACCESSORIAL_DEFINITION = "/api/v2/accessorial/organisation_accessorials";

  final String GET_EXCEPTION_MESSAGES = "/api/v2/pre_plan/exception_messages?org_id=";
  final String DELETE_PHOTO = "/api/v2/nav_routes/delete_stop_order_pictures";
  final String GET_FORM_QUESTIONS = "/api/v2/form_questions?form_id=";
  final String UPDATE_FORM_ANSWERS = "/api/v2/form_responses";
  final String SIGNATURE_UPLOAD_STATUS = "/api/v2/nav_routes/generate_return_order_status_files";
  final String UPDATE_STOP_ORDERS = "/api/v2/nav_routes/update_stop_orders";
  final String UPDATE_APP_VERSION_INFO = "/api/v1/users/store_app_details";
  final String IS_ROUTE_IN_SYNC = "/api/v2/nav_routes/is_mobile_route_in_sync";

  final String GET_HELPER_ROUTE = "/api/v2/drivers/get_helper_route";

  final String GENERATE_ROUTE_ACCESS_CODE = "api/v2/drivers/generate_route_access_code";
  final String CHANGE_ROUTE_STATUS = "api/v2/recovery_routes/change_route_status";
  final String UPDATE_RECOVERY_STOP = "api/v2/recovery_routes/update_recovery_stop";
  final String GET_RECOVERY_ROUTE = "api/v2/recovery_routes/{id}";
  final String ADD_RECOVERY_STOP_POD = "api/v2/recovery_routes/upload_r_stop_pictures";

  //   <-----WareHouse EndPoints------>
  final String WARE_HOUSE_SELECTION = "/api/v2/locations";
  final String CUSTOMER_INFO = "api/v2/warehouse_items/get_item_details";
  final String UPDATE_ORDER_ITEM_STATUS = "/api/v2/warehouse_items/update_order_item_status";
  final String ORDER_COUNT = "api/v2/customer_orders/filtered_order_stats";
  final String UPDATE_ORDER_STATUS = "api/v2/customer_orders/update_orders_status";

  final String GLOBAL_SEARCH_ORDER = "api/v2/customer_orders/order_listing_details";
  final String GET_WAREHOUSE_LIST = "api/v2/locations";
}

class Param {
  final String CLIENT_ID = "client_id";
  final String CLIENT_SECRET = "client_secret";
  final String USERNAME_KEY = "username";
  final String PASSWORD_KEY = "password";

  final String REFRESH_TOKEN = "refresh_token";
  final String GRANT_TYPE = "grant_type";

  final String AUTHORIZATION = "Authorization";

  final String ERROR_KEY = "error";
  final String ERRORS_KEY = "errors";
  final String MESSAGE_KEY = "message";

  /* Send activation code constants */
  final String MOBILE_NUMBER = "mobile_number";
  final String MESSAGE_ID = "message_id";
  final String PER_PAGE = "per_page";

  /* Send activation code constants */
  final String SIGN_IN = "sign_in";

  /* verify otp constants */
  final String OTP = "otp";
  final String OS_VERSION = "os_version";
  final String OS_TYPE = "os_type";
  final String DEVICE_NAME = "device_name";
  final String DEVICE_TOKEN = "device_token";

  /*User Details Updation Request Constants*/
  final String ID = "id";
  final String FIRST_NAME = "first_name";
  final String LAST_NAME = "last_name";
  final String EMAIL = "email";

  /*Job Status Update Request*/
  final String DRIVER_ID = "driver_id";
  final String USER_ID = "user_id";
  final String STOP_ID = "stop_id";

  final String FIREBASE_UUID = "push_notification_identity";

  final String DISTANCE = "distance";

  final String TIME_ZONE = "time_zone";

  //Notification params
  final String FILTERED_DATE = "filtered_date";
  final String ROUTE_STATUS = "status";
  final String START_DATE = "from_date";

  final String START_DATE_TIME = "start_datetime";
  final String END_DATE_TIME = "end_datetime";

  //default values for app
  final String RADIUS_GEO_FENCE_ALERT = "radius_geo_fence_alert";
  final String DISTANCE_CURRENT_LOCATION = "distance_current_location";
  final String DISTANCE_BG_LOCATION_TRACK = "distance_bg_location_track";
  final String TIME_BG_LOCATION_TRACK = "time_bg_location_track";
  final String TIME_SERVER_SYNC = "time_server_sync";
  final String TIME_DRIVER_LOCATION = "time_driver_location";
  final String ROUTE_ID = "nav_route_id";
  final String IS_ENABLE_REMOTE_DEBUG = "is_enable_remote_debug";
  final String ALERT_DUR_BEFORE_ARRIVAL = "alert_duration_before_stop_arrival";

  //warehouse params
  final String SERIAL_NUMBER = "serial_number";
  final String ORGS_ID = "org_id";

  //warehouse put params
  final String ITEM_ID = "item_id";
  final String ORDER_STATUS_TO_RECIEVED = "order_status_to_recieved";
}
