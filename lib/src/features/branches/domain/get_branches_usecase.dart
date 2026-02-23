import '../data/branch_model.dart';
import 'branches_repository.dart';

class GetBranchesUseCase {
  final BranchesRepository repository;
  GetBranchesUseCase(this.repository);

  Future<List<BranchModel>> execute() => repository.getBranches();
}
