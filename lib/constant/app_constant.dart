
import 'dart:ui';

class AppConstant{
  //Assets
  static const String splashScreenPath = "assets/images/splash_logo.png";
  static const String profileImage = "assets/images/account_profile.png";

  static const String mobileNumberText = "Mobile Number";
  static const String emptyMobileNumber = "Please enter mobile number";
  static const String inValidMobileNumber = "Please enter valid mobile number";
  static const String temporaryPassword = "Temporary Password";
  static const String oneTimePasswordHint = "A temporary password has been sent to \n number via text message";
  static const String verifyCode = "Verify Temporary Password";
  static const String resendOtp = "Re-send Temporary Password";
  static const String smsVerifyCodeNotThisNumber = "Re-enter Mobile Number";

  static const String networkNotConnected = "Could not connect app to the network. Please check your internet connection.";
  static const String enterValidSecurityCode = "Please enter valid security code.";
  static const String selectAll = "Select All";
  static const String swipeToStart = "Swipe To Start";
  static const String swipeToComplete = "Swipe To Complete";
  static const String contactInfo = "Contact Info";
  static const String appointment = "Appointment";
  static const String scheduledBegin = "Scheduled Begin";
  static const String scheduledEnd = "Scheduled End";
  static const String arrivedAtStop ="Arrived At Stop";
  static const String completeStop ="Complete Stop";
  static const String accessorials ="Accessorials";
  static const String form ="Form";
  static const String survey ="Survey";
  static const String signature ="Signature";
  static const String wareHouseList="WareHouse";
  static const String filter_serail_num = "Serial Number";
  static const String filter_order_num = "Customer Order Number";
  static const String filter_hawb = "HAWB";
  static const String filter_mawab = "MAWB" ;
  static const String currentWarehouse = "Current WareHouse";
  static const String searchItemBy = "Search Item By";
  static const String searchButton = "Search";
  static const String statusView = "Status: ";
  static const String cancelText = "Cancel";
  static const String deleteText = "Delete";
  static const String consigneeDetails = "Consignee Info";
  static const String orderDetails = "Order Details";
  static const String orderBilling = "Billing Number: ";
  static const String orderWeight = "Weight: ";
  static const String orderService = "Level Of Service: ";
  static const String orderCompany = "Company Name: ";
  static const String customerName = "Consignee Name: ";
  static const String customerPhone= "Phone Number: ";
  static const String cusEmail = "Email: ";
  static const String cusAddress = "Address: ";
  static const String scanMoreItems = "Scan More Items ";
  static const String openCamera = "Open Camera";
  static const String itemNotFound = "Item not found.";
  static const String selectDropDown = "--Select--";
  static const String exceptionMessage = "Exception Message";
  static const String selectException = "Please select one exception message";
  static const String enterException = "Please enter exception comment.";
  static const String enterComment = "Enter comments";
  static const String selectWareHouse = "Please select a warehouse to proceed";
  static const String unableToProceedRequest = "Unable to request data, try after sometimes.";
  static const String warehouses = "Warehouses" ;
  static const String saveText = "Save";
  static const String continueText = "Continue";
  static const String searchFilter = "Search Filter";
  static const String resetButtonText = "Reset";
  static const String pallets = "Pallets:";
  static const String pieces = "Pieces:";
  static const String WH_Loc = "WH Loc";
  static const String accountName = "Account Name: ";
  static const String newStatus = "NEW";
  static const String receivedStatus = "RECEIVED";
  static const String verifiedStatus = "VERIFIED";
  static const String assignedStatus = "ASSIGNED";
  static const String preparedStatus = "PREPARED";
  static const String dispatchedStatus = "DISPATCHED";
  static const String completedStatus = "COMPLETED";
  static const String exceptionStatus = "EXCEPTION";
  static const String otherOrders = "Others";
}

class AppLinks{
  static const String splashScreenNamedRoute = "/";
  static const String loginNamedRoute = "/login";
  static const String otpNamedRoute = "/otp";
  static const String routeListNamedRoute = "/route_list";
  static const String searchOrderView = "/search_order_view";
  static const String stopListNamedRoute = "/stop_list";
  static const String profileNamedRoute = "/profile";
  static const String historyListNamedRoute = "/history";
  static const String notificationListNamedRoute = "/notification";
  static const String stopDetailListNamedRoute = "/stop_detail";
  static const String OrderDetailsNamedRoute = "/order_details";
  static const String permissionsNamedRoute = "/permission_handler";
  static const String googleMapsNamedRoute = "/google_maps";
  static const String formViewRoute = "/form_view";
  static const String surveyViewRoute = "/surveyView";
  static const String signatureRoute = "/SignaturePage";
  static const String accessorialsNamedRoute = "/accessorials_view";
  static const String loadingView = "/loading_view";


}

class AppColor{
  /// darker blue [0035f5]
  /// more dark [0026ad]
  /// original blue [345FE9]
  static const String appPrimaryColor = "#0035f5"; _pri (){Color.fromARGB(255, 0, 54, 245);}
  static const String appSecondaryColor = "#1A45FF"; _sec (){Color.fromARGB(255, 26, 79, 255);}
  static const String appOtherColors = "#4F76F5FF"; _other (){Color.fromARGB(255, 82, 119, 239);}
  static const String attention = "#FF1A00"; _as2() => Color.fromARGB(255, 255, 26, 0);
  static const String success = "#1E7837";
  static const String inComplete = "#E3AAA6";
  static const String arrived = "#FFBA07";
  static const String mandatoryColor = "#FF3B30";
  static const String swipe_btn_bg = "#D3D3D3";
  static const String white = "#FFFFFF";
  static const String newStatusColor = "#2D9BF0";
  static const String exceptionColor = "#E85439";
  static const String receivedColor = "#99CC54";
  static const String otherStatusColor = "#41B8BD";
  static const String lightGrey = "#bdd7ff";
}