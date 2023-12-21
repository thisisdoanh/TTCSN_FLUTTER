// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traffic/data_sources/api_services.dart';
import 'package:traffic/resources/colors.dart';
import 'package:traffic/resources/dimens.dart';
import 'package:traffic/resources/strings.dart';
import 'package:traffic/resources/widgets/appbar.dart';
import 'package:traffic/resources/widgets/button.dart';
import 'package:traffic/view_models/add_project_view_model.dart';
import 'package:traffic/view_models/color_view_model.dart';
import 'package:traffic/view_models/controller.dart';
import 'package:traffic/view_models/textstyle_view_model.dart';

import '../resources/routes_screens.dart';
import '../resources/utils/loading.dart';

class ListProjectScreen extends StatefulWidget {
  const ListProjectScreen({super.key});

  @override
  State<ListProjectScreen> createState() => _ListProjectScreenState();
}

class _ListProjectScreenState extends State<ListProjectScreen> {
  @override
  Widget build(BuildContext context) {
    final providerColor = Provider.of<ColorViewModel>(context);
    final providerTextStyle = Provider.of<TextStyleViewModel>(context);
    final providerController = Provider.of<Controller>(context);

    return Scaffold(
      appBar: CustomAppbar(
        function: () {},
        checkLeading: false,
        checkAction: true,
      ),
      body: Container(
        height: ScreenSize.height,
        width: ScreenSize.width,
        decoration: providerColor.isGradient
            ? providerColor.gradientColorBackground
            : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        textTextProjectHomePageAdmin,
                        style: providerTextStyle.textStyleTextBoldTittle(),
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        text: textTextAddProjectHomePage,
                        function: () {
                          context.read<AddProjectViewModel>().listPrjItem = [];
                          Navigator.pushNamed(context, routeAddProject).then((value) async {
                            OverlayState overlayState = Overlay.of(context);
                            List<OverlayEntry> entries =
                            createOverlayLoading(context);
                            for (var element in entries) {
                              overlayState.insert(element);
                            }

                            await ApiServices(context).fetchProjectDetail();

                            for (var element in entries) {
                              element.remove();
                            }

                            setState(() {
                            });
                          });
                        },
                        height: heightButton,
                        width: ScreenSize.width * 0.3,
                        textStyle:
                            providerTextStyle.textStyleTextBoldButtonSmall(),
                        borderRadius: borderRadiusButtonLarge,
                        color: colorButton,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  primary: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: providerController.projectDetailUser!.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            color: colorButton,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              await ApiServices(context).fetchProjectDetailID(
                                  providerController
                                      .projectDetailUser![index]!.id);

                              Navigator.pushNamed(
                                  context, routeViewProjectPage,
                                  arguments: {
                                    'isFetchId': 1,
                                  });
                            },
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Dự án ${providerController.projectDetailUser![index]!.id}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: providerTextStyle.textColor,
                                    fontSize: 17,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w900,
                                  ),
                                )),
                                GestureDetector(
                                  onTap: () {

                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        assetImgEdit,
                                        height: 30,
                                        width: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          backgroundColor: Colors.white,
                                          child: Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.black,
                                              ),
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: sizedBoxMedium,
                                                ),
                                                const Text(
                                                  "Bạn có chắc chắn muốn xoá dự án này?",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: sizedBoxMedium,
                                                ),
                                                Center(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: CustomButton(
                                                          text: "Có",
                                                          function: () async {
                                                            OverlayState
                                                                overlayState =
                                                                Overlay.of(
                                                                    context);
                                                            List<OverlayEntry>
                                                                entries =
                                                                createOverlayLoading(
                                                                    context);
                                                            for (var element
                                                                in entries) {
                                                              overlayState
                                                                  .insert(
                                                                      element);
                                                            }

                                                            String message = await ApiServices(
                                                                    context)
                                                                .deleteProject(providerController
                                                                    .projectDetailUser![
                                                                        index]!
                                                                    .id
                                                                    .toString());
                                                            await ApiServices(
                                                                    context)
                                                                .fetchProjectDetail();
                                                            setState(() {});

                                                            for (var element
                                                                in entries) {
                                                              element
                                                                  .remove();
                                                            }

                                                            showDialog(
                                                              context:
                                                                  context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                title: Text(
                                                                    message ??
                                                                        ""),
                                                              ),
                                                            );

                                                            Future.delayed(
                                                              const Duration(
                                                                  seconds: 2),
                                                              () {
                                                                Navigator.pop(
                                                                    context);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            );
                                                          },
                                                          height:
                                                              heightButton,
                                                          width:
                                                              widthButtonLogin +
                                                                  50,
                                                          textStyle:
                                                              providerTextStyle
                                                                  .textStyleTextBold(),
                                                          borderRadius:
                                                              borderRadiusButtonLarge,
                                                          color: colorButton,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        child: CustomButton(
                                                            text: "Không",
                                                            function: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            height:
                                                                heightButton,
                                                            width:
                                                                widthButtonLogin,
                                                            textStyle:
                                                                providerTextStyle
                                                                    .textStyleTextBold(),
                                                            borderRadius:
                                                                borderRadiusButtonLarge,
                                                            color:
                                                                colorButton),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        assetImgDelete,
                                        height: 30,
                                        width: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.black,
                                  size: 50,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (index + 1 !=
                            providerController.projectDetailUser!.length)
                          Divider(
                            thickness: 1,
                            color: Colors.black.withOpacity(0.2),
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
