import 'package:currency_converter/src/presentation/currency_exchange/currency_exchange.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashView();
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.6,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (context) => const CurrencyExchangePage(),
                  ),
                );
              },
              child: const Text(
                'Advanced Exchanger',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
      ),
    );
  }
}
