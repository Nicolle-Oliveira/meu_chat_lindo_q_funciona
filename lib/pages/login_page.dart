// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_call/components/my_button.dart';
import 'package:flutter_application_call/components/my_textfield.dart';
import 'package:provider/provider.dart';

import '../services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.onTap});
  static const routeName = '/login-page';
  final Function()? onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signInFunction() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              //logo
              Icon(
                Icons.message,
                size: 80,
              ),
              const SizedBox(height: 30),

              //email textfield
              MyTextField(
                  controller_val: emailController,
                  labelText_val: 'email',
                  obscureText_val: false),
              const SizedBox(height: 10),

              //password textfield
              MyTextField(
                  controller_val: passwordController,
                  labelText_val: 'senha',
                  obscureText_val: true),

              //sign in button
              const SizedBox(height: 20),

              MyButton(onTap_val: signInFunction, login_val: true),

              const SizedBox(height: 10),

              //not a user
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ainda não é um usuário?',
                    style: TextStyle(
                        color: Color.fromARGB(200, 0, 7, 55), fontSize: 15),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Registre',
                      style: TextStyle(
                        color: Color.fromARGB(255, 4, 2, 103),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
