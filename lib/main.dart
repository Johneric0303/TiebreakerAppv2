import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tiebreaker_app/screens/home_screen.dart';
import 'services/decision_service.dart';

void main() => runApp(const TiebreakerApp());

class TiebreakerApp extends StatelessWidget {
  const TiebreakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DecisionService()),
      ],
      child: MaterialApp(
        title: 'Tiebreaker App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFF1D1024),
          textTheme: GoogleFonts.manropeTextTheme().apply(
            bodyColor: const Color(0xFFEDE3F5),
            displayColor: Colors.white,
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF7B4DFF),
            brightness: Brightness.dark,
          ).copyWith(
            primary: const Color(0xFF8A63FF),
            secondary: const Color(0xFFF2C96B),
            surface: const Color(0xFF2A1635),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.white,
            centerTitle: true,
          ),
          tabBarTheme: TabBarThemeData(
            labelStyle: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
            unselectedLabelStyle: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0x1AF2C96B),
            hintStyle: const TextStyle(color: Color(0xFFC7B6D9)),
            labelStyle: const TextStyle(color: Color(0xFFE7D9F4)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Color(0x33F2C96B)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Color(0x33F2C96B)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Color(0xFFF2C96B), width: 1.4),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFF26142E),
              backgroundColor: const Color(0xFFF2C96B),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              textStyle: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: const Color(0xFF372042),
            contentTextStyle: const TextStyle(color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
