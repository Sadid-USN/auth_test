import 'package:auth_test/controller/auth_controller.dart';
import 'package:auth_test/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
      ),
      body: Consumer<AuthController>(
        builder: (context, value, child) {
          final email = value.profileData.user?.email;
          final nickname = value.profileData.user?.nickname;
          return value.isLogin ?
          
           Column(
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
                nickname ?? "null",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                email ?? "null",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: 16,
              ),
              Consumer<AuthController>(
                builder: (context, value, child) => AppButton(
                  padding: 0,
                  backgroundColor: Colors.white,
                  textColor: Colors.red,
                  title: "Выйти",
                  onTap: () {
                    value.logout(context);
                  },
                ),
              ),
            ],
          ) : const Center(child: CircularProgressIndicator(),);
        },
      ),
      bottomNavigationBar: const CurvedNavnBar()
    );
  }
}
