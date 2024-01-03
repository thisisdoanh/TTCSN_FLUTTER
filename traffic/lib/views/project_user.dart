import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic/data_sources/api_services.dart';
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

class ProjectUserScreen extends StatefulWidget {
  final ProjectDetail? projectDetail;
  const ProjectUserScreen({super.key, this.projectDetail});

  @override
  State<ProjectUserScreen> createState() => _ProjectUserScreenState();
}

class _ProjectUserScreenState extends State<ProjectUserScreen> {

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
        decoration: providerColor.isGradient
            ? providerColor.gradientColorBackground
            : null,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadiusButtonLarge),
          ),
          child: widget.projectDetail == null ? Text("data") :Column(
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
                          data: widget.projectDetail!.id == null ? "0" : widget.projectDetail!.id.toString(),
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectName,
                          data: widget.projectDetail!.name == null ? "0" : widget.projectDetail!.name.toString(),
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectStartDay,
                          data: widget.projectDetail!.id == null ? "0" : widget.projectDetail!.id.toString(),
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectEndDay,
                          data: widget.projectDetail!.deadline == null ? "0" : widget.projectDetail!.deadline.toString(),
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectBudget,
                          data: widget.projectDetail!.budget == null ? "0" : widget.projectDetail!.budget.toString(),
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
                          title: textProjectMaterial,
                          data: widget.projectDetail!.material == null ? "0" : widget.projectDetail!.material.toString()
                        ),
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomDetail2Column(
                          providerTextStyle: providerTextStyle,
                          title: textProjectDescription,
                          data: widget.projectDetail!.description == null ? "0" : widget.projectDetail!.description.toString()
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

            ],
          ),
        ),
      ),
    );
  }
}
