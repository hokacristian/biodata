import 'package:flutter/material.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  void _register() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
            colors: [Color(0xFF764ba2), Color(0xFF667eea)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_add, size: size.width * 0.2, color: Colors.white),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'Create Account',
                    style: TextStyle(fontSize: size.width * 0.07, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text('Register to get started', style: TextStyle(fontSize: size.width * 0.04, color: Colors.white70)),
                  SizedBox(height: size.height * 0.04),
                  Container(
                    padding: EdgeInsets.all(size.width * 0.06),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              prefixIcon: const Icon(Icons.person_outline),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            validator: (v) => v!.isEmpty ? 'Name required' : null,
                          ),
                          SizedBox(height: size.height * 0.02),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.email_outlined),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            validator: (v) => v!.isEmpty ? 'Email required' : null,
                          ),
                          SizedBox(height: size.height * 0.02),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            validator: (v) => v!.length < 6 ? 'Min 6 characters' : null,
                          ),
                          SizedBox(height: size.height * 0.02),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: _obscureConfirm,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility),
                                onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            validator: (v) => v != _passwordController.text ? 'Password not match' : null,
                          ),
                          SizedBox(height: size.height * 0.03),
                          SizedBox(
                            width: double.infinity,
                            height: size.height * 0.06,
                            child: ElevatedButton(
                              onPressed: _register,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF764ba2),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: Text('REGISTER', style: TextStyle(fontSize: size.width * 0.04, color: Colors.white)),
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
                      Text('Already have an account? ', style: TextStyle(color: Colors.white70, fontSize: size.width * 0.035)),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text('Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: size.width * 0.035)),
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
