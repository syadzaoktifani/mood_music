import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // ROLE (Admin / User / Artis)
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // MUSIC ICON
              Icon(
                Icons.music_note,
                color: Colors.blue.shade600,
                size: 40,
              ),

              const SizedBox(height: 12),

              const Text(
                "Create an Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 30),

              // FULL NAME
              _buildInputField(
                label: "Full Name",
                hint: "Enter your full name",
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 15),

              // EMAIL
              _buildInputField(
                label: "Email",
                hint: "Enter your email",
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: 15),

              // ROLE DROPDOWN
              _buildRoleDropdown(),

              const SizedBox(height: 15),

              // PASSWORD
              _buildPasswordField(
                label: "Password",
                hint: "Enter your password",
                obscureText: _obscurePassword,
                onToggle: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),

              const SizedBox(height: 15),

              // CONFIRM PASSWORD
              _buildPasswordField(
                label: "Confirm Password",
                hint: "Confirm your password",
                obscureText: _obscureConfirmPassword,
                onToggle: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),

              const SizedBox(height: 25),

              // REGISTER BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedRole == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select a role first"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Registered as $selectedRole"),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.black54),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: Colors.blue.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------
  // Reusable Text Input
  // -------------------------
  Widget _buildInputField({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              prefixIcon: Icon(icon, color: Colors.blue.shade500),
            ),
          ),
        ),
      ],
    );
  }

  // -------------------------
  // Password Field
  // -------------------------
  Widget _buildPasswordField({
    required String label,
    required String hint,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              prefixIcon: Icon(Icons.lock_outline, color: Colors.blue.shade500),
              suffixIcon: IconButton(
                onPressed: onToggle,
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // -------------------------
  // Role Dropdown (Admin, User, Artis)
  // -------------------------
  Widget _buildRoleDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Role",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedRole,
              hint: const Text("Choose a role"),
              icon: const Icon(Icons.arrow_drop_down),
              items: const [
                DropdownMenuItem(value: "Admin", child: Text("Admin")),
                DropdownMenuItem(value: "User", child: Text("User")),
                DropdownMenuItem(value: "Artis", child: Text("Artis")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedRole = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
