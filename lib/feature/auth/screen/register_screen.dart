import 'package:devemtiazecom/core/constants/colors.dart';
import 'package:devemtiazecom/feature/auth/controller/auth_controller.dart';
import 'package:devemtiazecom/feature/common/custom_text_field.dart';
import 'package:devemtiazecom/routes.dart';
import 'package:devemtiazecom/utils/image_path.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final AuthController controller = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

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
                      'Register Now',
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
                    'Enter Your UserName',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: userNameController,
                    hint: 'Enter Username',
                    keyboardType: TextInputType.name,
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    'Enter Your Email',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: emailController,
                    hint: 'Enter Email',
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    'Set Password',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  Obx(
                    () => CustomTextField(
                      controller: passwordController,
                      hint: 'Enter Password',
                      obscureText: !controller.toggleRegisterPassVisibility.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.toggleRegisterPassVisibility.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          controller.toggleRegisterPassVisibility.value = !controller.toggleRegisterPassVisibility.value;
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (){
                          if(controller.isRegisterStateLoading.value) return;
                          controller.register(
                            email: emailController.text,
                            password: passwordController.text,
                            userName: userNameController.text,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: controller.isRegisterStateLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Register Now',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Already Have an Account? ",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: ' Login',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offAllNamed(Routes.loginScreen);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}