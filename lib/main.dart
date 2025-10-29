import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

// Main app with named routes.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Integrated NovaHealth App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/gender': (context) => GenderPage(),
        '/novahome': (context) => NovaHomePage(),
      },
    );
  }
}

//
// --------------------- LANDING PAGE ---------------------
// Home page with login and sign-up options.
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFC8B6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top status bar.
              Container(
                height: 50,
                color: Color(0xFF090909),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '9:41',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.battery_full, color: Colors.white),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Welcome to\nNovaHealth',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF25460E),
                  fontSize: 32,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  letterSpacing: 1.08,
                ),
              ),
              SizedBox(height: 40),
              // LOGIN button.
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Container(
                  width: 180,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Color(0xFF616F57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'LOGIN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFDFF7E1),
                      fontSize: 22,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.75,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // SIGNUP button.
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Container(
                  width: 180,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Color(0xFF616F57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'SIGNUP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFDFF7E1),
                      fontSize: 22,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.75,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

//
// --------------------- LOGIN PAGE ---------------------
// Uses an in-memory user database. On successful login, navigates directly to NovaHomePage.
final Map<String, String> _userDatabase = {
  // Default credentials for testing.
  'test@example.com': 'password123',
};

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();

  void _handleLogin() {
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text.trim();
    if (_userDatabase.containsKey(email) && _userDatabase[email] == pass) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Successful!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pushReplacement(_fadeRoute(NovaHomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter valid credentials'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFCDBD),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top status bar.
              Container(
                height: 50,
                color: Color(0xFF090909),
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // (Back arrow removed from here for consistency.)
                    SizedBox(width: 8),
                    Text(
                      '9:41',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.battery_full, color: Colors.white),
                  ],
                ),
              ),
              // Corrected back button (placed below the top bar).
              IconButton(
                alignment: Alignment.topLeft,
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(height: 30),
              Text(
                'Welcome to\nNovaHealth',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF25460E),
                  fontSize: 28,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.08,
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Email Address',
                style: TextStyle(
                  color: Color(0xFF616F57),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: 50,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.30, color: Color(0xFF616F57)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Color(0xFF616F57),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Password',
                style: TextStyle(
                  color: Color(0xFF616F57),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: 50,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.30, color: Color(0xFF616F57)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _passCtrl,
                  obscureText: true,
                  style: TextStyle(
                    color: Color(0xFF616F57),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Forgot Password pressed')),
                    );
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFF25460E),
                      fontSize: 11.33,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: GestureDetector(
                  onTap: _handleLogin,
                  child: Container(
                    width: 160,
                    height: 50,
                    decoration: ShapeDecoration(
                      color: Color(0xFF616F57),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'LOGIN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFDFF7E1),
                        fontSize: 22,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.75,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

//
// --------------------- SIGNUP PAGE ---------------------
// After sign up, navigates to GenderPage.
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => _SignupPageState();
}
class _SignupPageState extends State<SignupPage> {
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _birthCtrl = TextEditingController();

  void _handleSignup() {
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text.trim();
    final confirm = _confirmCtrl.text.trim();

    if (email.isEmpty || pass.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Fields cannot be empty'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (pass != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    // Save credentials.
    _userDatabase[email] = pass;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sign Up Successful!'),
        backgroundColor: Colors.green,
      ),
    );
    // Navigate to GenderPage after sign up.
    Navigator.of(context).pushReplacement(_fadeRoute(GenderPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFCDBD),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top status bar.
              Container(
                height: 50,
                color: Color(0xFF090909),
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 8),
                    Text(
                      '9:41',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.battery_full, color: Colors.white),
                  ],
                ),
              ),
              // Corrected back button.
              IconButton(
                alignment: Alignment.topLeft,
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(height: 30),
              Text(
                'Get Started by Signing up!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF616F57),
                  fontSize: 32,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Sign Up for Free',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFDFF7E1),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Your Username',
                style: TextStyle(
                  color: Color(0xFF616F57),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF616F57), width: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _usernameCtrl,
                  style: TextStyle(
                    color: Color(0xFF616F57),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Email Address',
                style: TextStyle(
                  color: Color(0xFF616F57),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF616F57), width: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Color(0xFF616F57),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Create Password',
                style: TextStyle(
                  color: Color(0xFF616F57),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF616F57), width: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _passCtrl,
                  obscureText: true,
                  style: TextStyle(
                    color: Color(0xFF616F57),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Confirm Password',
                style: TextStyle(
                  color: Color(0xFF616F57),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF616F57), width: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _confirmCtrl,
                  obscureText: true,
                  style: TextStyle(
                    color: Color(0xFF616F57),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Date of Birth (DD/MM/YYYY)',
                style: TextStyle(
                  color: Color(0xFF616F57),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF616F57), width: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _birthCtrl,
                  style: TextStyle(
                    color: Color(0xFF616F57),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '',
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: GestureDetector(
                  onTap: _handleSignup,
                  child: Container(
                    width: 120,
                    height: 50,
                    decoration: ShapeDecoration(
                      color: Color(0xFF616F57),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'NEXT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFDFF7E1),
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.60,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

//
// --------------------- GENDER PAGE ---------------------
// After sign up, the user selects a gender then navigates to NovaHomePage.
class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  _GenderPageState createState() => _GenderPageState();
}
class _GenderPageState extends State<GenderPage> {
  String? _selectedGender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFC8B6),
      body: SafeArea(
        child: Column(
          children: [
            // Top status bar.
            Container(
              height: 50,
              color: Color(0xFF090909),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '9:41',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.battery_full, color: Colors.white),
                ],
              ),
            ),
            // No extra back button here as GenderPage is reached via sign up.
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      // Optional back button if needed.
                      IconButton(
                        alignment: Alignment.topLeft,
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(height: 40),
                      Text(
                        'Enter details.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF25470E),
                          fontSize: 32,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          letterSpacing: 1.08,
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        'Gender',
                        style: TextStyle(
                          color: Color(0xFF616F57),
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 0.30, color: Color(0xFF616F57)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: _selectedGender,
                          items: ['Male', 'Female', 'Other', 'Prefer not to say']
                              .map((gender) => DropdownMenuItem<String>(
                                    value: gender,
                                    child: Text(gender),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Choose a gender',
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              color: Color(0xFFFFC8B6),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    if (_selectedGender != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Gender selected: $_selectedGender')),
                      );
                      Navigator.of(context).pushReplacement(_fadeRoute(NovaHomePage()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select a gender')),
                      );
                    }
                  },
                  child: Container(
                    width: 130,
                    height: 50,
                    decoration: ShapeDecoration(
                      color: Color(0xFF616F57),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Next',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFDFF7E1),
                        fontSize: 19,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.75,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// --------------------- NOVA HOME PAGE ---------------------
// Main app page (after login or gender selection) with bottom navigation
// for Profile, Language, and Input pages.
class NovaHomePage extends StatefulWidget {
  const NovaHomePage({super.key});

  @override
  _NovaHomePageState createState() => _NovaHomePageState();
}
class _NovaHomePageState extends State<NovaHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    ProfilePage(),
    LanguagePage(),
    InputPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NovaHealth App'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'Language',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.input),
            label: 'Input',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

//
// --------------------- PROFILE PAGE ---------------------
// Adapted from the Profile snippet.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFDFF7E1),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xe26e9552),
              ),
              child: Center(
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  width: 408,
                  height: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0x66cce1be),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  right: 8,
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Riya Vetnekar",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            "rvetnekar@gmail.com",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            "Current Stats: ******",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  _buildTextContainer("Meal Timer"),
                  _buildTextContainer("Stay Mindful"),
                  _buildTextContainer("Your Workout"),
                  _buildTextContainer("Your Diet"),
                  _buildTextContainer("Habit Tracker"),
                  _buildTextContainer("Period Tracker"),
                  _buildTextContainer("Stress Help"),
                  _buildTextContainer("Hydration"),
                ],
              ),
            ),
            SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  width: 400,
                  height: 74,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xffc7e3b4),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      "SOS",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTextContainer(String text) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xe26e9552),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

//
// --------------------- LANGUAGE PAGE ---------------------
// Adapted from the Language snippet.
class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFF7E1),
      body: LanguageSelection(),
    );
  }
}

class LanguageSelection extends StatelessWidget {
  const LanguageSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Language Support",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF26470E),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Select Your Language",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF26470E),
            ),
          ),
          SizedBox(height: 20),
          SectionTitle(title: "Popular Languages"),
          LanguageOption(name: "English (US)"),
          LanguageOption(name: "English (UK)"),
          SizedBox(height: 20),
          SectionTitle(title: "Other Languages"),
          LanguageOption(name: "Mandarin"),
          LanguageOption(name: "Spanish"),
          LanguageOption(name: "Arabic"),
          LanguageOption(name: "Hindi"),
          LanguageOption(name: "French"),
          LanguageOption(name: "Russian"),
          LanguageOption(name: "Vietnamese"),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF26470E),
        ),
      ),
    );
  }
}

class LanguageOption extends StatelessWidget {
  final String name;
  const LanguageOption({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF26470E),
            ),
          ),
          Icon(
            Icons.radio_button_unchecked,
            size: 24,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

//
// --------------------- INPUT PAGE ---------------------
// Updated InputPage as per INPUT.pdf with proper margins, alignment, and a dropdown.
class InputPage extends StatelessWidget {
  const InputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF25460E),
        title: Text('NovaHealth App'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 440,
          height: 956,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFFDFF7E1)),
          child: Stack(
            children: [
              // Background decorative elements.
              Positioned(
                left: 0,
                top: -6,
                child: Container(
                  width: 440,
                  height: 956,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Color(0x19FFCDBD)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 108,
                        height: 99,
                        decoration: ShapeDecoration(
                          color: Color(0x0702264A),
                          shape: OvalBorder(),
                        ),
                      ),
                      Transform(
                        transform: Matrix4.identity()..rotateZ(-0.40),
                        child: Container(
                          width: 136,
                          height: 125,
                          decoration: ShapeDecoration(
                            color: Color(0x0825460E),
                            shape: StarShape(
                              points: 5,
                              innerRadiusRatio: 0.38,
                              pointRounding: 7,
                              valleyRounding: 0,
                              rotation: 0,
                              squash: 0,
                            ),
                          ),
                        ),
                      ),
                      Transform(
                        transform: Matrix4.identity()..rotateZ(-0.63),
                        child: Container(
                          width: 136,
                          height: 125,
                          decoration: ShapeDecoration(
                            color: Color(0x0825460E),
                            shape: StarShape(
                              points: 5,
                              innerRadiusRatio: 0.38,
                              pointRounding: 7,
                              valleyRounding: 0,
                              rotation: 0,
                              squash: 0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 152,
                        height: 141,
                        decoration: ShapeDecoration(
                          color: Color(0x0702264A),
                          shape: OvalBorder(),
                        ),
                      ),
                      // Additional decorative elements can be added here.
                    ],
                  ),
                ),
              ),
              // Header text and dropdown.
              Positioned(
                left: 82,
                top: 223,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today’s input',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF616F57),
                        fontSize: 25,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF616F57), width: 0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          items: <String>[
                            'WORKOUT',
                            'HYDRATION',
                            'FOOD',
                            'SYMPTOMS',
                            'PERIOD TRACKER'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: Color(0xFF616F57),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (_) {},
                          hint: Text(
                            'Select an option',
                            style: TextStyle(
                              color: Color(0xFF616F57),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Additional positioned widgets can be added as needed.
            ],
          ),
        ),
      ),
    );
  }
}

// Custom StarShape used in the InputPage.
class StarShape extends ShapeBorder {
  final int points;
  final double innerRadiusRatio;
  final double pointRounding;
  final double valleyRounding;
  final double rotation;
  final double squash;

  const StarShape({
    this.points = 5,
    this.innerRadiusRatio = 0.5,
    this.pointRounding = 0,
    this.valleyRounding = 0,
    this.rotation = 0,
    this.squash = 0,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(10.0);
  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    final width = rect.width;
    final centerX = rect.center.dx;
    final centerY = rect.center.dy;
    final outerRadius = width / 2;
    final innerRadius = outerRadius * innerRadiusRatio;
    final angle = (2 * math.pi) / points;
    for (int i = 0; i < points; i++) {
      final x1 = centerX + outerRadius * math.cos(rotation + angle * i);
      final y1 = centerY + outerRadius * math.sin(rotation + angle * i);
      final x2 = centerX + innerRadius * math.cos(rotation + angle * i + angle / 2);
      final y2 = centerY + innerRadius * math.sin(rotation + angle * i + angle / 2);
      if (i == 0) {
        path.moveTo(x1, y1);
      } else {
        path.lineTo(x1, y1);
      }
      path.lineTo(x2, y2);
    }
    path.close();
    return path;
  }
  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}
  @override
  ShapeBorder scale(double t) {
    return StarShape(
      points: points,
      innerRadiusRatio: innerRadiusRatio,
      pointRounding: pointRounding,
      valleyRounding: valleyRounding,
      rotation: rotation,
      squash: squash,
    );
  }
}

// Helper for fade transition.
Route _fadeRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
