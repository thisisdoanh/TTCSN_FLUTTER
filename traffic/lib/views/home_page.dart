// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:traffic/data_sources/data_user.dart';
import 'package:traffic/resources/routes_screens.dart';
import 'package:traffic/resources/widgets/appbar.dart';
import 'package:traffic/view_models/controller.dart';
import 'package:traffic/view_models/map_view_model.dart';
import 'package:traffic/view_models/project_detail.dart';

import '../data_sources/api_services.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../resources/utils/loading.dart';
import '../resources/widgets/button.dart';
import '../view_models/color_view_model.dart';
import '../view_models/textstyle_view_model.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  String lat = '0', long = '0';

  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future getUser() async {
    await ApiServices(context).fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    final providerColor = Provider.of<ColorViewModel>(context);
    final providerTextStyle = Provider.of<TextStyleViewModel>(context);
    final providerMap = Provider.of<MapViewModel>(context);
    final providerProject = Provider.of<Controller>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: CustomAppbar(
          function: () {},
          checkAction: true,
          checkLeading: false,
        ),
        body: Container(
          height: ScreenSize.height,
          width: ScreenSize.width,
          decoration: providerColor.isGradient ? providerColor.gradientColorBackground : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                assetImgLogo,
                fit: BoxFit.contain,
                height: ScreenSize.height * 0.2,
              ),
              const SizedBox(
                height: sizedBoxLarge,
              ),
              Text(
                "$textSloganHomePage Doanh",
                style: providerTextStyle.textStyleTitle(),
              ),
              const SizedBox(
                height: sizedBoxLarge,
              ),
              CustomButton(
                text: textTextMapHomePage,
                function: () async {
                  Position position = await _getCurrentLocation();

                  providerMap.lat = "${position.latitude}";
                  providerMap.long = "${position.longitude}";

                  _liveLocation();

                  Navigator.pushNamed(context, routeViewMapPage);
                },
                height: heightButton,
                width: ScreenSize.width * 0.9,
                textStyle: providerTextStyle.textStyleTextBoldButton(),
                borderRadius: borderRadiusButtonLarge,
                color: colorButton,
                iconLeading: Icons.map,
                iconSuffix: Icons.arrow_forward_ios,
                colorIcon: providerTextStyle.textColor,
              ),
              DataUser().role == "user"
                  ? Column(
                      children: [
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomButton(
                          text: textTextProjectHomePage,
                          function: () async {
                            // context.read<DetailProjectViewModel>().projectDetail =
                            //     await ApiServices().fetchUser();
                            context
                                .read<DetailProjectViewModel>()
                                .changeShowProjectItemToDefault();
                            Navigator.pushNamed(context, routeViewProjectPage);
                          },
                          height: heightButton,
                          width: ScreenSize.width * 0.9,
                          textStyle: providerTextStyle.textStyleTextBoldButton(),
                          borderRadius: borderRadiusButtonLarge,
                          color: colorButton,
                          iconLeading: Icons.map,
                          iconSuffix: Icons.arrow_forward_ios,
                          colorIcon: providerTextStyle.textColor,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomButton(
                          text: textTextProjectHomePageAdmin,
                          function: () async {
                            // await providerProject.addProject(
                            //     "name",
                            //     "material",
                            //     "description",
                            //     DateTime.now(),
                            //     DateTime.now(),
                            //     "status",
                            //     10, context);

                            if (context.mounted) {
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
                            }

                            providerProject.printAllPrj();

                            // a
                            Navigator.pushNamed(
                              context,
                              routeViewListProject,
                            );
                          },
                          height: heightButton,
                          width: ScreenSize.width * 0.9,
                          textStyle: providerTextStyle.textStyleTextBoldButton(),
                          borderRadius: borderRadiusButtonLarge,
                          color: colorButton,
                          iconLeading: Icons.map,
                          iconSuffix: Icons.arrow_forward_ios,
                          colorIcon: providerTextStyle.textColor,
                        ),
                      ],
                    ),
              DataUser().role != "user"
                  ? Column(
                      children: [
                        const SizedBox(
                          height: sizedBoxMedium,
                        ),
                        CustomButton(
                          text: textTextAddProjectHomePage,
                          function: () {
                            if (context.mounted) {
                              Navigator.pushNamed(context, routeAddProject);
                            }
                          },
                          height: heightButton,
                          width: ScreenSize.width * 0.9,
                          textStyle: providerTextStyle.textStyleTextBoldButton(),
                          borderRadius: borderRadiusButtonLarge,
                          color: colorButton,
                          iconLeading: Icons.map,
                          iconSuffix: Icons.arrow_forward_ios,
                          colorIcon: providerTextStyle.textColor,
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error("service unEnable");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("denied forever");
    }
    return await Geolocator.getCurrentPosition();
  }

  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );
    Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      Provider.of<MapViewModel>(context).lat = position.latitude.toString();
      Provider.of<MapViewModel>(context).long = position.longitude.toString();
    });
  }
}
