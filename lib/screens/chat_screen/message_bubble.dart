import 'package:ebuddy/screens/chat_screen/chat_controller.dart';
import 'package:ebuddy/stripe_services/stripe_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widgets.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
      required this.sender,
      required this.text,
      required this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<Widget?> amountModal(BuildContext context, ChatController chatC) async {
  return await showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      builder: (context) {
        return  Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: chatC.amountFormKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                            child: Text(
                          'Enter Amount',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        )),
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: KWidgets.textField(
                          txtController: chatC.amountTxt,
                          hintText: 'Amount',
                          validator: (roomName) {
                            if (roomName == null || roomName.isEmpty) {
                              return 'Amount cannot be empty';
                            }
                            return null;
                          },
                          keyboard: TextInputType.number,
                          maxLength: 10),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    OutlinedButton(
                        onPressed: () async {
                          if (chatC.amountFormKey.currentState!.validate()) {
                            try {
                              Navigator.pop(context);
                              await StripeService.initPaySheet(
                                  chatC.amountTxt.text).then((_) =>StripeService.stripe.presentPaymentSheet());

                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        child: const Text('Pay'))
                  ],
                ),
              ),
            ),
          );
      });
}
