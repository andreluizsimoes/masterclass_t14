import 'package:componentes_flutter/app/core/widgets/rules.dart';
import 'package:componentes_flutter/app/core/widgets/tinder_button.dart';
import 'package:componentes_flutter/app/core/widgets/tinder_logo.dart';
import 'package:componentes_flutter/app/core/widgets/tinder_logo.dart';
import 'package:flutter/material.dart';

class TinderPage extends StatefulWidget {
  const TinderPage({super.key});

  @override
  State<TinderPage> createState() => _TinderPageState();
}

class _TinderPageState extends State<TinderPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE95270),
              Color(0xFFEB6766),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.3,
              ),
              // Image.asset('assets/images/tinder_logo.png',
              //     width: isPortrait ? screenWidth * 0.7 : screenWidth * 0.3),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TinderLogo(
                    size: 50,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'tinder',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nunito',
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              const Rules(),
              SizedBox(
                height: isPortrait ? 20 : 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    TinderButton(
                      icon: 'assets/images/apple_icon.png',
                      text: 'sign in with apple',
                      onTap: () {
                        Navigator.of(context).pushNamed('/');
                      },
                    ),
                    const SizedBox(height: 10),
                    TinderButton(
                      icon: 'assets/images/facebook.png',
                      text: 'sign in with facebook',
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    TinderButton(
                      icon: 'assets/images/sms.png',
                      text: 'sign in with phone number',
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Trouble Signing In?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
