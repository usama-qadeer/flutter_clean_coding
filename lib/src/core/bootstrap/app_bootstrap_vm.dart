import 'package:flutter/foundation.dart';
import 'package:folder_stuture/core/shared/state/api_response_helpers.dart';
import 'package:folder_stuture/features/branches/presentation/branches_vm.dart';

// ✅ Add your other VMs here
// import 'package:folder_stuture/features/profile/presentation/profile_vm.dart';
// import 'package:folder_stuture/features/permissions/presentation/permissions_vm.dart';
// import 'package:folder_stuture/features/settings/presentation/settings_vm.dart';

class AppBootstrapVM extends ChangeNotifier {
  final BranchesVM branchesVM;
  // final ProfileVM profileVM;
  // final PermissionsVM permissionsVM;
  // final SettingsVM settingsVM;

  bool _loading = false;
  bool get loading => _loading;

  bool _ready = false;
  bool get ready => _ready;

  String? _error;
  String? get error => _error;

  AppBootstrapVM({
    required this.branchesVM,
    // required this.profileVM,
    // required this.permissionsVM,
    // required this.settingsVM,
  });

  Future<void> load() async {
    if (_loading || _ready) return;

    _loading = true;
    _error = null;
    notifyListeners();

    try {
      // ✅ 1) Critical calls (parallel)
      await Future.wait([
        branchesVM.fetchBranches(),
        // profileVM.fetchProfile(),
        // permissionsVM.fetchPermissions(),
        // settingsVM.fetchSettings(),
      ]);

      // ✅ 2) Validate critical success
      if (branchesVM.branchesResponse.isError) {
        throw Exception(branchesVM.branchesResponse.errorMessageSafe);
      }

      // if (profileVM.profileResponse.isError) throw Exception(...);
      // if (permissionsVM.permissionsResponse.isError) throw Exception(...);

      // ✅ 3) Optional calls (don’t block app)
      // try { await someOptionalVM.fetchSomething(); } catch (_) {}

      _ready = true;
    } catch (e) {
      _ready = false;
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void reset() {
    _loading = false;
    _ready = false;
    _error = null;
    notifyListeners();
  }
}
