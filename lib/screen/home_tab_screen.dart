import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_tab_controller.dart';
import '../widget/reusable_widget.dart';

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

            //////////////////////////////////////////
            ///////// Order List Section /////////////
            //////////////////////////////////////////
            _buildOrderView(),

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
                  // Image.asset(category.icons.first, height: 18, color: isSelected ? EAppColor.white : EAppColor.themeBottomColor),
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
