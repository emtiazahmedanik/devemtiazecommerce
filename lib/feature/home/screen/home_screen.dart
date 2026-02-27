import 'package:devemtiazecom/feature/home/controller/home_controller.dart';
import 'package:devemtiazecom/feature/home/widgets/product_card.dart';
import 'package:devemtiazecom/feature/home/widgets/product_list.dart';
import 'package:devemtiazecom/feature/home/widgets/sticky_tab_delegate.dart';
import 'package:devemtiazecom/utils/image_path.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Obx(() {
            if (homeController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return NestedScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    title: Image.asset(ImagePath.homeScreenBack, height: 20),
                    floating: false,
                    pinned: false,
                    backgroundColor: Colors.white,
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 16),
                    sliver: SliverToBoxAdapter(
                      child: SizedBox(
                        height: 280,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: homeController.productList.length > 5
                              ? 5
                              : homeController.productList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 180,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ProductCard(
                                product: homeController.productList[index],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: StickyTabDelegate(
                      TabBar(
                        controller: homeController.tabController,
                        isScrollable: true,
                        physics: const ClampingScrollPhysics(),
                        tabAlignment: TabAlignment.start,
                        indicatorColor: Colors.redAccent,
                        labelColor: Colors.redAccent,
                        dividerColor: Colors.transparent,
                        unselectedLabelColor: Colors.black.withValues(
                          alpha: 0.6,
                        ),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.redAccent.withValues(alpha: 0.1),
                        ),
            
                        tabs: const [
                          IconTextTab(
                            text: "Trending",
                            icon: FontAwesomeIcons.fire,
                          ),
                          IconTextTab(
                            text: "Flash Sale",
                            icon: FontAwesomeIcons.bolt,
                          ),
                          IconTextTab(
                            text: "Fashion",
                            icon: FontAwesomeIcons.accusoft,
                          ),
                          IconTextTab(
                            text: "Best Deals",
                            icon: FontAwesomeIcons.tags,
                          ),
                          IconTextTab(
                            text: "Hot Offers",
                            icon: FontAwesomeIcons.hotjar,
                          ),
                          IconTextTab(
                            text: "For You",
                            icon: FontAwesomeIcons.heartCircleBolt,
                          ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: homeController.tabController,
                physics: const PageScrollPhysics(),
                children: [
                  ProductList(
                    tabKey: "trending",
                    homeController: homeController,
                  ),
                  ProductList(
                    tabKey: "flash_sale",
                    homeController: homeController,
                  ),
                  ProductList(
                    tabKey: "fashion",
                    homeController: homeController,
                  ),
                  ProductList(
                    tabKey: "best_deals",
                    homeController: homeController,
                  ),
                  ProductList(
                    tabKey: "hot_offers",
                    homeController: homeController,
                  ),
                  ProductList(
                    tabKey: "for_you",
                    homeController: homeController,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class IconTextTab extends StatelessWidget {
  final String text;
  final IconData icon;

  const IconTextTab({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 6),
            Text(text),
          ],
        ),
      ),
    );
  }
}
