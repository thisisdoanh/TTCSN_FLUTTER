// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:traffic/models/project_detail.dart';
import 'package:traffic/resources/widgets/2_column_tff.dart';
import 'package:traffic/view_models/add_project_item_view_model.dart';
import 'package:traffic/view_models/add_project_view_model.dart';

import '../data_sources/api_services.dart';
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
import '../view_models/controller.dart';
import '../view_models/project_detail.dart';
import '../view_models/textstyle_view_model.dart';

class AddNewProjectItem extends StatefulWidget {
  AddNewProjectItem({super.key});

  @override
  State<AddNewProjectItem> createState() => _AddNewProjectItemState();
}

class _AddNewProjectItemState extends State<AddNewProjectItem> {
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

    return Scaffold(
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
                            'Thông tin hạng mục',
                            style: providerTextStyle.textStyleTextBoldSmall(),
                          ),
                          const SizedBox(
                            height: sizedBoxMedium,
                          ),
                          Custom2ColumnTFF(
                            onPressTFF: () {},
                            providerTextStyle: providerTextStyle,
                            controller: controllerName,
                            text: textProjectItemName,
                            validator: (value) {
                              if (value.toString().trim() == "") {
                                return "Không được để trống";
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
                              if (value.toString().trim() == "") {
                                return "Không được để trống";
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
                              if (value.toString().trim() == "") {
                                return "Không được để trống";
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
                              if (value.toString().trim() == "") {
                                return "Không được để trống";
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
                            controller: controllerLocation,
                            text: textProjectLocation,
                            validator: (value) {
                              if (value.toString().trim() == "") {
                                return "Không được để trống";
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
                            controller: controllerLabor,
                            text: textProjectLabor,
                            validator: (value) {
                              if (value.toString().trim() == "") {
                                return "Không được để trống";
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
                              if (value.toString().trim() == "") {
                                return "Không được để trống";
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
                              if (value.toString().trim() == "") {
                                return "Không được để trống";
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
                              if (value.toString().trim() == "") {
                                return "Không được để trống";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
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
                    text: "Thêm hạng mục",
                    function: () async {
                      if (formKey.currentState!.validate()) {
                        if (context.mounted) {
                          OverlayState overlayState = Overlay.of(context);
                          List<OverlayEntry> entries =
                              createOverlayLoading(context);
                          for (var element in entries) {
                            overlayState.insert(element);
                          }

                          ProjectDetail projectDetail = await ApiServices(context).createProjectItem(
                              controllerName.text,
                              controllerMaterial.text,
                              controllerDescription.text,
                              controllerStartdate.text,
                              controllerDeadline.text,
                              controllerStatus.text,
                              int.parse(controllerBudget.text));
                          
                          

                          context.read<AddProjectViewModel>().listPrjItem.add(projectDetail);
                          context.read<Controller>().setState();

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
