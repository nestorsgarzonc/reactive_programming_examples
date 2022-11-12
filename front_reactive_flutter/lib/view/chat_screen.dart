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
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: SafeArea(
        child: Column(
          children: [
            const Text('Bienvenido al chat'),
            const SizedBox(height: 12),
            Text('Tu nombre es: ${ref.watch(chatProvider).userName}'),
            Spacer(),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 12,
                left: 12,
                right: 12,
              ),
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
                      //ref.read(chatProvider).connectToChat(_textController.text);
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
