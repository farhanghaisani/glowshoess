import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glowshoess.id/core.dart';
import 'package:glowshoess.id/module/login_page/controller/login_page_controller.dart';
import 'package:get/get.dart' as getX;

class LoginPageView extends StatelessWidget {
  final LoginController controller = getX.Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          _buildBackground(),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(),
                  const SizedBox(height: 30),

                  _buildTextField(
                    hintText: 'Username or Email',
                    iconPath: 'asset/user.png',
                    onChanged: controller.setEmail,
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                    hintText: 'Password',
                    iconPath: 'asset/lock1.png',
                    obscureText: true,
                    onChanged: controller.setPassword,
                  ),
                  const SizedBox(height: 16),

                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.black45),
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Text(
                    '- OR Continue with -',
                    style: TextStyle(color: Colors.black45),
                  ),
                  const SizedBox(height: 16),

                  _buildSocialRow(),
                  const SizedBox(height: 32),

                  _buildLoginButton(context),
                  const SizedBox(height: 16),

                  TextButton(
                    onPressed: () {
                      getX.Get.toNamed('/signup');
                    },
                    child: const Text('Don’t have an account? Sign up here'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // LOGO
  Widget _buildLogo() {
    return Container(
      width: 300,
      height: 300,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('asset/glowshoess.id.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  // TEXT FIELD
  Widget _buildTextField({
    required String hintText,
    required String iconPath,
    required ValueChanged<String> onChanged,
    bool obscureText = false,
  }) {
    return TextField(
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black54),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            iconPath,
            width: 24,
            height: 24,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }

  // SOCIAL LOGINS
  Widget _buildSocialRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          assetPath: 'asset/Google.png',
          onTap: () => print("Login with Google"),
        ),
        const SizedBox(width: 20),
        _buildSocialButton(
          assetPath: 'asset/Facebook.png',
          onTap: () => print("Login with Facebook"),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String assetPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(assetPath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // LOGIN BUTTON
  Widget _buildLoginButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        User? user = await controller.loginWithEmailPassword();

        if (user != null) {
          getX.Get.offAll(() => HomePageView());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successful!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login failed!')),
          );
        }
      },
      child: Container(
        width: 350,
        height: 50,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 5, color: Color(0xFFBEF2EE)),
            borderRadius: BorderRadius.circular(30),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x7F000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Sora',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // BACKGROUND DECORATION
  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(234, 251, 249, 1),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -9,
            left: -78,
            child: _circle(300, 300, const Color(0xFF29D6C8)),
          ),
          Positioned(
            top: 34,
            left: -41,
            child: _borderCircle(140, 140, const Color(0xFF7EE6DE)),
          ),
          Positioned(
            top: 216,
            left: 67,
            child: _circle(432, 432, const Color(0xFF29D6C8)),
          ),
          Positioned(
            top: 291,
            left: 283,
            child: _borderCircle(150, 150, const Color(0xFFA9EEE9)),
          ),
          Positioned(
            top: 561,
            left: -97,
            child: _circle(300, 300, const Color(0xFF29D6C8)),
          ),
          Positioned(
            top: 503,
            left: -8,
            child: _borderCircle(230, 228, const Color(0xFF7EE6DE)),
          ),
        ],
      ),
    );
  }

  Widget _circle(double w, double h, Color color) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  Widget _borderCircle(double w, double h, Color color) {
    return Container(
      width: w,
      height: h,
      decoration: ShapeDecoration(
        shape: OvalBorder(
          side: BorderSide(
            width: 5,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: color,
          ),
        ),
      ),
    );
  }
}
