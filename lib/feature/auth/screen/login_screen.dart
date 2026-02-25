import 'package:devemtiazecom/core/constants/colors.dart';
import 'package:devemtiazecom/feature/auth/controller/auth_controller.dart';
import 'package:devemtiazecom/feature/common/custom_text_field.dart';
import 'package:devemtiazecom/utils/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController controller = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController(text: 'mor_2314');
  final TextEditingController passwordController = TextEditingController(text: '83r5^_');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,

              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(ImagePath.loginScreenBack),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.purple.withValues(alpha: 0.05),
                      Colors.purple.withValues(alpha: 0.85),
                    ],
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 70),
                    Text(
                      'Login Your Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Bring Your Desire Product from Around The World',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter Your Username',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  CustomTextField(
                    controller: emailController,
                    hint: 'Enter Username',
                    keyboardType: TextInputType.text,
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    'Enter Your Password',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  CustomTextField(
                    controller: passwordController,
                    hint: 'Enter Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 12),

                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (){
                          if(controller.isLoginStateLoading.value) return;
                          controller.login(
                            username: emailController.text,
                            password: passwordController.text,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: controller.isLoginStateLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Login',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Center(
                  //   child: RichText(
                  //     text: TextSpan(
                  //       text: "Don't Have an Account? ",
                  //       style: const TextStyle(color: Colors.black),
                  //       children: [
                  //         TextSpan(
                  //           text: ' Register Now',
                  //           style: const TextStyle(
                  //             color: AppColors.primaryColor,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //           recognizer: TapGestureRecognizer()
                  //             ..onTap = () {
                  //               Get.offAllNamed(
                  //                 Routes.registerScreen,
                  //               );
                  //             },
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
