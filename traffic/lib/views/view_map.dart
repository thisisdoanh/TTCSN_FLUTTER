import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../resources/dimens.dart';
import '../resources/widgets/appbar.dart';
import '../view_models/color_view_model.dart';
import '../view_models/map_view_model.dart';

class ViewMapScreen extends StatefulWidget {
  const ViewMapScreen({super.key});

  @override
  State<ViewMapScreen> createState() => _ViewMapScreenState();
}

class _ViewMapScreenState extends State<ViewMapScreen> {
  late GoogleMapController mapController;
  // late LatLng _center;

  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Map<String, String> dataUserLocation =
  //         ModalRoute.of(context)!.settings.arguments as Map<String, String>;
  //     _center = LatLng(double.parse(dataUserLocation["lat"]!),
  //         double.parse(dataUserLocation["long"]!));
  //   });
  // }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final providerColor = Provider.of<ColorViewModel>(context);
    final providerMap = Provider.of<MapViewModel>(context);

    return Scaffold(
      appBar: CustomAppbar(
        function: () {},
        checkAction: true,
        checkLeading: true,
      ),
      body: Container(
        height: ScreenSize.height,
        width: ScreenSize.width,
        decoration: providerColor.gradientColorBackground,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(double.parse(providerMap.lat),
                  double.parse(providerMap.long)),
              zoom: 15.0,
            ),
            mapType: MapType.normal,
            trafficEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            indoorViewEnabled: true,
          ),
        ),
      ),
    );
  }
}
