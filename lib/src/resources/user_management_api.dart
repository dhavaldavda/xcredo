import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xcredo/src/resources/service_manager.dart';
import 'package:xcredo/src/models/login_model.dart';
import 'package:xcredo/src/utility/local_storage.dart';
import 'package:xcredo/src/utility/api_endpoints.dart';

class AuthenticationService {
  final ServiceManager serviceManager = ServiceManager();

  //MARK: Login API
  Future<void> loginAPi(String email, String password) async {
    String? notificationToken = await getLocalStorage('notificationToken');

    Map<String, String> parameter = {
      'email': email,
      'password': password,
      'token': notificationToken ?? ''
    };

    http.Response response = await serviceManager.post(ApiEndpoints.login, parameter);

    if (response.statusCode == 200) {
      print('login response is ${response.body}');

      if (json.decode(response.body)['code'] == 306) {
        throw Exception(response.reasonPhrase);
      }

      if (json.decode(response.body)['code'] == 305 ||
          json.decode(response.body)['code'] == 304 || json.decode(response.body)['code'] == 307) {
        // return json.decode(response.body)['psdata'];
        throw Exception(json.decode(response.body)['psdata']);
      }

      LoginModel jsonData = loginModelFromJson(response.body);

      final cookies = response.headers['set-cookie'];
      if (cookies != null) {
        print('Cookies received: $cookies');
      } else {
        print('No cookies received');
      }

      await setLocalStorage(
          'purchaseOrder', jsonData.psdata?.user?.purchaseOrder ?? '');
      await setLocalStorage(
          'customerTokenId', jsonData.psdata?.customerTokenId ?? '');
      await setLocalStorage('cookie', cookies);
      await setLocalStorage(
          'session_data', (jsonData.psdata?.sessionData ?? 0).toString());
      await setLocalStorage('customerId', jsonData.psdata?.user?.id ?? '');
      await setLocalStorage(
          'firstName', jsonData.psdata?.user?.firstname ?? '');
      await setLocalStorage('lastName', jsonData.psdata?.user?.lastname ?? '');
      await setLocalStorage('email', jsonData.psdata?.user?.email ?? '');

    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //MARK: forgot password api
  Future<String?> forgotPasswordAPi(String email) async {
    Map<String, String> parameter = {'email': email};

    http.Response response = await serviceManager.post(ApiEndpoints.forgotPassword, parameter);

    if (response.statusCode == 200) {
      print('response of register ${response.body}');

      if (json.decode(response.body)['psdata'] ==
          'An error occurred while sending the email.') {
        return 'Email not found. Please try again.';
      } else {
        return json.decode(response.body)['psdata'];
      }
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  //MARK: signup api
  Future<String?> signUpAPi(
      String firstName,
      String lastName,
      String email,
     ) async {
    Map<String, String> parameter = {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };

    http.Response response = await serviceManager.post(ApiEndpoints.register, parameter);

    if (response.statusCode == 200) {
      print('response of register ${response.body}');

      if (json.decode(response.body)['code'] == 200) {
        return 'Thanks for registering. You account is under \nreview and once approved one of our team will \nget in touch with you';
      }
      return json.decode(response.body)['psdata'];
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
