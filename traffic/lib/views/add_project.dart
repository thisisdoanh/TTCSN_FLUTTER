// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
// import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
// import 'package:google_places_autocomplete_text_field/model/prediction.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:traffic/data_sources/api_services.dart';
import 'package:traffic/resources/widgets/2_column_tff.dart';
import 'package:traffic/view_models/add_project_item_view_model.dart';
import 'package:traffic/view_models/add_project_view_model.dart';
import 'package:traffic/view_models/controller.dart';
import 'package:traffic/views/add_project_item.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/routes_screens.dart';
import '../resources/strings.dart';
import '../resources/utils/loading.dart';
import '../resources/widgets/appbar.dart';
import '../resources/widgets/button.dart';
import '../resources/widgets/datetime_picker/datetime_picker.dart';
import '../resources/widgets/detail_project.dart';
import '../view_models/color_view_model.dart';
import '../view_models/project_detail.dart';
import '../view_models/textstyle_view_model.dart';

class AddNewProject extends StatelessWidget {
  AddNewProject({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerStartdate = TextEditingController();
  final TextEditingController controllerDeadline = TextEditingController();
  final TextEditingController controllerBudget = TextEditingController();
  final TextEditingController controllerLocation = TextEditingController();
  final TextEditingController controllerLabor = TextEditingController();
  final TextEditingController controllerMaterial = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();
  final TextEditingController controllerStatus = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final providerColor = Provider.of<ColorViewModel>(context);
    final providerTextStyle = Provider.of<TextStyleViewModel>(context);
    final providerDetailProject = Provider.of<AddProjectViewModel>(context);

    String region = "";
    String address = "Lỗi API Google Place. Trả về vị trí mặc định (21,102)";
    String name = "";
    String phone = "";
    double lat = 21;
    double lng = 102;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar:
          CustomAppbar(function: () {}, checkLeading: true, checkAction: true),
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(16),
          height: ScreenSize.height,
          width: ScreenSize.width,
          decoration: providerColor.isGradient
              ? providerColor.gradientColorBackground
              : null,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(borderRadiusButtonLarge),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: ScreenSize.height * 0.8,
                    width: ScreenSize.width,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Thêm dự án',
                            style: providerTextStyle.textStyleTextBoldSmall(),
                          ),
                          const SizedBox(
                            height: sizedBoxMedium,
                          ),
                          Custom2ColumnTFF(
                            providerTextStyle: providerTextStyle,
                            controller: controllerName,
                            text: textProjectName,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Vui lòng nhập tên dự án';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                          ),
                          const SizedBox(
                            height: sizedBoxMedium,
                          ),
                          Custom2ColumnTFF(
                            onPressTFF: () {
                              DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                minTime: DateTime(1900, 1, 1),
                                maxTime: DateTime(DateTime.now().year,
                                    DateTime.now().month, DateTime.now().day),
                                onConfirm: (date) {
                                  controllerStartdate.text =
                                      DateFormat('yyyy-MM-dd').format(date);
                                },
                                currentTime: DateTime.now(),
                              );
                            },
                            providerTextStyle: providerTextStyle,
                            controller: controllerStartdate,
                            text: textProjectStartDay,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Vui lòng nhập ngày bắt đầu dự án';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            isReadOnly: true,
                          ),
                          const SizedBox(
                            height: sizedBoxMedium,
                          ),
                          Custom2ColumnTFF(
                            onPressTFF: () {
                              DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                minTime: DateTime(1900, 1, 1),
                                maxTime: DateTime(DateTime.now().year,
                                    DateTime.now().month, DateTime.now().day),
                                onConfirm: (date) {
                                  controllerDeadline.text =
                                      DateFormat('yyyy-MM-dd').format(date);
                                },
                                currentTime: DateTime.now(),
                              );
                            },
                            providerTextStyle: providerTextStyle,
                            controller: controllerDeadline,
                            text: textProjectEndDay,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Vui lòng nhập ngày kết thúc dự án';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                          ),
                          const SizedBox(
                            height: sizedBoxMedium,
                          ),
                          Custom2ColumnTFF(
                            providerTextStyle: providerTextStyle,
                            controller: controllerBudget,
                            text: textProjectBudget,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Vui lòng nhập ngân sách';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                          ),
                          const SizedBox(
                            height: sizedBoxMedium,
                          ),
                          Text(
                            textAddress,
                            style: providerTextStyle
                                .textStyleTextBoldTitleDetailProject(),
                          ),
                          const SizedBox(
                            height: sizedBoxMedium,
                          ),
                          GooglePlaceAutoCompleteTextField(
                            boxDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    borderRadiusButtonLarge),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                )),
                            textEditingController: controllerLocation,
                            googleAPIKey:
                                "AIzaSyA8NhowPUdltptw8iZXmp47E0i-FCPwvrE",
                            inputDecoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 0),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            debounceTime: 400,
                            isLatLngRequired: true,
                            getPlaceDetailWithLatLng: (Prediction prediction) {
                              print("placeDetails" + prediction.lat.toString());
                              print("placeDetails" + prediction.lng.toString());
                              lat = double.parse(prediction?.lat ?? "21");
                              lng = double.parse(prediction?.lng ?? "102");
                              address = prediction?.description ?? "Lỗi API Google Place. Trả về mặc định";
                              region = prediction
                                      .terms![prediction.terms!.length - 1]
                                      .value ??
                                  "";
                            },
                            itemClick: (Prediction prediction) {
                              controllerLocation.text =
                                  prediction.description ?? "";
                              controllerLocation.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset:
                                        prediction.description?.length ?? 0),
                              );
                            },
                            seperatedBuilder: const Divider(),
                            itemBuilder:
                                (context, index, Prediction prediction) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const Icon(Icons.location_on),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                        child:
                                            Text(prediction.description ?? ""))
                                  ],
                                ),
                              );
                            },
                            isCrossBtnShown: true,
                          ),
                          const SizedBox(
                            height: sizedBoxMedium,
                          ),
                          Custom2ColumnTFF(
                            providerTextStyle: providerTextStyle,
                            controller: controllerLabor,
                            text: textProjectLabor,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Vui lòng nhập nhân công dự án';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                          ),
                          const SizedBox(
                            height: sizedBoxMedium,
                          ),
                          Custom2ColumnTFF(
                            providerTextStyle: providerTextStyle,
                            controller: controllerMaterial,
                            text: textProjectMaterial,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Vui lòng nhập vật liệu dự án';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                          ),
                          const SizedBox(
                            height: sizedBoxMedium,
                          ),
                          Custom2ColumnTFF(
                            providerTextStyle: providerTextStyle,
                            controller: controllerDescription,
                            text: textProjectDescription,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Vui lòng nhập mô tả';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                          ),
                          const SizedBox(
                            height: sizedBoxMedium,
                          ),
                          Custom2ColumnTFF(
                            providerTextStyle: providerTextStyle,
                            controller: controllerStatus,
                            text: "Trạng thái:",
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Vui lòng nhập trạng thái dự án';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                          ),
                          const SizedBox(
                            height: sizedBoxMedium,
                          ),
                          CustomButton(
                            text: textProjectItem,
                            function: () {
                              providerDetailProject.changeIconProjectItem();
                              providerDetailProject.changeShowProjectItem();
                            },
                            height: heightButton,
                            width: ScreenSize.width * 0.9,
                            textStyle: providerTextStyle.textStyleTextBold(),
                            borderRadius: borderRadiusButtonLarge,
                            color: colorButton,
                            iconSuffix: providerDetailProject.iconProjectItem,
                            colorIcon: colorTextBlack,
                          ),
                          Consumer<AddProjectViewModel>(
                            builder: (context, providerDetailProject, _) =>
                                (providerDetailProject.isShowProjectItem)
                                    ? Container(
                                        height: 200,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Số lượng: ${providerDetailProject.listPrjItem.length}",
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w900,
                                                    height: 0,
                                                  ),
                                                ),
                                                CupertinoButton(
                                                  child: const Text(
                                                    "Thêm",
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddNewProjectItem(),
                                                        ));
                                                  },
                                                )
                                              ],
                                            ),
                                            if (providerDetailProject
                                                    .listPrjItem.length !=
                                                0)
                                              Expanded(
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      providerDetailProject
                                                          .listPrjItem.length,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: sizedBoxSmall,
                                                      ),
                                                      CustomButton(
                                                        text:
                                                            "Hạng mục ${index + 1}",
                                                        function: () {
                                                          Navigator.pushNamed(
                                                              context,
                                                              routeViewProjectItemPage);
                                                        },
                                                        height:
                                                            heightButton * 0.8,
                                                        width:
                                                            ScreenSize.width *
                                                                0.7,
                                                        textStyle: providerTextStyle
                                                            .textStyleTextBold(),
                                                        borderRadius:
                                                            borderRadiusButtonLarge,
                                                        color: colorButton,
                                                      ),
                                                      const SizedBox(
                                                        height: sizedBoxSmall,
                                                      ),
                                                      index + 1 !=
                                                              providerDetailProject
                                                                  .listPrjItem
                                                                  .length
                                                          ? Divider(
                                                              indent: ScreenSize
                                                                      .width *
                                                                  0.1,
                                                              endIndent:
                                                                  ScreenSize
                                                                          .width *
                                                                      0.1,
                                                              color:
                                                                  Colors.black,
                                                              height: 4,
                                                              // thickness: 4,
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                Center(
                  child: CustomButton(
                    text: "Tạo dự án",
                    function: () async {
                      if (formKey.currentState!.validate()) {
                        if (context.mounted) {
                          OverlayState overlayState = Overlay.of(context);
                          List<OverlayEntry> entries =
                              createOverlayLoading(context);
                          for (var element in entries) {
                            overlayState.insert(element);
                          }

                          String message = await ApiServices(context)
                              .createLocation(
                                  address,
                                  "",
                                  lat,
                                  lng,
                                  "Dự án: ${controllerName.text}",
                                  phone,
                                  region);

                          message = await ApiServices(context).createProject(
                              controllerName.text,
                              controllerMaterial.text,
                              controllerDescription.text,
                              controllerStartdate.text,
                              controllerDeadline.text,
                              controllerStatus.text,
                              int.parse(controllerBudget.text));

                          for (int i = 0;
                              i <
                                  context
                                      .read<AddProjectViewModel>()
                                      .listPrjItem
                                      .length;
                              i++) {
                            message = await ApiServices(context).addProjectItem(
                                Provider.of<AddProjectViewModel>(context,
                                        listen: false)
                                    .id,
                                context
                                    .read<AddProjectViewModel>()
                                    .listPrjItem[i]
                                    .id
                                    .toString());
                            if (message.toLowerCase() != "success") {
                              break;
                            }
                          }
                          context.read<Controller>().setState();

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(message),
                            ),
                          );

                          Future.delayed(
                            const Duration(seconds: 2),
                            () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          );

                          for (var element in entries) {
                            element.remove();
                          }
                        }
                      }
                    },
                    height: heightButton,
                    width: widthButtonLogin,
                    textStyle: providerTextStyle.textStyleTextBoldButton(),
                    borderRadius: borderRadiusButtonLarge,
                    color: colorButton,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
