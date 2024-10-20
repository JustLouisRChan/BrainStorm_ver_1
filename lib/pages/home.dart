import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Duration of the animation
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 3.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation and navigate after a delay
    Future.delayed(const Duration(seconds: 1), () {
      _controller.forward().then((_) {
        Navigator.of(context).pushReplacement(
          _createFadeRoute(),
        );
      });
    });
  }

  // Function to create a fade route for the next page
  Route _createFadeRoute() {
    return PageRouteBuilder(
      transitionDuration:
          const Duration(milliseconds: 1000), // Duration of the fade
      pageBuilder: (context, animation, secondaryAnimation) => SignUpPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget openingLogo = FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "BRAIN",
              style: TextStyle(
                color: Color(0xff2A1A8E),
                decoration: TextDecoration.none,
                fontSize: 32, // Adjust font size as needed
              ),
            ),
            Icon(
              Boxicons.bx_cloud_lightning,
              size: 140,
              color: const Color.fromRGBO(86, 63, 232, 1),
            ),
            const Text(
              "STORM",
              style: TextStyle(
                color: Color(0xff2A1A8E),
                decoration: TextDecoration.none,
                fontSize: 32, // Adjust font size as needed
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      body: Center(child: openingLogo),
    );
  }
}
