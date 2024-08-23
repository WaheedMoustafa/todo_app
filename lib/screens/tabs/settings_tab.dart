import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Todo Edit List'),
            backgroundColor: AppColors.primary,
          ),
          body: Column(
            children: [
              Container(
                color: AppColors.primary,
                height: 71,),
              Text('Language'),
              Text('Mode'),


            ],
          ),
        ));
  }
}
