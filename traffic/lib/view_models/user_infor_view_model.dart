import 'package:flutter/material.dart';
import 'package:traffic/models/project_detail.dart';
import 'package:traffic/models/user.dart';

class UserInforViewModel with ChangeNotifier {
  User userInfo = User(
    name: "Trần Quốc Doanh",
    age: 20,
    gender: "Nam",
    address: "Số 34 Ngõ 132 Nguyên Xá, Minh Khai, Bắc Từ Liêm, Hà Nội",
    username: "thisisdoanh",
    email: "tranquocdoanhvq@gmail.com",
    phone: '123',
    id: 1,
    project: null,
  );
}
