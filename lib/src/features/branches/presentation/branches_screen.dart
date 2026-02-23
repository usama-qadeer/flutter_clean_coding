import 'package:folder_stuture/core/shared/dialogs/app_dialogs.dart';
import 'package:folder_stuture/core/shared/widgets/custom_image_view.dart';
import 'package:folder_stuture/main_exports.dart';

import '../../../core/shared/state/status.dart';

class BranchesScreen extends StatelessWidget {
  const BranchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BranchesVM>(
      builder: (context, vm, _) {
        final response = vm.branchesResponse;

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AppDialogs.status(
                context: context,
                title: "Success!",
                message: "Your action was completed\nsuccessfully. Great job!",
                buttonText: "Go Home",
                onButtonPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          appBar: AppBar(
            title: const Text("Branches"),
            actions: [
              IconButton(
                onPressed: () {
                  final theme = context.read<ThemeVM>();
                  if (theme.mode == ThemeMode.dark) {
                    theme.setMode(ThemeMode.light);
                  } else {
                    theme.setMode(ThemeMode.dark);
                  }

                  // context.read<AuthState>().logout();
                },
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: Builder(
            builder: (_) {
              switch (response.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());

                case Status.ERROR:
                  return Center(
                    child: Text(
                      response.message ?? "Something went wrong",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );

                case Status.SUCCESS:
                  final data = response.data!;
                  if (data.isEmpty) {
                    return const Center(child: Text("No Branches Found"));
                  }
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (_, index) {
                      final branch = data[index];
                      return ListTile(
                        title: Text(branch.name),
                        subtitle: Text(branch.email),
                        leading: branch.image != null
                            ? CustomImageView(
                                height: 40.h,
                                width: 40.w,
                                imagePath:
                                    "${AppConfig.baseUrl}${branch.image!}",
                              )
                            : const Icon(Icons.store),
                      );
                    },
                  );

                case Status.IDLE:
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        );
      },
    );
  }
}
