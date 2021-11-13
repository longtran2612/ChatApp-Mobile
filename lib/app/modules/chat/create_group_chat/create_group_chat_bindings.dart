import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/providers/contact_provider.dart';
import 'package:valo_chat_app/app/data/providers/profile_provider.dart';
import 'package:valo_chat_app/app/modules/chat/create_group_chat/create_group_chat_controller.dart';

class CreateGroupChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateGroupChatController(
        userProvider: ProfileProvider(), contactProvider: ContactProvider()));
  }
}
