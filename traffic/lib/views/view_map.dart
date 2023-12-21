import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../resources/dimens.dart';
import '../resources/widgets/appbar.dart';
import '../view_models/color_view_model.dart';
import '../view_models/map_view_model.dart';
import '../models/google_map_location.dart' as locations;

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

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerColor = Provider.of<ColorViewModel>(context);
    final providerMap = Provider.of<MapViewModel>(context, listen: false);

    return Scaffold(
      appBar: CustomAppbar(
        function: () {},
        checkAction: true,
        checkLeading: true,
      ),
      body: Container(
        height: ScreenSize.height,
        width: ScreenSize.width,
        decoration: providerColor.isGradient ? providerColor.gradientColorBackground : null,
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
            markers: _markers.values.toSet(),
          ),
        ),
      ),
    );
  }
}
