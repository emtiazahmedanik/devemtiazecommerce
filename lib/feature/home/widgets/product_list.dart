import 'package:devemtiazecom/feature/home/controller/home_controller.dart';
import 'package:devemtiazecom/feature/home/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  final String tabKey;
  final HomeController homeController;

  const ProductList({
    super.key,
    required this.tabKey,
    required this.homeController,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => homeController.fetchProducts(),
      child: CustomScrollView(
        key: PageStorageKey(tabKey),
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 9/16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ProductCard(
                    product: homeController.productList[index],
                  );
                },
                childCount: homeController.productList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
