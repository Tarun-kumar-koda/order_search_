import 'package:dio/dio.dart';
import 'package:order_search/Utils/logger.dart';
import 'package:order_search/constant/api_constant.dart';
import 'package:order_search/services/session_manager.dart';

import '../constant/db_constant.dart';
import 'utils.dart';

class NetworkUtil {
  late Response response;
  Dio dio = Dio();
  SessionManager sessionManager = SessionManager();

  ///checks by hitting refresh token api and if api responds with 200 gets latest access token
  ///and returns true else if api response with 401, returns false and logs out of the app.
  Future<bool> tokenExpiryHandler() async {
    String refreshToken = await sessionManager.getRefreshToken();
    Utils.showLoadingDialog();
    try {
      dio = Dio(BaseOptions(
          headers: ApiConstant().getHeaders(await sessionManager.getAccessToken()),
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          connectTimeout: Duration(seconds: 60),
          receiveTimeout: Duration(seconds: 60)));
      var res = await dio
          .get('${ApiConstant.baseUrl}' "${ApiConstant.endPoint.REFRESH_TOKEN}", queryParameters: <String, dynamic>{
        ApiConstant.param.REFRESH_TOKEN: refreshToken,
        ApiConstant.param.CLIENT_ID: ApiConstant.clientId,
        ApiConstant.param.CLIENT_SECRET: ApiConstant.clientSecretKey,
        ApiConstant.param.GRANT_TYPE: "refresh_token",
      });
      Utils.hideLoadingDialog();
      if (res.statusCode == 200) {
        await sessionManager.setRefreshToken(res.data["refresh_token"]);
        await sessionManager.setAccessToken("bearer ${res.data["access_token"]}");
        // /// checking new access token
        // dio.options.headers = ApiConstant().getHeaders(await sessionManager.getAccessToken());
        // var secondaryRes = await dio.get('${ApiConstant.baseUrl}' "${ApiConstant.endPoint.GET_USER_PROFILE}");
        // if (secondaryRes.statusCode != 200) throw Exception("refresh token expired");
        return true;
      } else
        throw Exception("401");
    } catch (e) {
      print(e);
      await sessionManager.logOut();
      Utils.showToastMessage("logging out");
    }
    return false;
  }

  Future<Response?> getDio(String endPoint, String info, {headers, body}) async {
    dio = Dio(BaseOptions(headers: headers,contentType: 'application/json',
        receiveDataWhenStatusError: true,connectTimeout: Duration(seconds: 60),
        receiveTimeout: Duration(seconds: 60)));
    print('base url: ${ApiConstant.baseUrl}' '$endPoint' " calling:" "$info");
    Logger.logMessenger(msgTitle: "getDio", msgBody: {"body": body});
    try {
      var res = await dio.get('${ApiConstant.baseUrl}' '$endPoint', queryParameters: body);
      return res;
    } on DioException catch (e, stackTrace) {
      Logger.logMessenger(msgTitle: "getDio",msgBody: {"statusCode" : e.response?.statusCode});
      if (e.response?.statusCode == 401) {
        if (await tokenExpiryHandler()) {
          dio = Dio(BaseOptions(
              headers: ApiConstant().getHeaders(await SessionManager().getAccessToken()),
              contentType: 'application/json',
              receiveDataWhenStatusError: true,
              connectTimeout: Duration(seconds: 60),
              receiveTimeout: Duration(seconds: 60)));
          var reHitRes = await dio.get('${ApiConstant.baseUrl}' '$endPoint', queryParameters: body);
          return reHitRes;
        }
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        Utils.showToastMessage("Request timeout, please try again");
      } else if (e.type == DioExceptionType.connectionError) {
        Utils.showToastMessage("Network Error");
      }
      print(e);
      // if(e.) print(stackTrace);
      return e.response;
    }
  }

  Future<Response?> postDio(String endPoint, String reqType, {headers, body}) async {
    // Map<String,dynamic> preSetHeader = ApiConstant().getHeaders(await sessionManager.getAccessToken());
    dio = Dio(BaseOptions(headers: headers ?? ApiConstant().getHeaders(await sessionManager.getAccessToken()), contentType: 'application/json'));
    print('${ApiConstant.baseUrl}' '$endPoint');
    try {
      var res = await dio.post('${ApiConstant.baseUrl}' '$endPoint', queryParameters: body);
      return res;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        if (await tokenExpiryHandler()) {
          dio = Dio(BaseOptions(
              headers: ApiConstant().getHeaders(await SessionManager().getAccessToken()),
              contentType: 'application/json',
              receiveDataWhenStatusError: true,
              connectTimeout: Duration(seconds: 60),
              receiveTimeout: Duration(seconds: 60)));
          var reHitRes = await dio.get('${ApiConstant.baseUrl}' '$endPoint', queryParameters: body);
          return reHitRes;
        }
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        Utils.showToastMessage("Request timeout, please try again");
      } else if (e.type == DioExceptionType.connectionError) {
        Utils.showToastMessage("Network Error");
      }
      print(e);
      return e.response;
    }
  }

  Future<Response?> updateDio(String endPoint, {required Map<String, dynamic> headers, required body}) async {
    if (DBConstants.isOnline == false) {
      return null;
    }
    dio = Dio(BaseOptions(headers: headers, contentType: 'application/json'));
    print('${ApiConstant.baseUrl}' '$endPoint');
    try {
      var res = await dio.put('${ApiConstant.baseUrl}' '$endPoint', data: body);

      return res;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        if (await tokenExpiryHandler()) {
          dio = Dio(BaseOptions(
              headers: ApiConstant().getHeaders(await SessionManager().getAccessToken()),
              contentType: 'application/json',
              receiveDataWhenStatusError: true,
              connectTimeout: Duration(seconds: 60),
              receiveTimeout: Duration(seconds: 60)));
          var reHitRes = await dio.get('${ApiConstant.baseUrl}' '$endPoint', queryParameters: body);
          return reHitRes;
        }
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        Utils.showToastMessage("Request timeout, please try again");
      } else if (e.type == DioExceptionType.connectionError) {
        Utils.showToastMessage("Network Error");
      }
      print(e);
      return e.response;
    }
  }

  Future<Response?> deleteDio(String endPoint, String reqType, {headers, body}) async {
    dio = Dio(BaseOptions(headers: headers, contentType: 'application/json'));

    try {
      var res = await dio.delete('${ApiConstant.baseUrl}' '$endPoint', queryParameters: body);
      return res;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        if (await tokenExpiryHandler()) {
          dio = Dio(BaseOptions(
              headers: ApiConstant().getHeaders(await SessionManager().getAccessToken()),
              contentType: 'application/json',
              receiveDataWhenStatusError: true,
              connectTimeout: Duration(seconds: 60),
              receiveTimeout: Duration(seconds: 60)));
          var reHitRes = await dio.get('${ApiConstant.baseUrl}' '$endPoint', queryParameters: body);
          return reHitRes;
        }
      }
      Utils.showToastMessage("Request timeout, please try again");
      print(e);
      return e.response;
    }
  }
}
