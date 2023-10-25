// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_call/components/my_button.dart';
import 'package:flutter_application_call/components/my_textfield.dart';
import 'package:provider/provider.dart';

import '../services/auth/auth_service.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.onTap});
  static const routeName = '/register-page';
  final Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final nomeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirm_passwordController = TextEditingController();

  Future<void> signUpFunction() async {
    if (passwordController.text != confirm_passwordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Passwords do not match!")));
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);

    try{
      await authService.signUpWithEmailandPassword(emailController.text, passwordController.text, nomeController.text);
    } catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
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

              //name textfield
              MyTextField(
                  controller_val: nomeController,
                  labelText_val: 'nome',
                  obscureText_val: false),
              const SizedBox(height: 10),

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

              const SizedBox(height: 10),

              //ConfirmPassword textfield
              MyTextField(
                  controller_val: confirm_passwordController,
                  labelText_val: 'confirme senha',
                  obscureText_val: true),

              //sign in button
              const SizedBox(height: 20),

              MyButton(onTap_val: signUpFunction, login_val: false),

              const SizedBox(height: 10),

              //not a user
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Já é um usuário?',
                    style: TextStyle(
                        color: Color.fromARGB(200, 0, 7, 55), fontSize: 15),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Login',
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
