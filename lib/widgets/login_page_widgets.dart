import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/providers.dart';
import 'package:moon_design/moon_design.dart';

class LoginInput extends ConsumerStatefulWidget {
  const LoginInput({super.key});

  @override
  ConsumerState<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends ConsumerState<LoginInput> {
  bool _hidePassword = true;
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");
    return MoonTextInputGroup(children: [
      MoonFormTextInput(
          textInputSize: MoonTextInputSize.xl,
          controller: _textController,
          hintText: "Username",
          leading: const Icon(
            MoonIcons.generic_user_32_regular,
          ),
          validator: (value) => value?.length != null && value!.isEmpty
              ? "Username is reuquired"
              : null,
          trailing: GestureDetector(
            onTap: () => _textController.clear(),
            child: const Icon(MoonIcons.controls_close_small_24_light),
          ),
          onChanged: (value) {
            debugPrint(
                "Current user-pass value: ${_textController.text}||${_passwordController.text}");
            ref.read(loginUsernameProvider.notifier).state =
                _textController.text;
            ref.read(loginPasswordProvider.notifier).state =
                _passwordController.text;
          }),
      MoonFormTextInput(
          textInputSize: MoonTextInputSize.xl,
          controller: _passwordController,
          hintText: "Password",
          leading: const Icon(
            MoonIcons.security_password_32_regular,
          ),
          validator: (value) => value?.length != null && value!.isEmpty
              ? "Password is reuquired"
              : null,
          obscureText: _hidePassword,
          trailing: GestureDetector(
            onTap: () => setState(() => _hidePassword = !_hidePassword),
            child: Align(
              child: Text(_hidePassword ? "Show" : "Hide"),
            ),
          ),
          onChanged: (value) {
            debugPrint(
                "Current user-pass value: ${_textController.text}||${_passwordController.text}");
            ref.read(loginUsernameProvider.notifier).state =
                _textController.text;
            ref.read(loginPasswordProvider.notifier).state =
                _passwordController.text;
          })
    ]);
  }
}

class LoginButton extends ConsumerWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginUsername = ref.watch(loginUsernameProvider);
    final loginPassword = ref.watch(loginPasswordProvider);
    final accountprovider = ref.read(currentAccountProvider.notifier);

    return MoonFilledButton(
        label: const Text("Login"),
        onTap: () {
          debugPrint("user: $loginUsername pass: $loginPassword");
          accountprovider.login(loginUsername, loginPassword);
        });
  }
}

class RegisterButton extends ConsumerWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginUsername = ref.watch(loginUsernameProvider);
    final loginPassword = ref.watch(loginPasswordProvider);
    final accountprovider = ref.read(currentAccountProvider.notifier);

    return MoonFilledButton(
        label: const Text("Register"),
        onTap: () {
          debugPrint("user: $loginUsername pass: $loginPassword");
          accountprovider.registerAndLogin(loginUsername, loginPassword);
        });
  }
}
