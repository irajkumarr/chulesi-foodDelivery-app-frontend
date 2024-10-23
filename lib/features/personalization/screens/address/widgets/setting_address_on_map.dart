import 'package:chulesi/core/utils/popups/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/features/personalization/providers/location_provider.dart';
import 'package:chulesi/features/personalization/providers/map_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/image_strings.dart';
import '../../../../../core/utils/constants/sizes.dart';

import 'package:geocoding/geocoding.dart';
import 'dart:async';

import '../../../../../core/utils/device/device_utility.dart';

class SettingAddressOnMapScreen extends StatefulWidget {
  const SettingAddressOnMapScreen({super.key});

  @override
  _SettingAddressOnMapScreenState createState() =>
      _SettingAddressOnMapScreenState();
}

class _SettingAddressOnMapScreenState extends State<SettingAddressOnMapScreen> {
  GoogleMapController? _controller;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  CameraPosition? _lastPosition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setInitialPosition();
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  Future<void> _setInitialPosition() async {
    final locationProvider = context.read<LocationProvider>();
    if (locationProvider.currentPosition != null) {
      final lat = locationProvider.currentPosition!.latitude;
      final lon = locationProvider.currentPosition!.longitude;
      final initialPosition = LatLng(lat, lon);
      _controller?.moveCamera(CameraUpdate.newLatLng(initialPosition));
      context.read<MapProvider>().setSelectedLocation(initialPosition);
    }
  }

  Future<void> _searchLocation() async {
    try {
      String query = _searchController.text;
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final location = locations.first;
        LatLng latLng = LatLng(location.latitude, location.longitude);
        _controller?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
        context.read<MapProvider>().setSelectedLocation(latLng);
      }
    } catch (e) {
      // print(e.toString());
      showToast(e.toString());
    }
  }

  void _onCameraMove(CameraPosition position) {
    _lastPosition = position;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      context.read<MapProvider>().setSelectedLocation(position.target);
    });
  }

  void _onCameraIdle() {
    if (_lastPosition != null) {
      context.read<MapProvider>().setSelectedLocation(_lastPosition!.target);
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
        child: Material(
          elevation: 1,
          child: AppBar(
            title: const Text("Your Location"),
          ),
        ),
      ),
      body: locationProvider.currentPosition == null
          ? const Center(
              child: CircularProgressIndicator(
                color: KColors.primary,
                strokeWidth: 3,
              ),
            )
          : Stack(
              children: [
                Consumer<MapProvider>(
                  builder: (context, mapProvider, child) {
                    return GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          locationProvider.currentPosition!.latitude,
                          locationProvider.currentPosition!.longitude,
                        ),
                        zoom: 16,
                      ),
                      onCameraMove: _onCameraMove,
                      onCameraIdle: _onCameraIdle,
                      // myLocationEnabled: true,
                      // myLocationButtonEnabled: true,
                      zoomControlsEnabled: false,
                    );
                  },
                ),
                Center(
                  child: Image.asset(
                    KImages.locationPin,
                    width: 40.w,
                    height: 40.h,
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 0,
                  left: 0,
                  // bottom: 30,
                  child: Consumer<MapProvider>(
                    builder: (context, mapProvider, child) {
                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: KSizes.md),
                        child: TextFormField(
                          controller: _searchController,
                          textInputAction: TextInputAction.search,
                          cursorColor: KColors.black,
                          onEditingComplete: _searchLocation,
                          style: Theme.of(context).textTheme.headlineSmall,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: KColors.white,
                              hintText:
                                  mapProvider.address ?? 'Search Location',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: KColors.darkGrey),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(23)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(23)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(23)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(23)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(23)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(23)),
                              prefixIcon: const Icon(
                                Icons.location_on,
                                color: KColors.primary,
                              ),
                              suffixIcon: IconButton(
                                  onPressed: _searchLocation,
                                  icon: Icon(
                                    Icons.search,
                                    color: KColors.primary,
                                  ))),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  left: 0,
                  child: Consumer<MapProvider>(
                    builder: (context, mapProvider, child) {
                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: KSizes.md),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23),
                          )),
                          onPressed: mapProvider.address == null
                              ? null
                              : () {
                                  Navigator.pop(context, mapProvider.address);
                                },
                          child: const Text("Confirm Location"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
