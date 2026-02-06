import '../../../core/error/app_exception.dart';
import '../domain/branches_repository.dart';
import 'branch_model.dart';
import 'branches_api.dart';

class BranchesRepositoryImpl implements BranchesRepository {
  final BranchesApi api;
  BranchesRepositoryImpl(this.api);

  @override
  Future<List<BranchModel>> getBranches() async {
    final response = await api.fetchBranches();

    final success = response['success'] == true;
    if (!success) {
      final msg = response['message']?.toString() ?? "Unknown error";
      throw ServerException(msg);
    }

    final data = response['data'];
    if (data is! List) {
      throw const ServerException("Invalid response format");
    }

    return data.map((e) => BranchModel.fromJson(e)).toList();
  }
}
