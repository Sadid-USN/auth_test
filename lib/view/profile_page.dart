import 'package:auth_test/widget/app_button.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
      ),
      body:  SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             const SizedBox(height: 40,),
              const Icon(
                Icons.account_circle_outlined,
              ),
               const SizedBox(height: 16,),
               Text("DATA", style: Theme.of(context).textTheme.labelLarge,),
                const SizedBox(height: 16,),
               Text("email", style: Theme.of(context).textTheme.labelMedium,),
                const SizedBox(height: 16,),
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
      ),
    );
  }
}
