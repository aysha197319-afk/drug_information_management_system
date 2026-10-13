import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // READ: Default Registered Users List (Database / In-Memory Mock)
  List<Map<String, String>> registeredUsers = [
    {"email": "aysha@example.com", "password": "123"},
    {"email": "admin@medilink.com", "password": "admin"},
  ];

  // READ: Verification / Login Handle
  void _handleLogin() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("Please enter both email and password!", Colors.red);
      return;
    }

    bool userFound = registeredUsers.any(
          (user) => user["email"] == email && user["password"] == password,
    );

    if (userFound) {
      _showSnackBar("Login successful! Welcome to MediLink.", const Color(0xFF00796B));
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      _showSnackBar("Invalid email or password! Try Sign Up.", Colors.orange);
    }
  }

  // CREATE: Sign Up New Account
  void _showSignUpDialog() {
    TextEditingController newEmailCtrl = TextEditingController();
    TextEditingController newPassCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Create Account (Sign Up)", style: TextStyle(color: Color(0xFF004D40), fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newEmailCtrl,
                decoration: const InputDecoration(labelText: "Email address"),
              ),
              TextField(
                controller: newPassCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: "New Password"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
              onPressed: () {
                if (newEmailCtrl.text.isNotEmpty && newPassCtrl.text.isNotEmpty) {
                  setState(() {
                    registeredUsers.add({
                      "email": newEmailCtrl.text.trim(),
                      "password": newPassCtrl.text.trim(),
                    });
                  });
                  Navigator.pop(context);
                  _showSnackBar("Account created successfully! Now log in.", const Color(0xFF00796B));
                }
              },
              child: const Text("Register", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // UPDATE: Reset / Update Password
  void _showForgotPasswordDialog() {
    TextEditingController emailCtrl = TextEditingController();
    TextEditingController newPassCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Reset Password", style: TextStyle(color: Color(0xFF004D40), fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: "Your Email"),
              ),
              TextField(
                controller: newPassCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Enter New Password"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
              onPressed: () {
                int index = registeredUsers.indexWhere((u) => u["email"] == emailCtrl.text.trim());
                if (index != -1) {
                  setState(() {
                    registeredUsers[index]["password"] = newPassCtrl.text.trim();
                  });
                  Navigator.pop(context);
                  _showSnackBar("Password updated successfully!", const Color(0xFF00796B));
                } else {
                  _showSnackBar("Email not found in registered accounts!", Colors.red);
                }
              },
              child: const Text("Update Password", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), backgroundColor: color, duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.add_circle, color: Color(0xFF00796B)),
              ),
              const SizedBox(height: 32),
              const Text(
                "Welcome back",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
              ),
              const SizedBox(height: 8),
              const Text(
                "Log in to keep your medicines and everyday care organized.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 32),

              // Email Input
              const Text("Email", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                  hintText: "aysha@example.com",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                ),
              ),
              const SizedBox(height: 20),

              // Password Input
              const Text("Password", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  hintText: "Enter password (e.g. 123)",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                ),
              ),
              const SizedBox(height: 12),

              // Forgot Password Button (UPDATE)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _showForgotPasswordDialog,
                  child: const Text("Forgot password?", style: TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 24),

              // Log In Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00796B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _handleLogin,
                  child: const Text("Log in", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 24),

              // Sign Up Button (CREATE)
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("New to MediLink? ", style: TextStyle(color: Colors.grey)),
                    GestureDetector(
                      onTap: _showSignUpDialog,
                      child: const Text("Sign up", style: TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}