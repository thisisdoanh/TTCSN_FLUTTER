import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic/resources/strings.dart';
import 'package:traffic/resources/widgets/appbar.dart';
import 'package:traffic/view_models/project_detail.dart';

import '../resources/dimens.dart';
import '../resources/widgets/detail_project.dart';
import '../view_models/color_view_model.dart';
import '../view_models/textstyle_view_model.dart';

class ProjectItemScreen extends StatelessWidget {
  const ProjectItemScreen({super.key});

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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadiusButtonLarge),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textProjectItemDetail,
                  style: providerTextStyle.textStyleTextBoldSmall(),
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                CustomDetail2Column(
                  providerTextStyle: providerTextStyle,
                  title: textProjectItemId,
                  data: providerDetailProject.projectDetail.id.toString(),
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                CustomDetail2Column(
                  providerTextStyle: providerTextStyle,
                  title: textProjectItemName,
                  data: providerDetailProject.projectDetail.name,
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                CustomDetail2Column(
                  providerTextStyle: providerTextStyle,
                  title: textProjectStartDay,
                  data: providerDetailProject.projectDetail.startday.toString(),
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                CustomDetail2Column(
                  providerTextStyle: providerTextStyle,
                  title: textProjectEndDay,
                  data: providerDetailProject.projectDetail.deadline.toString(),
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                CustomDetail2Column(
                  providerTextStyle: providerTextStyle,
                  title: textProjectBudget,
                  data: providerDetailProject.projectDetail.budget.toString(),
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                CustomDetail2Column(
                  providerTextStyle: providerTextStyle,
                  title: textProjectLocation,
                  data: providerDetailProject.projectDetail.id.toString(),
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                CustomDetail2Column(
                  providerTextStyle: providerTextStyle,
                  title: textProjectLabor,
                  data: providerDetailProject.projectDetail.budget.toString(),
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
    );
  }
}
