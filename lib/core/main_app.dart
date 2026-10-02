import 'package:flutter/material.dart';
import 'package:via_cep/app/presenter/views/home_page/home_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
    
  }
}
