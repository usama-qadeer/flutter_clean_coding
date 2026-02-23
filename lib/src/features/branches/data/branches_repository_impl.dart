import '../../../core/error/app_exception.dart';
import '../domain/branches_repository.dart';
import 'branch_model.dart';
import 'branches_api.dart';

class BranchesRepositoryImpl implements BranchesRepository {
  final BranchesApi api;
  BranchesRepositoryImpl(this.api);

  @override
  Future<List<BranchModel>> getBranches() async {
    final res = await api.fetchBranchesJson();

    if (res is! Map<String, dynamic>) {
      throw const ServerException("Invalid response: expected object");
    }

    final success = res['success'] == true;
    if (!success) {
      final msg = res['message']?.toString() ?? "Unknown error";
      throw ServerException(msg);
    }

    final data = res['data'];
    if (data is! List) {
      throw const ServerException("Invalid response format");
    }

    return data
        .whereType<Map<String, dynamic>>()
        .map((e) => BranchModel.fromJson(e))
        .toList();
  }
}
