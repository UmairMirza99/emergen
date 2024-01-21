import 'package:emrergency/consts/AppColors.dart';
import 'package:flutter/cupertino.dart';

class Suivi1Screen extends StatefulWidget {
  const Suivi1Screen({super.key});

  @override
  State<Suivi1Screen> createState() => _Suivi1ScreenState();
}

class _Suivi1ScreenState extends State<Suivi1Screen> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Coming soon',style: TextStyle(color: AppColors.whiteColor),),);
  }
}
