import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_reactive_flutter/provider/chat_provider.dart';
import 'package:front_reactive_flutter/view/chat_screen.dart';

class OnBoardingScreen extends ConsumerWidget {
  OnBoardingScreen({super.key});

  static const route = '/on_boarding_screen';

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Para ingresar al chat, ingresa tu nombre:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _nameController,
                validator: (value) =>
                    (value ?? '').isEmpty ? 'El nombre no puede estar vacío' : null,
                decoration: const InputDecoration(
                  labelText: 'Ingresa tu nombre',
                  hintText: 'Ej. Juan Perez',
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref.read(chatProvider.notifier).connectToChat(_nameController.text);
                  Navigator.of(context).pushReplacementNamed(ChatScreen.route);
                }
              },
              child: const Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}
