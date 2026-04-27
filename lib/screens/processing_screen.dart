import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/decision_service.dart';
import 'results_screen.dart';

class ProcessingScreen extends StatefulWidget {
  final String decision;

  const ProcessingScreen({required this.decision, super.key});

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final ds = Provider.of<DecisionService>(context, listen: false);

      await ds.analyzeDecision(widget.decision);

      if (mounted && ds.errorMessage == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ResultsScreen()),
        );
      } else if (mounted && ds.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(ds.errorMessage!)),
        );
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Analyzing Decision')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF140B1B),
              Color(0xFF2A1635),
              Color(0xFF3B1D31),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(28),
            constraints: const BoxConstraints(maxWidth: 420),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                colors: [Color(0xCC34203D), Color(0xAA24152E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: const Color(0x33F2C96B)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x44000000),
                  blurRadius: 26,
                  offset: Offset(0, 16),
                ),
              ],
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 56,
                  height: 56,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation(Color(0xFFF2C96B)),
                  ),
                ),
                SizedBox(height: 22),
                Text(
                  'Reading your options...',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Gemini is building a cleaner Pros & Cons list, a Comparison Table, and a SWOT Analysis for your decision.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color(0xFFD6C8E2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
