import 'package:f_medi_minders/landing_main_page.dart';
import 'package:f_medi_minders/resrt_password_screen.dart';
//import 'package:f_medi_minders/welcome_main_screen.dart';
//import 'package:f_medi_minders/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'services/auth_service.dart'; // ✅ import AuthService

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  bool _obsecure = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _authService = AuthService(); // ✅ create AuthService instance

  // ✅ Handle login check
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      // ✅ Check credentials from SharedPreferences
      bool success = await _authService.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Login Successful!')),
        );

        // ✅ Navigate ONLY if login is correct
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LandingMainPage()),
        );
      } else {
        // ❌ Show error if login fails
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Invalid email or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFFAF9),
      body: Stack(
        children: [
          // ✅ Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.white],
              ),
            ),
          ),

          Column(
            children: [
              const Spacer(),
              Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey, // ✅ Added Form for validation
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 60),
                        const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Center(
                          child: Text('Your journey is finally here'),
                        ),
                        const SizedBox(height: 30),

                        /// ✅ Email Field with Validation
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Username or Email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.endsWith('@gmail.com')) {
                              return 'Email must end with @gmail.com';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        /// ✅ Password Field
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obsecure,
                          decoration: InputDecoration(
                            labelText: 'Enter your password',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obsecure = !_obsecure;
                                });
                              },
                              icon: Icon(_obsecure ? Icons.visibility_off : Icons.visibility),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>ResetPasswordScreen()));
                            },
                            child: const Text('Forgot password?'),
                          ),
                        ),
                        const SizedBox(height: 16),

                        /// ✅ Login Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                          onPressed: _login, // ✅ Call login logic here
                          child: const Text("Login"),
                        ),

                        const SizedBox(height: 16),

                        /// ✅ Navigation to Signup
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const SignUpScreen()),
                              ),
                              child: const Text(
                                "Create one!",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
