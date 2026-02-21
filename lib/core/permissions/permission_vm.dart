import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

enum PermissionGateState {
  checking,
  granted,
  denied, // user denied (can ask again)
  permanentlyDenied, // "Don't ask again"
}

class PermissionVM extends ChangeNotifier {
  PermissionGateState _state = PermissionGateState.checking;
  PermissionGateState get state => _state;

  bool get granted => _state == PermissionGateState.granted;
  bool get blocked =>
      _state == PermissionGateState.denied ||
      _state == PermissionGateState.permanentlyDenied;

  String get message {
    switch (_state) {
      case PermissionGateState.denied:
        return "Permission required to use the app. Please allow to continue.";
      case PermissionGateState.permanentlyDenied:
        return "Permission permanently denied. Please enable from Settings.";
      default:
        return "";
    }
  }

  /// ✅ Example: location permission. Replace with what you need.
  Future<void> checkAndRequest() async {
    _state = PermissionGateState.checking;
    notifyListeners();

    final status = await Permission.location.status;

    if (status.isGranted) {
      _state = PermissionGateState.granted;
      notifyListeners();
      return;
    }

    if (status.isPermanentlyDenied || status.isRestricted) {
      _state = PermissionGateState.permanentlyDenied;
      notifyListeners();
      return;
    }

    // Ask permission
    final result = await Permission.location.request();

    if (result.isGranted) {
      _state = PermissionGateState.granted;
    } else if (result.isPermanentlyDenied || result.isRestricted) {
      _state = PermissionGateState.permanentlyDenied;
    } else {
      _state = PermissionGateState.denied;
    }

    notifyListeners();
  }

  Future<void> openSettings() async {
    await openAppSettings();
  }
}
