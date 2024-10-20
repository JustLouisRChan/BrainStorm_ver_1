// lib/pages/wallet_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import '../material/botnav.dart';
import '../material/action_button.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve screen dimensions for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Container
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(238, 236, 246, 1),
            ),
            child: Column(
              children: <Widget>[
                // Main Card Container
                Container(
                  margin: EdgeInsets.only(
                    top: screenHeight * 0.08,
                    left: screenWidth * 0.04,
                    right: screenWidth * 0.04,
                  ),
                  width: double.infinity,
                  height: screenHeight * 0.8, // 80% of screen height
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.4),
                        offset: Offset(0, 0),
                        blurRadius: 4,
                      ),
                    ],
                    color: const Color.fromRGBO(245, 245, 245, 1),
                  ),
                  child: SingleChildScrollView(
                    // Prevent overflow on smaller screens
                    child: Column(
                      children: <Widget>[
                        // Header Row with Icon and Title
                        HeaderRow(),
                        SizedBox(height: screenHeight * 0.05),
                        // Centered Circle with Asset Information
                        AssetCircle(),
                        SizedBox(height: screenHeight * 0.05),
                        // Action Buttons
                        ActionButtons(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Positioned Bottom Navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNav(),
          ),
        ],
      ),
    );
  }
}

/// Header Row Widget containing an icon and the "My Wallet" title.
class HeaderRow extends StatelessWidget {
  const HeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve screen dimensions for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(
        top: screenHeight * 0.04,
        left: screenWidth * 0.08,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Boxicons.bxs_wallet,
            size: screenWidth * 0.06,
            color: Colors.black,
          ),
          SizedBox(width: screenWidth * 0.02),
          Text(
            'My Wallet',
            style: TextStyle(
              color: Colors.black,
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

/// AssetCircle Widget displaying total assets information.
class AssetCircle extends StatelessWidget {
  const AssetCircle({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve screen dimensions for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        width: screenWidth * 0.4,
        height: screenWidth * 0.4,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(169, 155, 255, 1),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Total Assets',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.03,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                '12,021',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Text(
                'ETH',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.65),
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ActionButtons Widget containing Buy Crypto, Sell Crypto, and Top Up buttons.
class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve screen dimensions for responsive design
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: <Widget>[
        // Buy Crypto Button
        ActionButton(
          label: 'Buy Crypto',
          onTap: () {
            // Navigate to Buy Crypto Page (to be implemented)
            // Navigator.push(context, MaterialPageRoute(builder: (context) => BuyCryptoPage()));
          },
          isPrimary: false,
        ),
        SizedBox(height: screenHeight * 0.02),
        // Sell Crypto Button
        ActionButton(
          label: 'Sell Crypto',
          onTap: () {
            // Navigate to Sell Crypto Page (to be implemented)
            // Navigator.push(context, MaterialPageRoute(builder: (context) => SellCryptoPage()));
          },
          isPrimary: false,
        ),
        SizedBox(height: screenHeight * 0.02),
        // Top Up Button
        ActionButton(
          label: 'Top Up',
          onTap: () {
            // Navigate to Top Up Page
            Navigator.pushNamed(context, '/transaction');
          },
          isPrimary: true,
        ),
      ],
    );
  }
}
