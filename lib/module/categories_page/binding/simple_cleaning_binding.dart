import 'package:get/get.dart';
import 'package:glowshoess.id/module/categories_page/controllers/simple_cleaning_controller.dart';

class SimpleCleaningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SimpleCleaningController>(() => SimpleCleaningController());
  }
}
