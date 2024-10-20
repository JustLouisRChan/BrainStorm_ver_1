// lib/pages/transaction_summary_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import '../material/action_button.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve screen dimensions for responsive design
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(238, 236, 246, 1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Boxicons.bx_arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Transaction Summary',
          style: TextStyle(
            color: Colors.black,
            fontSize: 19,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromRGBO(238, 236, 246, 1),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: screenHeight * 0.02),
              // Total Amount Container
              TotalAmountContainer(),
              const SizedBox(height: 20),
              // Transact From Section
              TransactFromSection(),
              const SizedBox(height: 20),
              // Top Up Button
              ActionButton(
                label: 'Transact',
                onTap: () {
                  // Implement Top Up functionality
                },
                isPrimary: true,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/// TotalAmountContainer Widget displaying transaction details.
class TotalAmountContainer extends StatelessWidget {
  const TotalAmountContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: const Color.fromRGBO(86, 63, 232, 1), width: 1),
        color: const Color.fromRGBO(236, 234, 245, 1),
      ),
      child: Column(
        children: <Widget>[
          const Text(
            'Total Amount',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const Text(
            ' 0.0001 ETH',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Transfer to : JustRice',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Name : FreedWasCooking',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Public ID : 0912334285',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// TransactFromSection Widget displaying the wallet used for transaction.
class TransactFromSection extends StatelessWidget {
  const TransactFromSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Section Title
        const Row(
          children: <Widget>[
            SizedBox(width: 15), // Add space from the left side
            Text(
              'Transact from',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            Spacer(),
          ],
        ),
        const SizedBox(height: 10),
        // Wallet Container
        Container(
          width: 310,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: const Color.fromRGBO(86, 63, 232, 1), width: 1),
            color: const Color.fromRGBO(236, 234, 245, 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Boxicons.bx_wallet,
                size: 40,
                color: Colors.black,
              ),
              const SizedBox(height: 10),
              const Text(
                'Metamask (****)',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
