import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  bool _obsecure = true;
  bool _obsecureConfirm = true;
  bool _termsAccepted = false;

  final _authService = AuthService();  
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String _passwordStrength = "";

  // Password validation regex
  final String passwordPattern = r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$';

  // ✅ Function to check password strength
  void _checkPasswordStrength(String password) {
    setState(() {
      if (password.isEmpty) {
        _passwordStrength = "";
      } else if (password.length < 6) {
        _passwordStrength = "Weak";
      } else if (password.length >= 6 &&
          RegExp(r'^(?=.*[A-Z])(?=.*\d).{6,}$').hasMatch(password) &&
          !RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$').hasMatch(password)) {
        _passwordStrength = "Medium";
      } else if (RegExp(passwordPattern).hasMatch(password)) {
        _passwordStrength = "Strong";
      } else {
        _passwordStrength = "Weak";
      }
    });
  }

  // ✅ Choose color for strength text
  Color _getStrengthColor() {
    switch (_passwordStrength) {
      case "Weak":
        return Colors.red;
      case "Medium":
        return Colors.orange;
      case "Strong":
        return Colors.green;
      default:
        return Colors.transparent;
    }
  }

  // ✅ Function to handle signup
  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      if (!_termsAccepted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must accept Terms & Conditions')),
        );
        return;
      }

      // ✅ Save credentials using AuthService
      await _authService.register(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign Up Successful!')),
      );

      // ✅ Navigate to Login screen after signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ✅ Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.blue],
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
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 60),
                        const Text(
                          'Create Your Account',
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text('Create your account to start your journey'),
                        const SizedBox(height: 30),

                        /// ✅ Full Name
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        /// ✅ Email Field
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
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
                          obscuringCharacter: '*',
                          onChanged: _checkPasswordStrength, // ✅ Check strength while typing
                          decoration: InputDecoration(
                            labelText: 'Password',
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
                              return 'Please enter a password';
                            }
                            if (!RegExp(passwordPattern).hasMatch(value)) {
                              return 'Password must be 8+ chars, include 1 uppercase, 1 digit & 1 special char';
                            }
                            return null;
                          },
                        ),

                        /// ✅ Password Strength Indicator
                        if (_passwordStrength.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Password Strength: $_passwordStrength",
                              style: TextStyle(
                                color: _getStrengthColor(),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        const SizedBox(height: 16),

                        /// ✅ Confirm Password
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obsecureConfirm,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                            labelText: 'Re-enter Password',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obsecureConfirm = !_obsecureConfirm;
                                });
                              },
                              icon: Icon(_obsecureConfirm ? Icons.visibility_off : Icons.visibility),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        /// ✅ Terms & Conditions
                        Row(
                          children: [
                            Checkbox(
                              value: _termsAccepted,
                              onChanged: (value) {
                                setState(() {
                                  _termsAccepted = value ?? false;
                                });
                              },
                            ),
                            const Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text: 'I agree to the ',
                                  children: [
                                    TextSpan(
                                      text: 'Terms & Conditions',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    TextSpan(text: ' and '),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        /// ✅ Sign Up Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          onPressed: _signUp, // ✅ calls the signup function
                          child: const Text("Sign Up"),
                        ),
                        const SizedBox(height: 16),

                        /// ✅ Navigate to Login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account? "),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const LoginScreen()),
                              ),
                              child: const Text(
                                "Sign in",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
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
