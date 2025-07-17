import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'create_account.dart';
import 'forgot_password.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  late AnimationController _topRowController;
  late AnimationController _bottomRowController;
  late Animation<Offset> _topRowAnimation;
  late Animation<Offset> _bottomRowAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers for slower, smoother movement
    _topRowController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );

    _bottomRowController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );

    // Create animations for seamless horizontal movement
    _topRowAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(-0.33, 0.0),
    ).animate(CurvedAnimation(
      parent: _topRowController,
      curve: Curves.linear,
    ));

    _bottomRowAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.33, 0.0),
    ).animate(CurvedAnimation(
      parent: _bottomRowController,
      curve: Curves.linear,
    ));

    // Start animations
    _topRowController.repeat();
    _bottomRowController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Animated Photo Carousel Section
            SizedBox(
              height: 350,
              child: Column(
                children: [
                  // Top row moving right
                  Expanded(
                    child: OverflowBox(
                      maxWidth: double.infinity,
                      child: SlideTransition(
                        position: _topRowAnimation,
                        child: Row(
                          children: [
                            // First complete cycle
                            _buildPhotoCard('assets/images/img1.png'),
                            _buildPhotoCard('assets/images/img2.png'),
                            _buildPhotoCard('assets/images/img3.png'),
                            _buildPhotoCard('assets/images/img4.png'),
                            // Second complete cycle
                            _buildPhotoCard('assets/images/img1.png'),
                            _buildPhotoCard('assets/images/img2.png'),
                            _buildPhotoCard('assets/images/img3.png'),
                            _buildPhotoCard('assets/images/img4.png'),
                            // Third complete cycle
                            _buildPhotoCard('assets/images/img1.png'),
                            _buildPhotoCard('assets/images/img2.png'),
                            _buildPhotoCard('assets/images/img3.png'),
                            _buildPhotoCard('assets/images/img4.png'),
                            // Fourth complete cycle (extra buffer for seamless loop)
                            _buildPhotoCard('assets/images/img1.png'),
                            _buildPhotoCard('assets/images/img2.png'),
                            _buildPhotoCard('assets/images/img3.png'),
                            _buildPhotoCard('assets/images/img4.png'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Bottom row moving left
                  Expanded(
                    child: OverflowBox(
                      maxWidth: double.infinity,
                      child: SlideTransition(
                        position: _bottomRowAnimation,
                        child: Row(
                          children: [
                            // First complete cycle
                            _buildPhotoCard('assets/images/img5.png'),
                            _buildPhotoCard('assets/images/img6.png'),
                            _buildPhotoCard('assets/images/img7.png'),
                            _buildPhotoCard('assets/images/img8.png'),
                            // Second complete cycle
                            _buildPhotoCard('assets/images/img5.png'),
                            _buildPhotoCard('assets/images/img6.png'),
                            _buildPhotoCard('assets/images/img7.png'),
                            _buildPhotoCard('assets/images/img8.png'),
                            // Third complete cycle
                            _buildPhotoCard('assets/images/img5.png'),
                            _buildPhotoCard('assets/images/img6.png'),
                            _buildPhotoCard('assets/images/img7.png'),
                            _buildPhotoCard('assets/images/img8.png'),
                            // Fourth complete cycle (extra buffer for seamless loop)
                            _buildPhotoCard('assets/images/img5.png'),
                            _buildPhotoCard('assets/images/img6.png'),
                            _buildPhotoCard('assets/images/img7.png'),
                            _buildPhotoCard('assets/images/img8.png'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Main Content
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Title Section
                  Text(
                    'Celebrate Every Moment\nWith Occasions',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C1810),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Turn moments into memories',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color(0xFF8B7355),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Email Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email Address',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF2C1810),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          hintStyle: GoogleFonts.poppins(
                            color: const Color(0xFFB8B8B8),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF8F8F8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Password Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF2C1810),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          hintStyle: GoogleFonts.poppins(
                            color: const Color(0xFFB8B8B8),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF8F8F8),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color(0xFFB8B8B8),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPassword(),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFD4AF37),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Sign In Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle sign in
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B4E3D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Divider
                  Row(
                    children: [
                      const Expanded(child: Divider(color: Color(0xFFE0E0E0))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'or continue with',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF8B7355),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider(color: Color(0xFFE0E0E0))),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Phone Number Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        // Handle phone number sign in
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE0E0E0)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Text(
                        'Phone Number',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF2C1810),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Register Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF8B7355),
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateAccount(),
                            ),
                          );
                        },
                        child: Text(
                          'Register',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF2C1810),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoCard(String imagePath) {
    return Container(
      width: 120,
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _topRowController.dispose();
    _bottomRowController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
