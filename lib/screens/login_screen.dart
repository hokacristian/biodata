import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _login() {
    if (_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
        msg: "Login berhasil! Selamat datang 👋",
        backgroundColor: const Color(0xFF2E7D32),
        textColor: Colors.white,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1E3A5F), Color(0xFF2D5478)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_pin, size: size.width * 0.25, color: Colors.white),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: size.width * 0.07,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    'Sign in to continue',
                    style: TextStyle(fontSize: size.width * 0.04, color: Colors.white70),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Container(
                    padding: EdgeInsets.all(size.width * 0.06),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF1E3A5F)),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xFF1E3A5F), width: 2),
                              ),
                            ),
                            validator: (v) => v!.isEmpty ? 'Email required' : null,
                          ),
                          SizedBox(height: size.height * 0.02),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF1E3A5F)),
                              suffixIcon: IconButton(
                                icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF1E3A5F)),
                                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xFF1E3A5F), width: 2),
                              ),
                            ),
                            validator: (v) => v!.isEmpty ? 'Password required' : null,
                          ),
                          SizedBox(height: size.height * 0.03),
                          SizedBox(
                            width: double.infinity,
                            height: size.height * 0.06,
                            child: ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E3A5F),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: Text('LOGIN', style: TextStyle(fontSize: size.width * 0.04, color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ", style: TextStyle(color: Colors.white70, fontSize: size.width * 0.035)),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                        child: Text('Register', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: size.width * 0.035)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
