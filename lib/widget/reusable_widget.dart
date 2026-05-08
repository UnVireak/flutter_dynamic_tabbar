import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_tab_controller.dart';

class ReusableTabScreen extends StatelessWidget {

  final String categoryId;

  const ReusableTabScreen({
    super.key,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<HomeTabController>();

    controller.fetchPosts(categoryId);

    return Obx(() {

      final isLoading =
          controller.loading[categoryId] ?? false;

      final data =
          controller.postData[categoryId] ?? [];

      if (isLoading && data.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: data.length,
        separatorBuilder: (_, __) =>
        const SizedBox(height: 12),
        itemBuilder: (_, index) {

          final item = data[index];

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 8),

                Text(item.body),
              ],
            ),
          );
        },
      );
    });
  }
}