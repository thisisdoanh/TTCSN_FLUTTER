// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic/data_sources/api_urls.dart';
import 'package:traffic/models/project_detail.dart';
import 'package:http/http.dart' as http;
import 'package:traffic/models/token.dart';
import 'package:traffic/models/user.dart';
import 'package:traffic/view_models/add_project_view_model.dart';
import 'package:traffic/view_models/controller.dart';

import '../models/location.dart';

class ApiServices {
  late BuildContext context;
  ApiServices(this.context);
  static int timeOutDuration = 20;

  Future<dynamic> fetchProjectDetail() async {
    var api = ApiUrls.baseUri + ApiUrls.uriProject;

    try {
      var response = await http.get(
        Uri.parse(api),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(Duration(seconds: timeOutDuration));
      final String jsonBody = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        String dataContainer = json.decode(jsonBody)["message"];
        return dataContainer;
      }

      List dataContainer = json.decode(jsonBody)["body"]["data"];

      Provider.of<Controller>(context, listen: false).projectDetailUser =
          dataContainer.map((e) => ProjectDetail.fromJson(e)).toList();

      return "";
    } on TimeoutException {
      return "Time out";
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> fetchLocationById(String id) async {
    var api = ApiUrls.baseUri + ApiUrls.uriLocation + id;

    try {
      var response = await http.get(
        Uri.parse(api),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(Duration(seconds: timeOutDuration));
      final String jsonBody = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        String dataContainer = json.decode(jsonBody)["message"];
        return dataContainer;
      }

      Location locations = Location.fromJson(json.decode(jsonBody));
      Provider.of<Controller>(context, listen: false).location = locations;
      return "";
    } on TimeoutException {
      return "Time out";
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> fetchAllUser() async {
    var api = "${ApiUrls.baseUri}${ApiUrls.uriUser}all-users";

    try {
      var response = await http.get(
        Uri.parse(api),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(Duration(seconds: timeOutDuration));
      final String jsonBody = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        String dataContainer = json.decode(jsonBody)["message"];
        return dataContainer;
      }

      List dataContainer = json.decode(jsonBody)["body"]["data"];

      List<User> listUser = dataContainer.map((e) => User.fromJson(e)).toList();

      return listUser;
    } on TimeoutException {
      return "Time out";
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> fetchProjectDetailID(int id) async {
    var api = ApiUrls.baseUri + ApiUrls.uriProject + id.toString();

    try {
      var response = await http.get(
        Uri.parse(api),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(Duration(seconds: timeOutDuration));
      final String jsonBody = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        String dataContainer = json.decode(jsonBody)["message"];
        return dataContainer;
      }

      final dataContainer = json.decode(jsonBody)["body"]["data"];

      Provider.of<Controller>(context, listen: false).projectDetailID =
          ProjectDetail.fromJson(dataContainer);

      return "";
    } on TimeoutException {
      return "Time out";
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> fetchUser() async {
    var api = ApiUrls.baseUri + ApiUrls.uriUser;

    try {
      var response = await http.get(
        Uri.parse(api),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              "${Provider.of<Controller>(context, listen: false).token!.tokenType} ${Provider.of<Controller>(context, listen: false).token!.accessToken}"
        },
      ).timeout(Duration(seconds: timeOutDuration));
      final String jsonBody = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        String dataContainer = json.decode(jsonBody)["message"];
        return dataContainer;
      }

      Map<String, dynamic> dataContainer =
          json.decode(jsonBody)["body"]["data"];

      Provider.of<Controller>(context, listen: false).user =
          User.fromJson(dataContainer);

      return "";
    } on TimeoutException {
      return "Time out";
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> fetchUserByID() async {
    var api = ApiUrls.baseUri +
            ApiUrls.uriUser +
            Provider.of<Controller>(context, listen: false)
                .user!
                .id
                .toString();


    try {
      var response = await http.get(
        Uri.parse(api),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(Duration(seconds: timeOutDuration));
      final String jsonBody = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        String dataContainer = json.decode(jsonBody)["message"];
        return dataContainer;
      }

      var dataContainer =
          json.decode(jsonBody)["body"]["data"];

      Provider.of<Controller>(context, listen: false).user =
          User.fromJson(dataContainer);

      return "";
    } on TimeoutException {
      return "Time out";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> sendUser(String username, String password) async {
    var api = ApiUrls.baseUri + ApiUrls.uriLogin;

    try {
      var response = await http
          .post(
            Uri.parse(api),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(
              {"username": username, "password": password},
            ),
          )
          .timeout(Duration(seconds: timeOutDuration));
      final String jsonBody = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        String dataContainer = json.decode(jsonBody)["message"];
        return dataContainer;
      }

      Map<String, dynamic> dataContainer = json.decode(jsonBody)["data"];
      Token token = Token.fromJson(dataContainer);

      Provider.of<Controller>(context, listen: false).token = token;

      debugPrint(token.authorities[0]["authority"]);

      return "";
    } on TimeoutException {
      return "Time out";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> createUser(
    String name,
    String username,
    String email,
    String password,
  ) async {
    var api = ApiUrls.baseUri + ApiUrls.uriUser;

    try {
      var response = await http
          .post(
            Uri.parse(api),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(
              {
                "username": username,
                "password": password,
                "email": email,
                "phone": "",
                "name": name,
                "gender": "",
                "age": 1,
                "address": ""
              },
            ),
          )
          .timeout(Duration(seconds: timeOutDuration));
      final String jsonBody = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        String dataContainer = json.decode(jsonBody)["message"];
        return dataContainer;
      }

      return "";
    } on TimeoutException {
      return "Time out";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> addUserToProject(String projectId, String userID) async {
    var api =
        "${ApiUrls.baseUri}${ApiUrls.uriProject}${ApiUrls.uriUser}$projectId/$userID";

    try {
      var response = await http.post(
        Uri.parse(api),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(Duration(seconds: timeOutDuration));
      final String jsonBody = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        String dataContainer = json.decode(jsonBody)["message"];
        return dataContainer;
      }

      String dataContainer = json.decode(jsonBody)["body"]['status'];

      return dataContainer;
    } on TimeoutException {
      return "Time out";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateUser(
    String name,
    String age,
    String address,
    String gender,
    String phoneNum,
  ) async {
    var api = ApiUrls.baseUri + ApiUrls.uriUser;

    try {
      var response = await http
          .put(
            Uri.parse(api),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization':
                  "${Provider.of<Controller>(context, listen: false).token!.tokenType} ${Provider.of<Controller>(context, listen: false).token!.accessToken}"
            },
            body: json.encode(
              {
                "name": name,
                "email":
                    Provider.of<Controller>(context, listen: false).user!.email,
                "gender": gender,
                "age": int.parse(age),
                "address": address,
                "phone": phoneNum
              },
            ),
          )
          .timeout(Duration(seconds: timeOutDuration));
      final String jsonBody = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        String dataContainer = json.decode(jsonBody)["message"];
        return dataContainer;
      }

      return "Success";
    } on TimeoutException {
      return "Time out";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateLocation(
    String id,
    String address,
    String image,
    double lat,
    double lng,
    String name,
    String phone,
    String region,
  ) async {
    var api = ApiUrls.baseUri + ApiUrls.uriLocation;

    try {
      var response = await http
          .put(
            Uri.parse(api),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(
              {
                "id": id,
                "address": address,
                "image": image,
                "lat": lat,
                "lng": lng,
                "name": name,
                "phone": phone,
                "region": region
              },
            ),
          )
          .timeout(Duration(seconds: timeOutDuration));
      final String jsonBody = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        String dataContainer = json.decode(jsonBody)["message"];
        return dataContainer;
      }

      return "Success";
    } on TimeoutException {
      return "Time out";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateProject(
    String id,
    String name,
    String material,
    String description,
    String startday,
    String deadline,
    String statusPrj,
    int budget,
  ) async {
    var api = ApiUrls.baseUri + ApiUrls.uriProject;

    try {
      var response = await http
          .put(
            Uri.parse(api),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(
              {
                "id": id,
                "name": name,
                "material": material,
                "budget": budget,
                "description": description,
                "startday": startday,
                "deadline": deadline,
                "status": statusPrj,
              },
            ),
          )
          .timeout(Duration(seconds: timeOutDuration));
      final String jsonBody = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        String dataContainer = json.decode(jsonBody)["message"];
        return dataContainer;
      }

      return "Success";
    } on TimeoutException {
      return "Time out";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> createProject(
    String name,
    String material,
    String description,
    String startday,
    String deadline,
    String statusPrj,
    int budget,
  ) async {
    var api = ApiUrls.baseUri + ApiUrls.uriProject;
    try {
      var response = await http
          .post(
            Uri.parse(api),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(
              {
                "name": name,
                "material": material,
                "budget": budget,
                "description": description,
                "startday": startday,
                "deadline": deadline,
                "status": statusPrj,
              },
            ),
          )
          .timeout(Duration(seconds: timeOutDuration));
      final String jsonBody = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        String dataContainer = json.decode(jsonBody)["message"];
        return dataContainer;
      }

      String status = json.decode(jsonBody)["body"]["status"];
      Map<String, dynamic> dataContainer =
          json.decode(jsonBody)["body"]["data"];

      ProjectDetail projectDetail = ProjectDetail.fromJson(dataContainer);

      Provider.of<AddProjectViewModel>(context, listen: false).id =
          projectDetail.id.toString() ?? "0";

      return status;
    } on TimeoutException {
      return "Time out";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> createLocation(
    String address,
    String image,
    double lat,
    double lng,
    String name,
    String phone,
    String region,
  ) async {
    var api = ApiUrls.baseUri + ApiUrls.uriLocation;
    try {
      var response = await http
          .post(
            Uri.parse(api),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(
              {
                "address": address,
                "image": image ?? "",
                "lat": lat,
                "lng": lng,
                "name": name,
                "phone": phone,
                "region": region
              },
            ),
          )
          .timeout(Duration(seconds: timeOutDuration));
      final String jsonBody = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        String dataContainer = json.decode(jsonBody)["message"];
        return dataContainer;
      }

      String status = json.decode(jsonBody)["body"]["status"];
      // Map<String, dynamic> dataContainer =
      //     json.decode(jsonBody)["body"]["data"];

      return status;
    } on TimeoutException {
      return "Time out";
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> createProjectItem(
    String name,
    String material,
    String description,
    String startday,
    String deadline,
    String statusPrj,
    int budget,
  ) async {
    var api = ApiUrls.baseUri + ApiUrls.uriProject;
    try {
      var response = await http
          .post(
            Uri.parse(api),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(
              {
                "name": name,
                "material": material,
                "budget": budget,
                "description": description,
                "startday": startday,
                "deadline": deadline,
                "status": statusPrj,
              },
            ),
          )
          .timeout(Duration(seconds: timeOutDuration));
      final String jsonBody = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        String dataContainer = json.decode(jsonBody)["message"];
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(dataContainer),
          ),
        );
        return;
      }

      String status = json.decode(jsonBody)["body"]["status"];
      Map<String, dynamic> dataContainer =
          json.decode(jsonBody)["body"]["data"];

      ProjectDetail projectDetail = ProjectDetail.fromJson(dataContainer);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(status),
        ),
      );

      return projectDetail;
    } on TimeoutException {
      return "Time out";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> addProjectItem(String id1, String id2) async {
    var api = "${ApiUrls.baseUri}${ApiUrls.uriProject}$id1/$id2";
    try {
      var response = await http.post(
        Uri.parse(api),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(Duration(seconds: timeOutDuration));
      final String jsonBody = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        String dataContainer = json.decode(jsonBody)["message"];
        return dataContainer;
      }

      String status = json.decode(jsonBody)["body"]["status"];

      return status;
    } on TimeoutException {
      return "Time out";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> forgotPass(String email) async {
    var api =
        "${ApiUrls.baseUri}${ApiUrls.uriUser}forgot-password?email=$email";
    try {
      var response = await http.post(
        Uri.parse(api),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(Duration(seconds: timeOutDuration));
      final String jsonBody = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        String dataContainer = json.decode(jsonBody)["message"];
        return dataContainer;
      }

      String status = json.decode(jsonBody)["body"]["status"];
      return status;
    } on TimeoutException {
      return "Time out";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> changePass(String pass) async {
    var api =
        "${ApiUrls.baseUri}${ApiUrls.uriUser}change-password?password=$pass";
    try {
      var response = await http.post(
        Uri.parse(api),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              "${Provider.of<Controller>(context, listen: false).token!.tokenType} ${Provider.of<Controller>(context, listen: false).token!.accessToken}"
        },
      ).timeout(Duration(seconds: timeOutDuration));
      final String jsonBody = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        String dataContainer = json.decode(jsonBody)["message"];
        return dataContainer;
      }

      String status = json.decode(jsonBody)["body"]["status"];
      return status;
    } on TimeoutException {
      return "Time out";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> deleteProject(String id) async {
    var api = "${ApiUrls.baseUri}${ApiUrls.uriProject}$id";
    try {
      var response = await http.delete(
        Uri.parse(api),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(Duration(seconds: timeOutDuration));
      final String jsonBody = utf8.decode(response.bodyBytes);
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        String dataContainer = json.decode(jsonBody)["message"];
        return dataContainer;
      }

      String status = json.decode(jsonBody)["body"]["data"];
      return status;
    } on TimeoutException {
      return "Time out";
    } catch (e) {
      return e.toString();
    }
  }
}
