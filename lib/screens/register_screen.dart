
import 'package:flutter/material.dart';
import 'package:notes_app/auth_services.dart';
import 'package:notes_app/components/button.dart';
import 'package:notes_app/components/textfield.dart';

class Registerscreen extends StatefulWidget {
  final Function()? onTap;
  const Registerscreen({super.key, required this.onTap});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final authServices = AuthServices();
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserUp() async {
    final email = userController.text;
    final password = passwordController.text;

    try {
      await authServices.signUpWithEmailPassword(email, password);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //SizedBox(height: 30),

                //! Adding the logo
                Image.asset('assets/login.png', height: 250),
                //SizedBox(height:30),

                //!Welcome Message
                Text(
                  "Let's create an account! ",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 15),

                //! Username
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Align(
                    alignment: Alignment.centerLeft, // pushes text to the right
                    child: Text('Username', style: TextStyle(fontSize: 16)),
                  ),
                ),

                MyTextField(
                  controller: userController,
                  hintText: "Username",
                  obscureText: false,
                ),

                //! Password
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Password', style: TextStyle(fontSize: 16)),
                  ),
                ),

                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 10),
                //! Sign In Button
                MyButton(onTap: signUserUp, text: 'Sign Up'),
                SizedBox(height: 35),
                //!Not a member register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Color.fromARGB(255, 56, 120, 192),
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
      ),
    );
  }
}
