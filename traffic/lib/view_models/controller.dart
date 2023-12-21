import 'package:flutter/material.dart';
import 'package:traffic/models/project_detail.dart';
import 'package:traffic/models/user.dart';

import '../models/token.dart';

class Controller with ChangeNotifier {
  User? user;
  Token? token;
  List<ProjectDetail?>? projectDetailUser;

  ProjectDetail? projectDetailID;

  void setState(){
    notifyListeners();
  }

  void printAllPrj() {
    if (projectDetailUser != null) {
      for (var i = 0; i < projectDetailUser!.length; i++) {
        print(projectDetailUser![i].toString());
      }
    }
  }
}
