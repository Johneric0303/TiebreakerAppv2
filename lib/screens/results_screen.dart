import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/decision_service.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result =
        Provider.of<DecisionService>(context, listen: false).currentResult;

    if (result == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Analysis Results')),
        body: const Center(
          child: Text('No result available yet. Please try again.'),
        ),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Decision Analysis',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: const Color(0xFFF2C96B),
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: const Color(0xFFC8B8D5),
            tabs: const [
              Tab(text: 'Pros/Cons'),
              Tab(text: 'Comparison Table'),
              Tab(text: 'SWOT Analysis'),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF140B1B),
                Color(0xFF26142F),
                Color(0xFF3A1C31),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: const LinearGradient(
                      colors: [Color(0x703B2044), Color(0x55331B2D)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(color: const Color(0x33F2C96B)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Decision Prompt',
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 1.6,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFF2C96B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        result.decision,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 28,
                          height: 1.15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Read through each lens below to compare tradeoffs, spot risks, and get a more balanced view before choosing.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.7,
                          color: Color(0xFFD3C6E0),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _AnalysisPane(markdown: result.prosAndCons),
                      _AnalysisPane(markdown: result.comparisonTable),
                      _AnalysisPane(markdown: result.swotAnalysis),
                    ],
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

class _AnalysisPane extends StatelessWidget {
  final String markdown;

  const _AnalysisPane({required this.markdown});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xCC32203D), Color(0xAA22132A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0x33F2C96B)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 22,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Color(0x22F2C96B), Colors.transparent],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 52,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF2C96B), Color(0xFF8A63FF)],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  MarkdownBody(
                    data: markdown,
                    selectable: true,
                    styleSheet: MarkdownStyleSheet(
                      p: GoogleFonts.manrope(
                        color: const Color(0xFFE8DEF0),
                        fontSize: 15.5,
                        height: 1.85,
                        letterSpacing: 0.1,
                      ),
                      h3: GoogleFonts.cormorantGaramond(
                        color: const Color(0xFFF2C96B),
                        fontSize: 30,
                        height: 1.1,
                        fontWeight: FontWeight.w700,
                      ),
                      h4: GoogleFonts.manrope(
                        color: Colors.white,
                        fontSize: 18,
                        height: 1.4,
                        fontWeight: FontWeight.w800,
                      ),
                      listBullet: GoogleFonts.manrope(
                        color: const Color(0xFFF2C96B),
                        fontSize: 16,
                        height: 1.9,
                        fontWeight: FontWeight.w800,
                      ),
                      strong: GoogleFonts.manrope(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                      em: GoogleFonts.manrope(
                        color: const Color(0xFFF2D27B),
                        fontStyle: FontStyle.italic,
                      ),
                      tableHead: GoogleFonts.manrope(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                      tableBody: GoogleFonts.manrope(
                        color: const Color(0xFFE8DEF0),
                        fontSize: 14,
                        height: 1.7,
                      ),
                      tableBorder: TableBorder.all(
                        color: const Color(0x33F2C96B),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      tableCellsPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      blockquotePadding: const EdgeInsets.all(14),
                      blockquoteDecoration: BoxDecoration(
                        color: const Color(0x12382B4D),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0x228A63FF)),
                      ),
                      horizontalRuleDecoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Color(0x22F2C96B)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
