import 'package:flutter/material.dart';
import 'feed.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class UnderCons extends StatelessWidget {
  const UnderCons({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FeedPage()),
        );
      },
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Under",
              style: TextStyle(
                color: Color(0xff2A1A8E),
                decoration: TextDecoration.none,
              ),
            ),
            Icon(
              Boxicons.bx_cloud_rain,
              size: 140,
              color: const Color.fromRGBO(86, 63, 232, 1),
            ),
            const Text(
              "Construction",
              style: TextStyle(
                color: Color(0xff2A1A8E),
                decoration: TextDecoration.none,
              ),
            )
          ],
        ),
      ),
    );
  }
}
