// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'transaction.dart';
import '../material/botnav.dart'; // Ensure this file exists and is correct

class ViewProfPage extends StatefulWidget {
  const ViewProfPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<ViewProfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Username'),
            backgroundColor: const Color.fromRGBO(86, 63, 232, 1)),
        body: const ProfilePage(),
        bottomNavigationBar: BottomNav());
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Color untouched = const Color.fromRGBO(86, 63, 232, 1);
  Color _appliedColor = const Color.fromRGBO(86, 63, 232, 1);
  Color _mathColor = const Color.fromRGBO(86, 63, 232, 1);
  final Color _premiumColor = const Color.fromARGB(255, 201, 196, 232);
  final bool _isPremiumButtonLocked = true;

  void _changeColor(String button) {
    setState(() {
      if (button == 'Applied') {
        _appliedColor = const Color(0xFFA99BFF);
        _mathColor = untouched;
      } else if (button == 'Math') {
        _appliedColor = untouched;
        _mathColor = const Color(0xFFA99BFF);
      }
    });
  }

  void _showPremiumPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Premium Membership"),
          content: const Text("You are not a premium member."),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransactionPage()),
                );
              },
              child: const Text("Get Premium"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: const Color(0xFFEEECF6),
        child: Column(
          children: [
            const ProfileHeader(),
            ProfileContent(
              appliedColor: _appliedColor,
              mathColor: _mathColor,
              premiumColor: _premiumColor,
              isPremiumButtonLocked: _isPremiumButtonLocked,
              onButtonPressed: _changeColor,
              onPremiumPressed: _showPremiumPopup,
            ),
          ],
        ),
      ),
    );
  }
}

//PAGES
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 4,
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: ProfileInfo(),
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  final Color appliedColor;
  final Color mathColor;
  final Color premiumColor;
  final bool isPremiumButtonLocked;
  final Function(String) onButtonPressed;
  final VoidCallback onPremiumPressed;

  const ProfileContent({
    required this.appliedColor,
    required this.mathColor,
    required this.premiumColor,
    required this.isPremiumButtonLocked,
    required this.onButtonPressed,
    required this.onPremiumPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionButton('Applied', appliedColor, onButtonPressed),
            const SizedBox(width: 16),
            _buildActionButton('Math', mathColor, onButtonPressed),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: isPremiumButtonLocked ? onPremiumPressed : null,
                style: ElevatedButton.styleFrom(backgroundColor: premiumColor),
                child: const Text('Premium'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildActionButton(
      String label, Color color, Function(String) onPressed) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => onPressed(label),
        style: ElevatedButton.styleFrom(backgroundColor: color),
        child: Text(label),
      ),
    );
  }
}

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  int friendsCount = 0;
  bool isFriend = false;

  void addFriend() {
    setState(() {
      friendsCount++;
      isFriend = true;
    });
  }

  void unfriend() {
    setState(() {
      if (friendsCount > 0) {
        friendsCount--;
        isFriend = false;
      }
    });
  }

  void sendMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Message functionality not implemented yet.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Name PlaceHolder',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const CircleAvatar(
          radius: 31.5,
          backgroundColor: Color(0xFFA99BFF),
          child: Center(
            child: Text(
              '@',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          '@Name PlaceHolder',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            Text(
              'Friends: $friendsCount',
              style: const TextStyle(
                color: Color(0xFF333333),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isFriend
                        ? const Color(0xFFA99BFF)
                        : const Color.fromRGBO(86, 63, 232, 1),
                  ),
                  onPressed: isFriend ? unfriend : addFriend,
                  child: Text(isFriend ? 'Unfriend' : 'Add Friend'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(86, 63, 232, 1),
                  ),
                  onPressed: sendMessage,
                  child: const Text('Message'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class ViewProf extends StatelessWidget {
  const ViewProf({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: const Color(0xFF270FBF),
      ),
      body: const ProfileInfo(),
      bottomNavigationBar: BottomNav(),
    );
  }
}
