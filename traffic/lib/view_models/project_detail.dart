import 'package:flutter/material.dart';
import 'package:traffic/data_sources/api_services.dart';

import '../models/project_detail.dart';

class DetailProjectViewModel with ChangeNotifier {
  ProjectDetail projectDetail = ProjectDetail(
    id: 1,
    name: "TestProject",
    material: "TestProject",
    budget: 100,
    description:
        "Việc sử dụng ảnh nền giúp trang web trông sinh động và bắt mắt hơn. Để chèn ảnh nền vào một thành phần trên trang web, chúng ta sử dụng thuộc tính background-image. Bây giờ chúng ta sẽ cùng làm một ví dụ minh họa để xem thuộc tính backgroundimage sẽ hoạt động ra sao. Đầu tiên hãy tìm một tấm ảnh mà bạn thích, ở đây tôi sẽ lấy tấm ảnh logo của Khoa Công nghệ thông tin Trường Đại học Công nghiệp Hà Nội. Sau đó, chúng ta sẽ viết CSS để đặt logo này làm ảnh nền trang web như sau:",
    startday: DateTime.parse("2003-18-10"),
    deadline: DateTime.parse("2003-18-10"),
    projects: [],
    people: [],
    status: 'done',
  );

  bool _isShowProjectItem = false;

  bool get isShowProjectItem => _isShowProjectItem;

  List<IconData> listIconProjectItem = [
    Icons.keyboard_arrow_right,
    Icons.keyboard_arrow_down,
  ];

  IconData iconProjectItem = Icons.arrow_forward_ios;

  void changeShowProjectItemToDefault() {
    _isShowProjectItem = false;
    notifyListeners();
  }

  void changeIconProjectItem() {
    _isShowProjectItem
        ? {iconProjectItem = listIconProjectItem[0]}
        : {iconProjectItem = listIconProjectItem[1]};
    notifyListeners();
  }

  void changeShowProjectItem() {
    _isShowProjectItem = !_isShowProjectItem;
    notifyListeners();
  }

  Future<void> addProject(
    String name,
    String material,
    String description,
    String startday,
    String deadline,
    String status,
    int budget,
    BuildContext context,
  ) async {
    await ApiServices(context).createProject(
        name, material, description, startday, deadline, status, budget);
    notifyListeners();
  }
}
