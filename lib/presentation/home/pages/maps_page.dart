import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kos_mobile_v2_testing/presentation/home/widgets/theme.dart';
import '../../../data/models/responses/product_response_mode.dart';

class MapsPage extends StatefulWidget {
  final ProductResponseModel productResponseModel;

  const MapsPage({super.key, required this.productResponseModel});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(-3.0071091198699884, 104.7257920329059);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> _createMarkers() {
    Set<Marker> markers = {};

    for (var product in widget.productResponseModel.data?.data ?? []) {
      if (product.latitude != null && product.longitude != null) {
        try {
          final lat = double.parse(product.latitude!);
          final lng = double.parse(product.longitude!);
          markers.add(
            Marker(
              markerId: MarkerId(product.idProduct.toString()),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(
                title: product.name,
                snippet: product.address,
              ),
            ),
          );
        } catch (e) {
          print('Error parsing latitude or longitude: $e');
        }
      } else {
        print('Product ${product.name} has no latitude or longitude');
      }
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Kos'),
        backgroundColor: bgColor,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _createMarkers(),
      ),
    );
  }
}
