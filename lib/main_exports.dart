export 'package:flutter/material.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
// CONFIG + THEME
export 'package:folder_stuture/core/constants/app_config.dart';
export 'package:folder_stuture/core/theme/app_theme.dart';
export 'package:folder_stuture/core/theme/theme_vm.dart';
export 'package:folder_stuture/core/storage/local_storage.dart';
export 'package:folder_stuture/routes/routes.dart';
// ROUTER
export 'package:go_router/go_router.dart';
export 'package:provider/provider.dart';

// NETWORK
export 'core/network/network_api_service.dart';
// AUTH
export 'features/auth/data/sources/auth_api.dart';
export 'features/auth/data/repositories/auth_repository_impl.dart';
export 'features/auth/presentation/providers/auth_state.dart';
export 'features/auth/domain/usecases/login_usecase.dart';
export 'features/auth/presentation/providers/login_vm.dart';
// BRANCHES
export 'features/branches/data/branches_api.dart';
export 'features/branches/data/branches_repository_impl.dart';
export 'features/branches/domain/get_branches_usecase.dart';
export 'features/branches/presentation/branches_vm.dart';
export 'main_common.dart';
