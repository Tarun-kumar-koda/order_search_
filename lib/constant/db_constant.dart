import 'package:get/get_rx/src/rx_types/rx_types.dart';

class DBConstants {
  static const String DATABASE_NAME = "app_database.db";
  static const int DATABASE_VERSION = 6;
  static const String DATABASE_ID = "9089786756";

  static const int MAX_LOCATION_TRACKS_FOR_API_HIT = 50;

  static const int SYNC_STATUS_DEFAULT = 1000;
  static const int SYNC_STATUS_IN_PROGRESS = 1001;
  static const int SYNC_STATUS_SUCCESS = 1002;
  static const int SYNC_STATUS_FAILED = 1003;

  static const int ANSWER_TYPE_SURVEY = 1;
  static const int ANSWER_TYPE_FORM = 2;

  static final String PIC_TYPE_SIGNATURE = "signature";
  static final String PIC_TYPE_NORMAL = "normal";
  static final String PIC_TYPE_HIGH = "print";

  //NavRoute
  static const navRouteTable = "NavRoute";
  static const String id = 'id';
  static const String name = 'name';
  static const String scheduled_start_datetime = 'scheduled_start_datetime';
  static const String scheduled_end_datetime = 'scheduled_end_datetime';
  static const String actual_start_datetime = 'actual_start_datetime';
  static const String actual_end_datetime = 'actual_end_datetime';
  static const String status = 'status';
  static const String start_sync_status = 'start_sync_status';
  static const String complete_sync_status = 'complete_sync_status';
  static const String customer_order_ids = 'customer_order_ids';
  static const String first_stop_address = 'first_stop_address';
  static const String last_stop_address = 'last_stop_address';
  static const String stop = 'stops';
  static const String isVerified = 'is_verified';
  static const String syncStatus = 'sync_status';
  static const String isOrderChecked = "is_order_checked";
  static const String isOrderMoved = "is_order_moved";

  //Stops
  static const stopTable = "Stops";
  static const String nav_route_id = 'nav_route_id';
  static const String location_id = 'location_id';
  static const String location_name = 'location_name';
  static const String stop_code = 'stop_code';
  static const String stop_order_sequence = 'stop_order_sequence';
  static const String location_type = 'location_type';
  static const String lat_long = 'lat_long';
  static const String estimated_departure_date_time =
      'estimated_departure_date_time';
  static const String latest_estimated_date_time = 'latest_estimated_date_time';
  static const String estimated_arrival_date_time =
      'estimated_arrival_date_time';
  static const String contact_name = 'contact_name';
  static const String contact_phone_number_1 = 'contact_phone_number_1';
  static const String contact_phone_number_2 = 'contact_phone_number_2';
  static const String contact_email = 'contact_email';
  static const String exception_id = 'exception_id';
  static const String exception_code = 'exception_code';
  static const String exception_message = 'exception_message';
  static const String exception_comments = 'exception_comments';
  static const String geo_fence_exception = 'geo_fence_exception';
  static const String arrived_sync_status = 'arrived_sync_status';
  static const String stop_complete_sync_status = 'stop_complete_sync_status';
  static const String survey_id = 'survey_id';
  static const String is_submitted_survey = 'is_submitted_survey';
  static const String is_submitted_form = 'is_submitted_form';
  static const String survey_sync_status = 'survey_sync_status';
  static const String form_sync_status = 'form_sync_status';
  static const String attempts = 'attempts';
  static const String location = 'location';
  static const String contact_details = 'contact_details';
  static const String pickup_order_items = 'pickup_order_items';
  static const String drop_order_items = 'drop_order_items';
  static const String comments = 'comments';
  static const String account_order_ids = 'account_order_ids';
  static const String pictures = 'pictures';
  static const String accessorial = 'accessorial';
  static const String form_response = 'form_response';
  static const String stop_orders = 'stop_orders';
  static const String driver_order_items = 'order_items';

  //Orders
  static const ordersTable = "Orders";
  static const orderDetailsTable = "OrderDetails";
  static const String customer_order_id = 'customer_order_id';
  static const String customer_order_number = 'customer_order_number';
  static const String item_type = 'item_type';
  static const String item_model = 'item_model';
  static const String item_name = 'item_name';
  static const String service_ids = 'service_ids';
  static const String serial_number = 'serial_number';
  static const String miscellaneous = 'miscellaneous';
  static const String notes = 'notes';
  static const String item_quantity = 'item_quantity';
  static const String failed_notes = 'failed_notes';
  static const String pick_up_location_id = 'pick_up_location_id';
  static const String picked_at = 'picked_at';
  static const String drop_location_id = 'drop_location_id';
  static const String dropped_at = 'dropped_at';
  static const String pick_up_sync_status = 'pick_up_sync_status';
  static const String drop_sync_status = 'drop_sync_status';
  static const String return_authorization = 'return_authorization';
  static const String billing_number = 'billing_number';
  static const String barcode_info = 'barcode_info';
  static const String item_status = 'item_status';

  //Fleet orders table
  static const String fleet_orders_table = 'fleet_orders_table';
  static const String order_items = 'order_items';
  static const String order_number = 'order_number';

  static const String item_id = 'item_id';
  static const String order_id = 'order_id';
  static const String is_checked = 'is_checked';
  static const String current_wh_name = "current_wh_name";
  static const String is_contact_expand = "is_contact_expand";
  static const String is_order_expand = "is_order_expand";
  static const String nav_icon_contact = "nav_icon_contact";
  static const String nav_icon_order = "nav_icon_order";
  static const String is_order_info_expand = "is_order_info_expand";
  static const String nav_icon_order_info = "nav_icon_order_info";
  static const String item_serial_number = "item_serial_number";
  static const String item_model_name = "item_model";
  static const String is_scanned = "is_scanned";

  //Scan order Table
  static const String scan_orders_table = 'scan_orders_table';
  static const String scan_order_items = 'scan_order_items';
  static const String scan_order_number = 'scan_order_number';

  static const String scan_item_model = 'scan_item_model';
  static const String scan_item_name = 'scan_item_name';
  static const String scan_item_id = 'scan_item_id';
  static const String scan_order_id = 'scan_order_id';
  static const String scan_is_verified = 'scan_is_verified';
  static const String scan_current_wh_name = "scan_current_wh_name";

  //warehouse customers details
  static const String fleet_warehouse_table = "fleet_warehouse_table";
  static const String warehouse_model_list = "warehouse_list";
  static const String regional_warehouse = "name";
  static const String warehouse_phone_number = "phone";
  static const String warehouse_email = "email";
  static const String wh_first_name = "first_name";
  static const String wh_last_name = "last_name";
  static const String orders_model_list = "order_model_list";
  static const String customer_id = "customer_id";
  static const String customer_first_name = "customer_first_name";
  static const String customer_last_name = "customer_last_name";
  static const String customer_phone_one = "customer_phone_one";
  static const String customer_phone_two = "customer_phone_two";
  static const String customer_email = "customer_email";
  static const String customer_city = "customer_city";
  static const String customer_state = "customer_state";
  static const String customer_country = "customer_country";
  static const String customer_zipcode = "customer_zipcode";
  static const String customer_address_one = "customer_address_line";
  static const String customer_address_two = "customer_address_line_2";
  static const String item_weight = "item_weight";
  static const String wareHouseDock = "wh_dock";
  static const String companyName = "company_name";
  static const String hawb = "hawb";
  static const String mawb = "mawb";
  static const String orderWeight = "order_weight";
  static const String palletCount = "pallets";
  static const String orderType = "order_type";
  static const String levelOfService = "level_of_service";
  static const String billingNumber = "billing_number";
  static const String accountName = "account_name";
  static const String whDockTextField = "wh_dock_text_field";

  // Network management props
  static bool isSyncRunning = false;
  static Rx<bool> isOnline = false.obs;

}
