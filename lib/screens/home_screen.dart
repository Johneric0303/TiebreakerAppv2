import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../services/decision_service.dart';
import 'processing_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final decisionService = context.watch<DecisionService>();
    final isBusy = decisionService.isLoading;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Tiebreaker App V2')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF120A18),
              Color(0xFF2A1635),
              Color(0xFF47223B),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 30,
                right: -50,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Color(0x55F2C96B), Colors.transparent],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                left: -60,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Color(0x338A63FF), Colors.transparent],
                    ),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 560),
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [Color(0xCC352041), Color(0xAA22122D)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(color: const Color(0x33F2C96B)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x44000000),
                          blurRadius: 30,
                          offset: Offset(0, 18),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            color: const Color(0x1AF2C96B),
                            border: Border.all(color: const Color(0x33F2C96B)),
                          ),
                          child: const Text(
                            'AI Decision Assistant',
                            style: TextStyle(
                              color: Color(0xFFF2C96B),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Break ties with a sharper view.',
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 34,
                            height: 1.1,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Describe your decision and get a structured Pros & Cons list, a Comparison Table, and a SWOT Analysis in one pass.',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.7,
                            color: Color(0xFFD5C7E2),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0x14000000),
                            border: Border.all(color: const Color(0x228A63FF)),
                          ),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.auto_awesome_rounded,
                                color: Color(0xFFF2C96B),
                                size: 20,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Try being specific. Mention your budget, time limits, priorities, or the two options you are choosing between so the analysis comes back more useful.',
                                  style: TextStyle(
                                    height: 1.6,
                                    color: Color(0xFFD8CCE4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 26),
                        TextField(
                          controller: _controller,
                          maxLines: 4,
                          minLines: 3,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'What decision are you making?',
                            hintText:
                                'Example: Should I buy a gaming laptop or build a desktop PC for school and work?',
                            alignLabelWithHint: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFF2D27B),
                                      Color(0xFFE4B850),
                                    ],
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x33F2C96B),
                                      blurRadius: 20,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: isBusy
                                      ? null
                                      : () {
                                          if (_controller.text.isNotEmpty) {
                                            FocusScope.of(context).unfocus();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => ProcessingScreen(
                                                  decision:
                                                      _controller.text.trim(),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    disabledBackgroundColor: Colors.transparent,
                                    disabledForegroundColor:
                                        const Color(0xFF26142E),
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        isBusy
                                            ? 'Working on it...'
                                            : 'Help me Decide!',
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        isBusy
                                            ? Icons.hourglass_top_rounded
                                            : Icons.arrow_forward_rounded,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _MiniTag(label: 'Pros & Cons'),
                            _MiniTag(label: 'Comparison Table'),
                            _MiniTag(label: 'SWOT Analysis'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniTag extends StatelessWidget {
  final String label;

  const _MiniTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0x122CFFD9),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0x228A63FF)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFE7D9F4),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
