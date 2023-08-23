import 'package:auth_test/controller/login_controller.dart';
import 'package:auth_test/models/login_model.dart';
import 'package:auth_test/widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
      ),
      body: FutureBuilder<LoginModel?>(
        future: loginController.getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle error case but also check if snapshot.data is null
            if (snapshot.data == null) {
              return const Center(child: Text('No data available'));
            } else {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
          } else if (snapshot.hasData && snapshot.data != null) {
            final profileData = snapshot.data!;
            return SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Icon(
                      Icons.account_circle_outlined,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      profileData.user!.nickname ?? "null",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      profileData.user!.email ?? "null",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppButton(
                      padding: 0,
                      backgroundColor: Colors.white,
                      textColor: Colors.red,
                      title: "Выйти",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
