// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:techstar/helper/string_res.dart';

Future<dynamic> simpleApiCaller(
    String apiName, Map<String, dynamic> params) async {
  try {
    http.Response response = await http.post(
      Uri.parse(StringRes.baseApiUrl + apiName),
      body: jsonEncode(params),
    );
    Map<String, dynamic> res = jsonDecode(response.body);
    return res;
  } catch (e) {
    Map<String, dynamic> res = {
      'status': false,
      'message': 'Sorry, some error occured.',
    };
    return res;
  }
}

Future<dynamic> multipartRequestApiCaller(String apiName, Map<String, String> params,List<http.MultipartFile> files) async {
  try {
    var request = http.MultipartRequest("POST",Uri.parse(StringRes.baseApiUrl + apiName));
    request.fields.addAll(params);
    request.files.addAll(files);
    var res = await http.Response.fromStream(await request.send());
    return jsonDecode(res.body);
  } catch (e) {
    Map<String, dynamic> res = {
      'status': false,
      'message': 'Sorry, some error occured.',
    };
    return res;
  }
}