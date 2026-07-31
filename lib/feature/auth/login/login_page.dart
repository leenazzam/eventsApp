import 'package:events/core/utils/app_colors.dart';
import 'package:events/core/widget/custom_button.dart';
import 'package:events/core/widget/custom_text_field.dart';
import 'package:events/feature/homePage/home_page.dart';
import 'package:events/feature/homePage/tabs/home_tap.dart';
import 'package:events/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  var emailController = TextEditingController(text: 'leen@gmail.com');
  var passwordController = TextEditingController(text: 'leen123');

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
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
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

                const SizedBox(height: 8),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      loc.forgetPassword,
                      style: const TextStyle(
                        color: AppColors.blueColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                CustomButton(
                  text: loc.login,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Login successfully"),
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
                          case 'invalid-credential':
                            message = 'Invalid email or password';
                            break;
                          case 'user-not-found':
                            message = 'No user found for this email';
                            break;
                          case 'wrong-password':
                            message = 'Wrong password';
                            break;
                          case 'invalid-email':
                            message = 'Invalid email address';
                            break;
                          case 'user-disabled':
                            message = 'This account has been disabled';
                            break;
                          default:
                            message = e.message ?? 'Login failed';
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Something went wrong'),
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
