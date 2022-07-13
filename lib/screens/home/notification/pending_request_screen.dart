import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techstar/controllers/pending_request_screen_controller.dart';
import 'package:techstar/widgets/custom_loading_indicator.dart';
import 'package:techstar/widgets/requests_tile.dart';

class PendingRequestScreen extends StatefulWidget {
  static String routeName = '/pending_requests';
  const PendingRequestScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PendingRequestScreen> createState() => _PendingRequestScreenState();
}

class _PendingRequestScreenState extends State<PendingRequestScreen> {
  PendingRequestScreenController controller =
      Get.put(PendingRequestScreenController());
  @override
  Widget build(BuildContext context) {
    return GetX(builder: (PendingRequestScreenController controller) {
      if (controller.isConnected.value) {}
      return Scaffold(
        appBar: AppBar(
          title: const Text("Friend Requests"),
          elevation: 3,
        ),
        body: SafeArea(
          child: controller.isLoading.value
              ? Center(
                  child: CustomLoadingIndicator(
                    size: MediaQuery.of(context).size.width / 100 * 17,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.requests.length,
                  itemBuilder: (_, index) {
                    return RequestsTile(request: controller.requests[index]);
                  },
                ),
        ),
      );
    });
  }
}
