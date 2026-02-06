import 'package:flutter/material.dart';
import '../../../core/error/app_exception.dart';
import '../../../core/response/api_responses.dart';
import '../data/branch_model.dart';
import '../domain/get_branches_usecase.dart';

class BranchesVM extends ChangeNotifier {
  final GetBranchesUseCase useCase;

  ApiResponces<List<BranchModel>> branchesResponse = ApiResponces.Idle();

  BranchesVM(this.useCase);

  Future<void> fetchBranches() async {
    branchesResponse = ApiResponces.Loading();
    notifyListeners();

    try {
      final data = await useCase.execute();
      branchesResponse = ApiResponces.Success(
        data,
        message: "Branches fetched successfully",
        success: true,
      );
    } on AppException catch (e) {
      branchesResponse = ApiResponces.Error(e.message, success: false);
    } catch (_) {
      branchesResponse = ApiResponces.Error(
        "Something went wrong",
        success: false,
      );
    }

    notifyListeners();
  }
}
