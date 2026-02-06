import '../../../core/network/base_api_service.dart';

class BranchesApi {
  final BaseApiService apiService;
  BranchesApi(this.apiService);

  Future<Map<String, dynamic>> fetchBranches() async {
    final response = await apiService.get<Map<String, dynamic>>(
      '/get-branches',
    );
    return response;
  }
}
