import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/src/cubit/weather_cubit.dart';

import 'navigation_service.dart';

class LocationService {
  final NavigationService _navigationService = NavigationService();
  Future<Position?> requestAndGetLocation(BuildContext context) async {
    PermissionStatus status = await Permission.location.request();
    if (context.mounted) {
      if (status.isGranted) {
        return await _getUserLocation(context);
      } else if (status.isDenied) {
        _showDialog(
          context,
          "Permission Denied",
          "This app needs location access to function properly. Please allow location permission.",
        );
      } else if (status.isPermanentlyDenied) {
        _showDialog(
          context,
          "Permission Permanently Denied",
          "You have permanently denied location access. Please enable it from app settings.",
          isSettingsRedirect: true,
        );
      }
    }
    return null;
  }

  Future<Position> _getUserLocation(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled && context.mounted) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Location Services Disabled"),
          content: const Text(
            "Please enable location services in your device settings to proceed.",
          ),
          actions: [
            TextButton(
              child: const Text("Open Settings"),
              onPressed: () {
                context.read<WeatherCubit>().emitEmptyState();
                Geolocator.openLocationSettings();
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                _navigationService.goBack();
              },
            ),
          ],
        ),
      );
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
      ),
    );
  }

  void _showDialog(BuildContext context, String title, String content,
      {bool isSettingsRedirect = false}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                _navigationService.goBack();
                context.read<WeatherCubit>().emitEmptyState();
                if (isSettingsRedirect) {
                  openAppSettings();
                }
              },
              child: Text(isSettingsRedirect ? "Go to Settings" : "OK"),
            ),
          ],
        );
      },
    );
  }
}
