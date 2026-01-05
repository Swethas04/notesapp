
import 'package:flutter/material.dart';
import 'package:notes_app/auth_services.dart';
import 'package:notes_app/components/button.dart';
import 'package:notes_app/components/textfield.dart';

class Loginscreen extends StatefulWidget {
  final Function()? onTap;
  const Loginscreen({super.key, required this.onTap});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final authServices = AuthServices();

  final userController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    final email = userController.text;
    final password = passwordController.text;

    try {
      await authServices.signInWithEmailPassword(email, password);
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
                  "Welcome back !!!! Great to see you again !",
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
                //!Forgot Password?
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //! Sign In Button
                MyButton(onTap: signUserIn, text: 'Sign In'),
                SizedBox(height: 35),
                //! Continue with Google
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Colors.grey.shade400,
                        ),
                      ),

                      Text(
                        'Or Continue with',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),

                      Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                //! google sign in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[100],
                      ),
                      child: Image.asset('assets/google.png', height: 50),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                //!Not a member register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
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
