import 'package:devemtiazecom/core/services/local_storage_services/secure_storage.dart';
import 'package:devemtiazecom/routes.dart';
import 'package:devemtiazecom/utils/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async{
      if(await SecureStorageHelper.instance.isLoggedIn()) {
        Get.offAllNamed(Routes.homeScreen);
      } else {
        Get.offAllNamed(Routes.loginScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    final String logo = ImagePath.splashLogo;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset(logo, width: screenWidth * .4)),
    );
  }
}
