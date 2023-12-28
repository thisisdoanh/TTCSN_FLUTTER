import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic/models/project_detail.dart';
import 'package:traffic/resources/colors.dart';
import 'package:traffic/resources/routes_screens.dart';
import 'package:traffic/resources/strings.dart';
import 'package:traffic/resources/widgets/appbar.dart';
import 'package:traffic/resources/widgets/button.dart';
import 'package:traffic/view_models/controller.dart';
import 'package:traffic/view_models/project_detail.dart';
import 'package:traffic/views/project_item.dart';

import '../resources/dimens.dart';
import '../resources/widgets/detail_project.dart';
import '../view_models/color_view_model.dart';
import '../view_models/textstyle_view_model.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  int isFetchId = -1;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Map<String, dynamic> argument =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      isFetchId = argument['isFetchId'];
      setState(() {});
    });

    print("ID:" +isFetchId.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerColor = Provider.of<ColorViewModel>(context);
    final providerTextStyle = Provider.of<TextStyleViewModel>(context);
    final providerDetailProject = Provider.of<DetailProjectViewModel>(context);
    final providerController = Provider.of<Controller>(context);

    return Scaffold(
      appBar:
          CustomAppbar(function: () {}, checkLeading: true, checkAction: true),
      body: Container(
        padding: const EdgeInsets.all(16),
        height: ScreenSize.height,
        width: ScreenSize.width,
        decoration: providerColor.isGradient ? providerColor.gradientColorBackground : null,
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
                          textProjectDetail,
                          style: providerTextStyle.textStyleTextBoldSmall(),
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectId,
                          data: isFetchId == 1
                              ? providerController.projectDetailID!.id
                                  .toString()
                              : providerDetailProject.projectDetail.id
                                  .toString(),
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectName,
                          data: providerController.projectDetailID!.name
                              .toString(),
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectStartDay,
                          data: isFetchId == 1
                              ? providerController.projectDetailID!.startday
                                  .toString()
                              : providerDetailProject.projectDetail.startday
                                  .toString(),
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectEndDay,
                          data: isFetchId == 1
                              ? providerController.projectDetailID!.deadline
                                  .toString()
                              : providerDetailProject.projectDetail.deadline
                                  .toString(),
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectBudget,
                          data: isFetchId == 1
                              ? providerController.projectDetailID!.budget
                                  .toString()
                              : providerDetailProject.projectDetail.budget
                                  .toString(),
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectLocation,
                          data: providerController.location!.offices.address,
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectLabor,
                          data: isFetchId == 1
                              ? providerController
                                  .projectDetailID!.people!.length
                                  .toString()
                              : providerDetailProject
                                  .projectDetail.people!.length
                                  .toString(),
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectMaterial,
                          data: isFetchId == 1
                              ? providerController.projectDetailID!.material
                                  .toString()
                              : providerDetailProject.projectDetail.material,
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectDescription,
                          data: isFetchId == 1
                              ? providerController.projectDetailID!.description
                                  .toString()
                              : providerDetailProject.projectDetail.description,
                        ),
                      ],
                    ),
                  ),
                ),
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
              isFetchId == 1
                  ? Consumer<Controller>(
                      builder: (context, providerController, _) =>
                          (providerDetailProject.isShowProjectItem &&
                                  providerController
                                          .projectDetailID!.projects!.length !=
                                      0)
                              ? SizedBox(
                                  height: ScreenSize.height * 0.3,
                                  child: ListView.builder(
                                    itemCount: providerController
                                        .projectDetailID!.projects!.length,
                                    itemBuilder: (context, index) => Column(
                                      children: [
                                        const SizedBox(
                                          height: sizedBoxSmall,
                                        ),
                                        CustomButton(
                                          text:
                                              "Hạng mục ${providerController.projectDetailID!.projects![index]!.id}",
                                          function: () async {
                                            Navigator.pushNamed(context,
                                                routeViewProjectItemPage,
                                                arguments: providerController
                                                    .projectDetailID!
                                                    .projects![index]);
                                          },
                                          height: heightButton,
                                          width: ScreenSize.width * 0.7,
                                          textStyle: providerTextStyle
                                              .textStyleTextBold(),
                                          borderRadius: borderRadiusButtonLarge,
                                          color: colorButton,
                                        ),
                                        const SizedBox(
                                          height: sizedBoxSmall,
                                        ),
                                        index + 1 !=
                                                providerController
                                                    .projectDetailID!
                                                    .projects!
                                                    .length
                                            ? Divider(
                                                indent: ScreenSize.width * 0.1,
                                                endIndent:
                                                    ScreenSize.width * 0.1,
                                                color: Colors.black,
                                                height: 4,
                                                // thickness: 4,
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                )
                              : Container())
                  : Consumer<DetailProjectViewModel>(
                      builder: (context, providerDetailProject, _) =>
                          (providerDetailProject.isShowProjectItem &&
                                  providerDetailProject
                                          .projectDetail.projects!.length !=
                                      0)
                              ? SizedBox(
                                  height: ScreenSize.height * 0.3,
                                  child: ListView.builder(
                                    itemCount: providerDetailProject
                                        .projectDetail.projects!.length,
                                    itemBuilder: (context, index) => Column(
                                      children: [
                                        const SizedBox(
                                          height: sizedBoxSmall,
                                        ),
                                        CustomButton(
                                          text: "Hạng mục ${index + 1}",
                                          function: () {
                                            Navigator.pushNamed(context,
                                                routeViewProjectItemPage);
                                          },
                                          height: heightButton,
                                          width: ScreenSize.width * 0.7,
                                          textStyle: providerTextStyle
                                              .textStyleTextBold(),
                                          borderRadius: borderRadiusButtonLarge,
                                          color: colorButton,
                                        ),
                                        const SizedBox(
                                          height: sizedBoxSmall,
                                        ),
                                        index + 1 !=
                                                providerDetailProject
                                                    .projectDetail
                                                    .projects!
                                                    .length
                                            ? Divider(
                                                indent: ScreenSize.width * 0.1,
                                                endIndent:
                                                    ScreenSize.width * 0.1,
                                                color: Colors.black,
                                                height: 4,
                                                // thickness: 4,
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                )
                              : Container())
            ],
          ),
        ),
      ),
    );
  }
}
