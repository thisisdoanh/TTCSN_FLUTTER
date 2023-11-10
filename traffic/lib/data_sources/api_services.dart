import 'dart:convert';

import 'package:traffic/data_sources/api_urls.dart';
import 'package:traffic/models/project_detail.dart';
import 'package:http/http.dart' as http;
import 'package:traffic/models/user.dart';
import 'package:traffic/resources/utils/fetch_data_exeption.dart';

class ApiServices {
  Future<ProjectDetail> fetchProjectDetail() async {
    var response = await http.get(Uri.parse("http://10.0.2.2:8080/project/1"));
    final jsonBody = response.body;
    final dataDecode = jsonDecode(jsonBody) as Map;
    final dataContainer = dataDecode["body"]["data"];
    ProjectDetail projectDetail = ProjectDetail.fromJson(dataContainer);
    return projectDetail;
  }

  Future<void> fetchUser() async {
    var uri = ApiUrls.baseUri + ApiUrls.uriUser;

    var response = await http.get(Uri.parse(uri));
    final String jsonBody = response.body;
    final int statusCode = response.statusCode;

    if (statusCode != 200 || jsonBody == null) {
      print(response.reasonPhrase);
      throw new FetchDataException(
          "StatusCode:$statusCode, Error:${response.reasonPhrase}");
    }
  }

  Future<void> sendUser(String username, String password) async {
    var api = ApiUrls.baseUri + ApiUrls.uriLogin;

    var response = await http.post(Uri.parse(api),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({"username": "doanhtran", "password": "12345"}));
    final String jsonBody = response.body;
    final int statusCode = response.statusCode;

    if (statusCode != 200 || jsonBody == null) {
      print(response.reasonPhrase);
      throw new FetchDataException(
          "StatusCode:$statusCode, Error:${response.reasonPhrase}");
    }
  }
  // }
  //   final response = await http.post(Uri.parse(api),

  //       /// put,get lay du lieu, delele xoa du lieu
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{
  //         // key: value
  //         'username': "doanhtran", //
  //         'password': "12345",
  //       }));

  //   if (response.statusCode == 200) {
  //     final responseData = json.decode(response.body)["data"];
  //     // print(responseData);
  //     // final accessToken = AccessToken.fromJson(responseData);
  //     // Get.find<AppControleer>().accessToken = accessToken;
  //     // Get.find<AppControleer>().currentUser =
  //     //     await GetApi.getCurrentUser(accessToken.accessToken);
  //     // print(Get.find<AppControleer>().currentUser?.userName);
  //     print("OK");
  //     return ;
  //   } else {
  //     print("Cút");
  //     return ;
  //     // If the server did not return a 200 OK response, throw an exception or handle the error.
  //   }
  // };
}
