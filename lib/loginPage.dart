// ignore_for_file: file_names

import 'package:campus_mates/authentication.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatelessWidget {
  final AuthService _authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Scaffold(
      body: Row(
        children: [

          // 🔵 LEFT LOGIN PANEL
          Container(
            width: isMobile ? width : width * 0.4,
            padding: const EdgeInsets.all(32),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F2027), Color(0xFF203A43)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // LOGO
                Container(
                  
                ),

                const SizedBox(height: 40),

                // EMAIL
                _inputField(
                  controller: emailController,
                  hint: "Email",
                  icon: Icons.person,
                ),

                const SizedBox(height: 20),

                // PASSWORD
                _inputField(
                  controller: passwordController,
                  hint: "Password",
                  icon: Icons.lock,
                  obscure: true,
                ),

                const SizedBox(height: 30),

                // LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final user = await _authService.login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );

                      if (user != null) {
                        // Do nothing
                        // AuthWrapper will auto redirect
                      }
                    },
                    child: const Text("Login"),
                  ),

                ),

                const SizedBox(height: 15),

                // SIGNUP BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final user = await _authService.signup(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );

                      if (user != null) {
                        // AuthWrapper auto redirects
                      }
                    },
                    child: const Text("Signup"),
                  ),

                ),

                const SizedBox(height: 20),

                Center(
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),

          // 🖼 RIGHT IMAGE PANEL (Hidden on Mobile)
          if (!isMobile)
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/campus.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(40),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "Connect. Collaborate. Thrive.",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "A private campus network to grow together.",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // 🔹 REUSABLE INPUT FIELD
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white60),
        prefixIcon: Icon(icon, color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
