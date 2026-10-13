import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'drugs_screen.dart';
import 'drug_details_screen.dart';
import 'pharmacy_screen.dart';
import 'profile_screen.dart';
import 'patient_screen.dart';

void main() {
  runApp(const DrugApp());
}

class DrugApp extends StatelessWidget {
  const DrugApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drug Information Management',
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/drugs': (context) => const DrugsScreen(),
        '/drug-details': (context) => const DrugDetailsScreen(),
        '/pharmacy': (context) => const PharmacyScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/patient': (context) => const PatientScreen(),
      },
    );
  }
}