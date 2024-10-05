import 'package:flutter/material.dart';
import 'package:objectcreator/objcreatorform.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Object Creator',
        debugShowCheckedModeBanner: false,
        home: ObjectCreatorForm());
  }
}


