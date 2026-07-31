import 'package:events/core/utils/app_colors.dart';
import 'package:events/core/widget/custom_button.dart';
import 'package:events/core/widget/custom_text_field.dart';
import 'package:events/feature/auth/login/login_page.dart';
import 'package:events/feature/homePage/tabs/home_tap.dart';
import 'package:events/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  bool _obscurePassword = true;
  var nameController = TextEditingController(text: 'leen');
  var emailController = TextEditingController(text: 'leen@gmail.com');
  var passwordController = TextEditingController(text: 'leen123');
  var recontroller = TextEditingController(text: 'leen123');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(child: CircleAvatar(radius: 100)),
                const SizedBox(height: 50),
                CustomTextField(
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "please enter name";
                    }
                    return null;
                  },
                  controller: nameController,
                  hintText: loc.name,
                  prefixIcon: const Icon(Icons.email),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  hintText: loc.email,
                  prefixIcon: const Icon(Icons.email),
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "please enter email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  hintText: loc.password,
                  prefixIcon: const Icon(Icons.lock),
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "please enter password";
                    }
                    if (text.length < 6) {
                      return "password should be at least 6 char";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: recontroller,
                  hintText: loc.repassword,
                  prefixIcon: const Icon(Icons.lock),
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "please enter password";
                    }
                    if (text.length < 6) {
                      return "password should be at least 6 char";
                    }
                    if (text != passwordController.text) {
                      return "password and re password not mat";
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      loc.haveaccount,
                      style: const TextStyle(
                        color: AppColors.blueColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                CustomButton(
                  text: loc.register,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Account created successfully"),
                            backgroundColor: Colors.green,
                          ),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeTap()),
                        );
                      } on FirebaseAuthException catch (e) {
                        String message;

                        switch (e.code) {
                          case 'weak-password':
                            message = 'Password is too weak';
                            break;
                          case 'email-already-in-use':
                            message = 'This email is already in use';
                            break;
                          case 'invalid-email':
                            message = 'Invalid email address';
                            break;
                          default:
                            message = e.message ?? 'Registration failed';
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
