import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic/resources/colors.dart';
import 'package:traffic/resources/routes_screens.dart';
import 'package:traffic/resources/strings.dart';
import 'package:traffic/resources/widgets/appbar.dart';
import 'package:traffic/resources/widgets/button.dart';
import 'package:traffic/view_models/project_detail.dart';

import '../resources/dimens.dart';
import '../resources/widgets/detail_project.dart';
import '../view_models/color_view_model.dart';
import '../view_models/textstyle_view_model.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerColor = Provider.of<ColorViewModel>(context);
    final providerTextStyle = Provider.of<TextStyleViewModel>(context);
    final providerDetailProject = Provider.of<DetailProjectViewModel>(context);

    return Scaffold(
      appBar:
          CustomAppbar(function: () {}, checkLeading: true, checkAction: true),
      body: Container(
        padding: const EdgeInsets.all(16),
        height: ScreenSize.height,
        width: ScreenSize.width,
        decoration: providerColor.gradientColorBackground,
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
                          data:
                              providerDetailProject.projectDetail.id.toString(),
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectName,
                          data: providerDetailProject.projectDetail.name,
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectStartDay,
                          data: providerDetailProject.projectDetail.startday
                              .toString(),
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectEndDay,
                          data: providerDetailProject.projectDetail.deadline
                              .toString(),
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectBudget,
                          data: providerDetailProject.projectDetail.budget
                              .toString(),
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectLocation,
                          data:
                              providerDetailProject.projectDetail.id.toString(),
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectLabor,
                          data: providerDetailProject.projectDetail.budget
                              .toString(),
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectMaterial,
                          data: providerDetailProject.projectDetail.material,
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectDescription,
                          data: providerDetailProject.projectDetail.description,
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
              Consumer<DetailProjectViewModel>(
                  builder: (context, providerDetailProject, _) =>
                      providerDetailProject.isShowProjectItem
                          ? SizedBox(
                              height: ScreenSize.height * 0.3,
                              child: ListView.builder(
                                itemCount: providerDetailProject
                                    .projectDetail.projects.length,
                                itemBuilder: (context, index) => Column(
                                  children: [
                                    const SizedBox(
                                      height: sizedBoxSmall,
                                    ),
                                    CustomButton(
                                      text: "Hạng mục ${index + 1}",
                                      function: () {
                                        Navigator.pushNamed(
                                            context, routeViewProjectItemPage);
                                      },
                                      height: heightButton,
                                      width: ScreenSize.width * 0.7,
                                      textStyle:
                                          providerTextStyle.textStyleTextBold(),
                                      borderRadius: borderRadiusButtonLarge,
                                      color: colorButton,
                                    ),
                                    const SizedBox(
                                      height: sizedBoxSmall,
                                    ),
                                    index + 1 !=
                                            providerDetailProject
                                                .projectDetail.projects.length
                                        ? Divider(
                                            indent: ScreenSize.width * 0.1,
                                            endIndent: ScreenSize.width * 0.1,
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
