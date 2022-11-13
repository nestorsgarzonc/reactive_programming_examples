import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_reactive_flutter/provider/chat_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  static const route = '/chat_screen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _textController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: chatState.messages.isEmpty
                  ? const Center(
                      child: Text(
                        'Se el que da el primer paso... 😉',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22),
                      ),
                    )
                  : ListView.separated(
                      controller: ref.watch(chatProvider.notifier).scrollController,
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemCount: chatState.messages.length,
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (ctx, i) {
                        final item = chatState.messages[i];
                        return Column(
                          crossAxisAlignment:
                              item.isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.userName,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: item.isMine ? Colors.green[700] : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                item.message,
                                style: TextStyle(color: item.isMine ? Colors.white : Colors.black),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${item.sendAt.hour}:${item.sendAt.minute}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        );
                      },
                    ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: 'Escribe un mensaje...',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      ref.read(chatProvider.notifier).sendMessage(_textController.text);
                      _textController.clear();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
