import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/post_model.dart';
import '../model/tab_model.dart';
import '../repository/home_repository.dart';

class HomeTabController extends GetxController {

  final HomeRepository repository = HomeRepository();

  List<TabModel> tabData = [
    TabModel(id: '1', title: 'Pending', icons: ['assets/icons/pending_refund_fill.png','assets/icons/pending_refund_outline.png']),
    TabModel(id: '2', title: 'Success', icons: ['assets/icons/success_refund_fill.png', 'assets/icons/success_refund_outline.png']),
    TabModel(id: '3', title: 'Reject', icons: ['assets/icons/reject_refund_fill.png', 'assets/icons/reject_refund_outline.png']),
  ];

  final Map<String, Widget> screenCache = {};

  RxInt currentIndex = 0.obs;
  RxString selectedCategoryId = '1'.obs;
  RxInt status = 1.obs;

  RxMap<String, List<PostModel>> postData = <String, List<PostModel>>{}.obs;
  RxMap<String, bool> loading = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();

    for (final tab in tabData) {
      postData[tab.id] = [];
      loading[tab.id] = false;
    }
  }

  void switchSelectedCategory(String categoryId) {
    selectedCategoryId.value = categoryId;
    syncStatusFromCategory(categoryId);
  }

  void setStatus(int code) {
    status.value = code;
  }

  void syncStatusFromCategory(String categoryId) {
    switch (categoryId) {
      case '1':
        status.value = 1;
        break;
      case '2':
        status.value = 2;
        break;
      case '3':
        status.value = -1;
        break;
      default:
        status.value = 1;
    }
  }

  Future<void> fetchPosts(String categoryId) async {

    if (loading[categoryId] == true) {
      return;
    }

    if (postData[categoryId]!.isNotEmpty) {
      return;
    }

    loading[categoryId] = true;

    try {
      final response = await repository.fetchPosts(
        userId: int.parse(categoryId),
      );

      postData[categoryId] = response;
    } catch (e) {
      debugPrint(e.toString());
    }

    loading[categoryId] = false;
    postData.refresh();
  }
}