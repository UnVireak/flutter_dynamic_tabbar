import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_tab_controller.dart';
import '../widget/reusable_widget.dart';
import '../widget/step_progress.dart';
import '../../enums/refund_tracking_status_enum.dart';
import '../../extensions/refund_tracking_status_extension.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  late HomeTabController controller;
  final PageController _pageController = PageController();
  final List<GlobalKey> _categoryKeys = [];
  final ScrollController _categoryScrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeTabController());
    _categoryKeys.addAll(List.generate(controller.tabData.length, (_) => GlobalKey()),
    );
  }
  void switchToCategory(String categoryId) {
    final index = controller.tabData.indexWhere((cat) => cat.id == categoryId);
    if (index != -1) {
      _pageController.jumpToPage(index);
    }
  }

  void _scrollCategoryToCenter(int index,{bool shouldScroll = true}){
    if(!shouldScroll || !_categoryScrollController.hasClients) return;

    final RenderBox? renderBox =
    _categoryKeys[index].currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);
    final screenWidth = MediaQuery.of(context).size.width;
    final listViewPosition = _categoryScrollController.position.pixels;
    final listViewOffset = position.dx + listViewPosition;
    final targetOffset = listViewOffset - (screenWidth / 2) + (size.width / 2);

    final clampedOffset = targetOffset.clamp(
      _categoryScrollController.position.minScrollExtent,
      _categoryScrollController.position.maxScrollExtent,
    );

    _categoryScrollController.animateTo(
      clampedOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
        ),
        child: Column(
          children: [
            //////////////////////////////////////////
            //// Order Process Step List Section /////
            //////////////////////////////////////////
            _buildOrderProcessSteps(),
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 56),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFE9E9E9),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(32),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 40),
                              Obx(() {
                                final status = RefundTrackingStatusEnum.fromCode(
                                  controller.status.value,
                                );
                                return Text(
                                  status.titleStatus,
                                  style: TextStyle(
                                    color: status.badgeTextColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                  ),
                                );
                              }),
                              const SizedBox(height: 20),
                              Obx(() {
                                return ERefundProgressSection(
                                  customerName: "Customer Requested",
                                  submittedDate: "06 May 2026",
                                  rejectedDate: "07 May 2026",
                                  shopName: "MDC Store",
                                  status: controller.status.value,
                                );
                              }),
                              SizedBox(height: 16,),
                              _buildOrderView(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Obx(() {
                      final status = RefundTrackingStatusEnum.fromCode(
                        controller.status.value,
                      );
                      return SizedBox(
                        width: 120,
                        height: 120,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: 120,
                                height: 60,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE9E9E9),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(60),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(28),
                                child: Container(
                                  width: 54,
                                  height: 54,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: status.storeImage,
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                        status.badgeTextColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _buildOrderProcessSteps(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          controller: _categoryScrollController,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          scrollDirection: Axis.horizontal,
          itemCount: controller.tabData.length,
          itemBuilder: (context, index) => Obx((){
            final category = controller.tabData[index];
            final isSelected = category.id == controller.selectedCategoryId.value;

            return InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              key: _categoryKeys[index],
              onTap: () {
                _scrollCategoryToCenter(index);
                controller.switchSelectedCategory(category.id);
                switchToCategory(category.id);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  spacing: 8,
                  children: [
                    Image.asset(category.icons!.first  , height: 18, color: isSelected ? Colors.white : Colors.blue),
                    Text(
                      category.title,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: isSelected ? Colors.white : Colors.blue,
                        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          separatorBuilder: (_, __) => const SizedBox(width: 15),
        ),
      ),
    );
  }

  Widget _buildOrderView() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
          child: PageView.builder(
            controller: _pageController,
            itemCount: controller.tabData.length,
            onPageChanged: (index) {

              controller.currentIndex.value = index;

              controller.switchSelectedCategory(
                controller.tabData[index].id,
              );
              _scrollCategoryToCenter(index);
            },
            itemBuilder: (_, index) {
              return ReusableTabScreen(
                categoryId: controller.tabData[index].id,
              );
            },
          ),
        ),
      ),
    );
  }
}