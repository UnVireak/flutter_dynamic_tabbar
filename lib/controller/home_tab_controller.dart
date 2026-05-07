import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/post_model.dart';
import '../model/tab_model.dart';
import '../repository/home_repository.dart';

class HomeTabController extends GetxController {

  final HomeRepository repository = HomeRepository();

  List<TabModel> tabData = [
    TabModel(id: '1', title: 'Pending'),
    TabModel(id: '2', title: 'Success'),
    TabModel(id: '3', title: 'Reject'),
  ];

  final Map<String, Widget> screenCache = {};

  RxInt currentIndex = 0.obs;
  RxString selectedCategoryId = '1'.obs;

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