import 'package:devemtiazecom/core/constants/urls.dart';
import 'package:devemtiazecom/core/services/local_storage_services/secure_storage.dart';
import 'package:devemtiazecom/core/services/network_services/network_client.dart';
import 'package:devemtiazecom/feature/profile/model/profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<ProfileModel?> profile = Rx<ProfileModel?>(null);
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile({String userId = '2'}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final token = await SecureStorageHelper.instance.getToken();
      
      final response = await NetworkClient.instance.getRequest(
        url: Urls.profile(userId),
        token: token ?? '',
      );

      if (response.isSuccess && response.responseData != null) {
        profile.value = ProfileModel.fromJson(response.responseData!);
        debugPrint('User profile fetched successfully');
      } else {
        errorMessage.value =
            response.errorMessage ?? 'Failed to fetch profile';
        if (kDebugMode) {
          print('Failed to fetch profile: ${response.errorMessage}');
        }
      }
    } catch (e) {
      errorMessage.value = 'Error fetching profile: $e';
      if (kDebugMode) {
        print('Error fetching profile: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
