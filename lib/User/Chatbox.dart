import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'alrman_theme_widgets.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController =
      TextEditingController();

  final ScrollController _scrollController =
      ScrollController();

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  String? _conversationId;
  bool _creatingConversation = true;

  @override
  void initState() {
    super.initState();
    _createConversation();
  }

  Future<void> _createConversation() async {
    final user = _auth.currentUser;

    if (user == null) {
      setState(() {
        _creatingConversation = false;
      });
      return;
    }

    final existing = await _firestore
        .collection('conversations')
        .where(
          'userId',
          isEqualTo: user.uid,
        )
        .where(
          'status',
          isEqualTo: 'active',
        )
        .limit(1)
        .get();

    if (existing.docs.isNotEmpty) {
      _conversationId = existing.docs.first.id;
    } else {
      final doc = await _firestore
          .collection('conversations')
          .add({
        'userId': user.uid,
        'userEmail': user.email ?? '',
        'status': 'active',
        'createdAt': FieldValue.serverTimestamp(),
        'lastMessage': '',
        'lastMessageAt': FieldValue.serverTimestamp(),
      });

      _conversationId = doc.id;
    }

    if (mounted) {
      setState(() {
        _creatingConversation = false;
      });
    }
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();

    if (text.isEmpty || _conversationId == null) {
      return;
    }

    final user = _auth.currentUser;

    if (user == null) return;

    _messageController.clear();

    await _firestore
        .collection('conversations')
        .doc(_conversationId)
        .collection('messages')
        .add({
      'senderId': user.uid,
      'senderType': 'user',
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await _firestore
        .collection('conversations')
        .doc(_conversationId)
        .update({
      'lastMessage': text,
      'lastMessageAt': FieldValue.serverTimestamp(),
      'status': 'waiting_admin',
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_creatingConversation) {
      return Scaffold(
        backgroundColor: AppColors.bg,
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_conversationId == null) {
      return Scaffold(
        backgroundColor: AppColors.bg,
        body: const Center(
          child: Text(
            'Please login to start a conversation.',
            style: TextStyle(
              color: AppColors.text,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.panel,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alrman Advertising',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Support Chat',
              style: TextStyle(
                fontSize: 11,
                color: Colors.greenAccent,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('conversations')
                  .doc(_conversationId)
                  .collection('messages')
                  .orderBy('createdAt')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final data =
                        messages[index].data()
                            as Map<String, dynamic>;

                    final isUser =
                        data['senderType'] == 'user';

                    return Align(
                      alignment: isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        constraints:
                            const BoxConstraints(
                          maxWidth: 300,
                        ),
                        margin:
                            const EdgeInsets.only(
                          bottom: 10,
                        ),
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isUser
                              ? AppColors.cyan
                              : AppColors.panel,
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                        child: Text(
                          data['text'] ?? '',
                          style: TextStyle(
                            color: isUser
                                ? const Color(0xFF04222A)
                                : AppColors.text,
                            fontSize: 13.5,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(
              12,
              8,
              12,
              12,
            ),
            color: AppColors.panel,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(
                      color: AppColors.text,
                    ),
                    maxLines: 4,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: const TextStyle(
                        color: AppColors.textDim,
                        fontSize: 13,
                      ),
                      filled: true,
                      fillColor: AppColors.bg,
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.cyan,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: Color(0xFF04222A),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}