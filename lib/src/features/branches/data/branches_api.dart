import '../../../core/network/base_api_service.dart';

class BranchesApi {
  final BaseApiService apiService;
  BranchesApi(this.apiService);

  Future<dynamic> fetchBranchesJson() {
    return apiService.get('/get-branches');
  }
}
