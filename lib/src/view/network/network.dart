import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Connection Error",
          style: theme.textTheme.titleLarge!
              .copyWith(fontWeight: FontWeight.bold, letterSpacing: .6),
        ),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off_outlined,
              size: 90,
            ),
            const SizedBox(height: 20),
            Text(
              "No Internet Connectin",
              style: theme.textTheme.headlineMedium!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "Please check you internet connection for the app to work",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            )
          ],
        ),
      )),
    );
  }
}
