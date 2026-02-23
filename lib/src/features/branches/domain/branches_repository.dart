import '../data/branch_model.dart';

abstract class BranchesRepository {
  Future<List<BranchModel>> getBranches();
}
