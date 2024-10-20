import 'package:flutter/material.dart';
import '../pages/under_cons.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

// Pages
import '../pages/courses.dart';
import '../pages/feed.dart';
import '../pages/wallet.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBottomNavigation(MediaQuery.of(context).size.width, context);
  }

  Widget _buildBottomNavigation(double width, BuildContext context) {
    return Container(
      height: 50,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: _buildNavItem(context, Boxicons.bx_home, 'Home', FeedPage()),
          ),
          Expanded(
            child: _buildNavItem(
                context, Boxicons.bx_book, 'My Courses', CoursePage()),
          ),
          Expanded(
            child: _buildNavItem(
                context, Boxicons.bx_message, 'Inbox', UnderCons()),
          ),
          Expanded(
            child: _buildNavItem(
                context, Boxicons.bx_user, 'Profile', WalletPage()),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () {
        if (page is FeedPage) {
          // Pop to the root and push FeedPage again
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => page),
            (route) => false, // Remove all previous routes
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(icon, color: const Color.fromRGBO(86, 63, 232, 1)),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              color: Color.fromRGBO(86, 63, 232, 1),
              fontFamily: 'Inter',
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
