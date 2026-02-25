import 'package:devemtiazecom/core/constants/urls.dart';
import 'package:devemtiazecom/core/services/local_storage_services/secure_storage.dart';
import 'package:devemtiazecom/core/services/network_services/network_client.dart';
import 'package:devemtiazecom/feature/common/custom_flushbar.dart';
import 'package:devemtiazecom/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class AuthController extends GetxController {
  RxBool isLoginStateLoading = false.obs;
  RxBool isRegisterStateLoading = false.obs;

  RxBool toggleRegisterPassVisibility = false.obs;

  void login({required String username, required String password}) async {
    if(username.isEmpty || password.isEmpty) {
      CustomFlushbar.show(Get.context!, message: 'Username and password are required');
      return;
    }
    isLoginStateLoading.value = true;
    try {
      final postBody = {"username": 'mor_2314', "password": '83r5^_'};
      final response = await NetworkClient.instance.postRequest(
        url: Urls.login,
        body: postBody,
      );
      debugPrint(response.responseData.toString());
      if (response.isSuccess) {
        if(response.responseData?['token'] != null) {
          await SecureStorageHelper.instance.saveToken(response.responseData?['token']);
        }
        
        Get.offAllNamed(Routes.homeScreen);
      } else {
        CustomFlushbar.show(
          Get.context!,
          message: response.errorMessage ?? 'Failed to login',
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoginStateLoading.value = false;
    }
  }

  void register({
    required String email,
    required String password,
    required String userName,
  }) async {
    if (email.isEmpty || password.isEmpty || userName.isEmpty) {
      CustomFlushbar.show(Get.context!, message: 'All fields are required');
      return;
    }

    isRegisterStateLoading.value = true;
    try {
      final postBody = {
        "id": DateTime.now().millisecondsSinceEpoch,
        "username": userName,
        "email": email,
        "password": password,
      };
      final response = await NetworkClient.instance.postRequest(
        url: Urls.createUser,
        body: postBody,
      );
      final responseData = response.responseData;
      debugPrint("Register response ${responseData.toString()}");
      if (response.isSuccess) {
        CustomFlushbar.show(Get.context!, message: 'User created successfully');
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAllNamed(Routes.loginScreen);
        });
        
      } else {
        CustomFlushbar.show(
          Get.context!,
          message: response.errorMessage ?? 'Failed to create user',
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isRegisterStateLoading.value = false;
    }
  }
}
