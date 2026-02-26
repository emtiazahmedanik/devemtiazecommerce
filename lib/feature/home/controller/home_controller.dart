import 'package:devemtiazecom/core/constants/urls.dart';
import 'package:devemtiazecom/core/services/local_storage_services/secure_storage.dart';
import 'package:devemtiazecom/core/services/network_services/network_client.dart';
import 'package:devemtiazecom/feature/home/model/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxBool isLoading = false.obs;
  RxList<ProductModel> productList = <ProductModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 6, vsync: this);
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    productList.clear();
    final token = await SecureStorageHelper.instance.getToken();
    try {
      isLoading.value = true;
      final response = await NetworkClient.instance.getRequest(
        url: Urls.products,
        token: token ?? '',
      );
      final responseData = response.responseData;

      if (response.isSuccess && responseData!=null) {

        final List<dynamic> products = responseData['items'] ?? [];
        for (var item in products) {
          productList.add(ProductModel.fromJson(item));
        }
        debugPrint('Fetched ${productList.length} products');
        
      } else {
        if (kDebugMode) {
          print('Failed to fetch products: ${response.errorMessage}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching products: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
