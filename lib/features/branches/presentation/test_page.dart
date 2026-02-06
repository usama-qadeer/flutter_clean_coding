import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folder_stuture/core/extensions/extensions.dart';
import 'package:folder_stuture/core/theme/app_button_style.dart';
import 'package:folder_stuture/core/theme/theme_vm.dart';
import 'package:folder_stuture/core/widgets/custom_elevted_button.dart';
import 'package:folder_stuture/core/widgets/custom_outline_button.dart';
import 'package:folder_stuture/core/widgets/input.dart';
import 'package:folder_stuture/core/widgets/progress_button.dart';
import 'package:provider/provider.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final theme = context.read<ThemeVM>();
              if (theme.mode == ThemeMode.dark) {
                theme.setMode(ThemeMode.light);
              } else {
                theme.setMode(ThemeMode.dark);
              }
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),

          AppInput(
            hintText: "Test ",
            labelText: "qwertyu",
            suffix: Icon(Icons.search),
            prefix: Icon(Icons.person),
            helperText: "password should be contain words ",
          ),
          CustomOutlinedButton(
            text: "Test",
            onPressed: () {},

            leftIcon: CustomProgressButton(),
          ),

          CustomElevatedButton(
            text: "fjgkfjgkf",
            isCircle: false,
            buttonStyle: AppButtonStyles.danger(context),
          ),
        ],
      ).px16,
    );
  }
}
