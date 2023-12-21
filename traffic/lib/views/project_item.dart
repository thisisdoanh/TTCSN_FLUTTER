import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic/models/project_detail.dart';
import 'package:traffic/resources/strings.dart';
import 'package:traffic/resources/widgets/appbar.dart';
import 'package:traffic/view_models/project_detail.dart';

import '../resources/dimens.dart';
import '../resources/widgets/detail_project.dart';
import '../view_models/color_view_model.dart';
import '../view_models/textstyle_view_model.dart';

class ProjectItemScreen extends StatefulWidget {
  const ProjectItemScreen({super.key});



  @override
  State<ProjectItemScreen> createState() => _ProjectItemScreenState();
}

class _ProjectItemScreenState extends State<ProjectItemScreen> {
  @override
  Widget build(BuildContext context) {
    final ProjectDetail projectDetail = ModalRoute.of(context)?.settings.arguments as ProjectDetail;

    

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
        decoration: providerColor.isGradient ? providerColor.gradientColorBackground : null,
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
                  data: projectDetail!.id.toString() ?? "",
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                CustomDetail2Column(
                  providerTextStyle: providerTextStyle,
                  title: textProjectItemName,
                  data: projectDetail!.name,
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                CustomDetail2Column(
                  providerTextStyle: providerTextStyle,
                  title: textProjectStartDay,
                  data: projectDetail!.startday.toString(),
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                CustomDetail2Column(
                  providerTextStyle: providerTextStyle,
                  title: textProjectEndDay,
                  data: projectDetail!.deadline.toString(),
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                CustomDetail2Column(
                  providerTextStyle: providerTextStyle,
                  title: textProjectBudget,
                  data: projectDetail!.budget.toString(),
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                CustomDetail2Column(
                  providerTextStyle: providerTextStyle,
                  title: textProjectLocation,
                  data: projectDetail!.id.toString(),
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                CustomDetail2Column(
                  providerTextStyle: providerTextStyle,
                  title: textProjectLabor,
                  data: projectDetail!.budget.toString(),
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                CustomDetail2Column(
                  providerTextStyle: providerTextStyle,
                  title: textProjectMaterial,
                  data: projectDetail!.material,
                ),
                const SizedBox(
                  height: sizedBoxMedium,
                ),
                CustomDetail2Column(
                  providerTextStyle: providerTextStyle,
                  title: textProjectDescription,
                  data: projectDetail!.description,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
