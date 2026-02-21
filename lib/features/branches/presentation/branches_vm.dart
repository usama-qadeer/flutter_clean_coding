import 'package:flutter/material.dart';
import '../../../core/error/app_exception.dart';
import '../../../core/shared/state/api_responses.dart';
import '../data/branch_model.dart';
import '../domain/get_branches_usecase.dart';

class BranchesVM extends ChangeNotifier {
  final GetBranchesUseCase useCase;

  ApiResponses<List<BranchModel>> branchesResponse = ApiResponses.Idle();

  BranchesVM(this.useCase);

  Future<void> fetchBranches() async {
    branchesResponse = ApiResponses.Loading();
    notifyListeners();

    try {
      final data = await useCase.execute();
      branchesResponse = ApiResponses.Success(
        data,
        message: "Branches fetched successfully",
        success: true,
      );
    } on AppException catch (e) {
      branchesResponse = ApiResponses.Error(e.message, success: false);
    } catch (_) {
      branchesResponse = ApiResponses.Error(
        "Something went wrong",
        success: false,
      );
    }

    notifyListeners();
  }
}
