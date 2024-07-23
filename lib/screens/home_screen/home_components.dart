import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:ebuddy/common_widgets.dart';
import 'package:ebuddy/screens/chat_screen/chat_screen.dart';
import 'package:ebuddy/screens/home_screen/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


Future<Widget?> newChat(BuildContext context,HomeController homeC) async {
  return await showModalBottomSheet(
    useSafeArea: true,
      isScrollControlled: true,
      context: context,
      isDismissible: false,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
      builder: (context) {
    return  Obx(
      ()=> Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,),
        child: Form(
          key: homeC.newChatFormKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Expanded(child: Text('Add New Chat',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)),
                      IconButton(onPressed: () => Navigator.pop(context)
                      , icon: const Icon(Icons.close))
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select User',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: homeC.userList
                            .map((user) => DropdownMenuItem(
                          value: user.email,
                          child: Text(
                            user.displayName,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                            .toList(),
                        value: homeC.selectedVal.value,
                        onChanged: (value) {
                          homeC.selectedVal.value = value;
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select user';
                          }
                          return null;
                        },
                        buttonStyleData:  ButtonStyleData(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: Get.width -16,
                        ),
                        decoration: InputDecoration(
                          // Add Horizontal padding using menuItemStyleData.padding so it matches
                          // the menu padding when button's width is not specified.
                          contentPadding: const EdgeInsets.symmetric(vertical: 3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.black,width: 5)
                          ),
                          // Add more decoration..
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        dropdownSearchData: DropdownSearchData(
                          searchController: homeC.searchTxt,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              expands: true,
                              maxLines: null,
                              controller: homeC.searchTxt,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Search for a user...',
                                hintStyle: const TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return item.value.toString().contains(searchValue);
                          },
                        ),
                        //This to clear the search value when you close the menu
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            homeC.searchTxt.clear();
                          }
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: KWidgets.textField(txtController: homeC.newChatTxt, hintText: 'chat topic',validator: (roomName) {
                      if(roomName == null || roomName.isEmpty){
                        return 'room name cannot be empty';
                      }
                      return null;
                    },
                        maxLength: 10),
                  ),
                  const SizedBox(height: 10,),
                  OutlinedButton(onPressed: () async {
                  if (homeC.newChatFormKey.currentState!.validate()) {
                    String result = await homeC.createNewChat();
                    if(result == 'successful'){
                      homeC.newChatSpinner.value =false;
                      if(context.mounted) Navigator.pop(context);
                      homeC.newChatTxt.clear();
                      KWidgets.snackAlert(status: 'New Chat', message: 'New Chat Added',direction: SnackPosition.TOP);
                    }
                    homeC.newChatSpinner.value =false;
                  }

                  }, child: const Text('Add Chat'))

                ],
            ),
          ),
        ),
      ),
    );
  });
}

Widget chatsList(HomeController homeC) {
  return ListView.builder(
    itemBuilder: (context, index) {
      return Obx(
            () => InkWell(
              onTap: () {
                Get.to(()=>const ChatScreen(),arguments: homeC.chats[index].id);
              },
              child: Card(
                        child: ListTile(
              leading: const Icon(Icons.person_outlined),
              title: Text(homeC.chats[index].text),
                        ),
                      ),
            ),
      );
    },
    itemCount: homeC.chats.length,
    shrinkWrap: true,
  );
}

Widget noChats() {
  return const Expanded(
    child: Center(
      child: Text('No Chats'),
    ),
  );
}