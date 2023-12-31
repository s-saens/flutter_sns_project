import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_sns_practice/components/chat_item.dart';
import 'package:flutter_sns_practice/datas/constants_firestore.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final messageTextController = TextEditingController();
  final scrollController = ScrollController();

  void scrollToBottom() {
    if (!scrollController.hasClients) return;
    print("1");
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + 50,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  postMessage(String message) {
    final currentUser = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance.collection(COLLECTIONS_USERS).add({
      DOCS_EMAIL: currentUser!.email,
      DOCS_MESSAGE: message,
      DOCS_TIMESTAMP: DateTime.now(),
    });

    scrollToBottom();

    messageTextController.clear();
  }

  getStreamBuilder() {
    final currentUser = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(COLLECTIONS_USERS).orderBy(DOCS_TIMESTAMP, descending: false).limitToLast(30).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (!scrollController.hasClients) SchedulerBinding.instance.addPostFrameCallback((_) => scrollToBottom());
          final len = snapshot.data!.docs.length;
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 100, top: 50),
            itemCount: len,
            itemBuilder: (context, index) {
              DocumentSnapshot docs = snapshot.data!.docs[index];
              return ChatItem(
                email: docs[DOCS_EMAIL],
                message: docs[DOCS_MESSAGE],
                timestamp: docs[DOCS_TIMESTAMP].toDate(),
                isMine: currentUser!.email == docs[DOCS_EMAIL],
              );
            },
            controller: scrollController,
          );
        } else if (snapshot.hasError) {
          return Text("Something went wrong: ${snapshot.error!}");
        } else {
          return const Text("Data does not exist");
        }
      },
    );
  }

  signOut() {
    FirebaseAuth.instance.signOut().then((_) => context.go('/'));
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              getStreamBuilder(),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: messageTextController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Message',
                                ),
                                onSubmitted: (value) => postMessage(value),
                              ),
                            ),
                            IconButton(
                              onPressed: () => postMessage(messageTextController.text),
                              icon: const Icon(Icons.send),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        theme.scaffoldBackgroundColor.withAlpha(255),
                        theme.scaffoldBackgroundColor.withAlpha(0),
                      ],
                    ),
                  ),
                  child: const SizedBox(height: 50),
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.cardColor.withAlpha(170),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    onPressed: signOut,
                    icon: const Icon(
                      Icons.logout,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
