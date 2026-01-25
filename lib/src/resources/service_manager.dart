import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart' as http_parser;
import 'package:xcredo/src/utility/api_endpoints.dart';
import '../utility/local_storage.dart';


class ServiceManager {
  var baseUrl = ApiEndpoints.baseUrl  + ApiEndpoints.appVersion;
  //final AuthenticationService authService = AuthenticationService();

  Future<void> setToken(String token) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'token', value: token);
  }

  Future<String?> getTokenFromLocalStorage() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'token');
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await getTokenFromLocalStorage();

    return {
      'Content-Type':
      'application/json', // 'application/x-www-form-urlencoded', //
    };
  }

  Future<dynamic> get(String endpoint) async {
    final headers = await _getHeaders();

    final response = await http.get(
      Uri.parse(baseUrl + endpoint),
      headers: headers,
    );

    return response;
  }

  Future<dynamic> post(String endpoint, dynamic body) async {
    final headers = await _getHeaders();

    final response = await http.post(Uri.parse(baseUrl + endpoint),
        body: json.encode(body), headers: headers); // json.encode(body)

    return response;
  }

  Future<dynamic> MultipartRequest(
      String endpoint, Map<String, String> body, File? imageFile) async {
    final headers = await _getHeaders();

    final userId = await getLocalStorage('userID');

    var request = await http.MultipartRequest(
        'POST',
        Uri.parse(baseUrl +
            endpoint +
            '/$userId')); // 83e5ea45-60e7-48ee-8bc7-6f6da463b5eb

    request.headers.addAll(headers);
    request.fields.addAll(body); // add parameter here

    var reqPath = await http.MultipartFile.fromPath(
        'profile_pic', await imageFile?.path ?? '',
        filename: basename(imageFile?.path ?? ''),
        contentType: http_parser.MediaType('image', 'png'));

    request.files.add(reqPath);

    var streamResponse = await request.send();

    final response = await http.Response.fromStream(streamResponse);

    return response;
  }

  Future<dynamic> put(String endpoint, dynamic body) async {
    final headers = await _getHeaders();
    final response = await http.put(Uri.parse(baseUrl + endpoint),
        headers: headers, body: body);

    return response;
  }

  Future<dynamic> delete(String endpoint, dynamic body) async {
    final headers = await _getHeaders();

    final response = await http.delete(Uri.parse(baseUrl + endpoint),
        headers: headers); // ,body: json.encode(body)

    if (response.statusCode == 419) {
      return;
    }

    return response;
  }
}
