import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/contacts_list.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/tab_contact_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

class ContactTab extends GetView<TabContactController> {
  const ContactTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool isSearching = controller.searchController.text.isNotEmpty;
    // bool listItemsExist = ((isSearching == true &&
    //         controller.contactsFiltered.value.length > 0) ||
    //     (isSearching != true && controller.contacts.value.length > 0));
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'contact'.tr,
          style: TextStyle(color: AppColors.light),
        ),
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Get.toNamed('/newfriend');
              },
              icon: Icon(Icons.person_add))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                controller: controller.searchController,
                onChanged: (value) => value == controller.searchController.text,
                decoration: InputDecoration(
                    labelText: 'Search',
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor)),
                    prefixIcon: Icon(Icons.search,
                        color: Theme.of(context).primaryColor)),
              ),
            ),
            Obx(() => controller.contactsLoaded.value
                ? // if the contacts have not been loaded yet
                controller.listItemsExist.value
                    ? // if we have contacts to show
                    ContactsList(
                        reloadContacts: () {
                          controller.getAllContacts();
                        },
                        contacts: controller.isSearching()
                            ? controller.contactsFiltered
                            : controller.contacts,
                      )
                    : Container(
                        padding: EdgeInsets.only(top: 40),
                        child: Text(
                          controller.isSearching()
                              ? 'No search results to show'
                              : 'No contacts exist',
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      )
                : Container(
                    // still loading contacts
                    padding: EdgeInsets.only(top: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}







// body: Container(
//           child: Column(
//             children: [
//               ListView.builder(
//                 itemBuilder: (context, index) => CustomContact(
//                   contact: controller.contacts[index],
//                 ),
//                 itemCount: controller.contacts.length,
//               ),
//             ],
//           ),
//         ));