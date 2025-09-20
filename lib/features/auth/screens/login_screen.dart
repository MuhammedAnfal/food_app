import 'package:flutter/material.dart';
import 'package:food_app/core/constants/string_constants.dart';
import 'package:food_app/core/utils/extension/size_extension.dart';
import 'package:food_app/core/utils/validators/app_validators.dart';
import 'package:food_app/features/auth/screens/widgets/custom_rounded_button.dart';
import 'package:food_app/features/home/screens/home_screen.dart';
import 'package:hive/hive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //-- variables
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  //-- user name field
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      validator: (value) {
                        return AppValidators.checkUserName(field: 'UserName', value: value!);
                      },
                      controller: userNameController,
                      decoration: InputDecoration(
                        hintText: 'UserName',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),

                  //-- password field

                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      validator: (value) {
                        return AppValidators.checkPassword(field: 'Password', value: value!);
                      },
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),

                  //-- login button
                  CustomRoundedButton(
                    padding: EdgeInsetsGeometry.only(top: 20),
                    buttonHeight: context.height * 0.06,
                    borderRadius: 20,
                    buttonColor: Colors.grey,
                    text: StringConstants.loginText,
                    onPressed: () async {
                      final settingsBox = Hive.box('settings');
                      await settingsBox.put('isLoggedIn', true);
                      if (formKey.currentState!.validate()) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false,
                        );
                      }
                    },
                    buttonWidth: context.width * 0.6,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
