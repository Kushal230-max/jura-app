import 'package:flutter/material.dart';
import 'Login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreedToTerms = false;

  // Shared color palette (kept consistent with LoginPage)
  static const Color kBackground = Color(0xFFF9E1EC);
  static const Color kPrimary = Color(0xFFE6297A);
  static const Color kTextDark = Color(0xFF1A1A1A);

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                  icon: const Icon(Icons.arrow_back, color: kTextDark),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: kTextDark,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Sign up to get started',
                  style: TextStyle(fontSize: 15, color: kTextDark.withValues(alpha: 0.6)),
                ),
                const SizedBox(height: 28),

                // First / Last name row
                Row(
                  children: [
                    Expanded(
                      child: _buildFieldGroup(
                        label: 'First Name',
                        controller: _firstNameController,
                        hintText: 'Sita',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildFieldGroup(
                        label: 'Last Name',
                        controller: _lastNameController,
                        hintText: 'Sharma',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                _buildFieldGroup(
                  label: 'Email',
                  controller: _emailController,
                  hintText: 'abcd@gmail.com',
                ),
                const SizedBox(height: 18),

                _buildFieldGroup(
                  label: 'Password',
                  controller: _passwordController,
                  hintText: '',
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                const SizedBox(height: 18),

                _buildFieldGroup(
                  label: 'Confirm Password',
                  controller: _confirmPasswordController,
                  hintText: '',
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                ),
                const SizedBox(height: 16),

                // Terms checkbox
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _agreedToTerms,
                        activeColor: kPrimary,
                        onChanged: (value) {
                          setState(() => _agreedToTerms = value ?? false);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: kTextDark.withValues(alpha: 0.8), fontSize: 13, height: 1.4),
                          children: [
                            const TextSpan(text: 'I agree to the '),
                            TextSpan(
                              text: 'Terms & conditions',
                              style: const TextStyle(color: kPrimary, fontWeight: FontWeight.w600),
                              recognizer: null,
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: const TextStyle(color: kPrimary, fontWeight: FontWeight.w600),
                              recognizer: null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Sign Up button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      final fieldsFilled = _firstNameController.text.trim().isNotEmpty &&
                          _lastNameController.text.trim().isNotEmpty &&
                          _emailController.text.trim().isNotEmpty &&
                          _passwordController.text.trim().isNotEmpty &&
                          _confirmPasswordController.text.trim().isNotEmpty;

                      if (!fieldsFilled) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill in all fields')),
                        );
                        return;
                      }
                      if (_passwordController.text != _confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Passwords do not match')),
                        );
                        return;
                      }
                      if (!_agreedToTerms) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please agree to the Terms & Privacy Policy')),
                        );
                        return;
                      }
                      // Frontend-only flow: no backend yet, just send them to log in.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Account created — please log in')),
                      );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Footer
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: kTextDark.withValues(alpha: 0.8), fontSize: 14),
                      children: [
                        const TextSpan(text: 'Already have an account? '),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => const LoginPage()),
                              );
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: kPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldGroup({
    required String label,
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 13, color: kTextDark.withValues(alpha: 0.7))),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}