import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/decision_result.dart';

class DecisionService extends ChangeNotifier {
  DecisionResult? currentResult;
  bool isLoading = false;
  String? errorMessage;

  static const String _apiKey = String.fromEnvironment('GEMINI_API_KEY');
  final List<String> _modelFallbacks = const [
    'gemini-2.5-flash',
    'gemini-2.0-flash',
  ];

  Future<void> analyzeDecision(String decisionPrompt) async {
    isLoading = true;
    currentResult = null;
    errorMessage = null;
    notifyListeners();

    try {
      if (_apiKey.isEmpty) {
        errorMessage =
            'Missing Gemini API key. Run the app with --dart-define=GEMINI_API_KEY=your_key';
        return;
      }

      final prompt = '''
      You are an expert decision-making assistant.
      The user is deciding about: "$decisionPrompt"

      Respond in markdown and include exactly these 3 sections with these exact headers:

      ### Pros and Cons
      Create a structured list with:
      - **Pros**
      - 3 to 4 bullet points
      - keep each bullet concise but still useful
      - **Cons**
      - 3 to 4 bullet points
      - keep each bullet concise but still useful

      ### Comparison Table
      Create a markdown table with 2 to 3 rows that compares:
      - the main decision option
      - at least one realistic alternative if possible
      Use columns like Option, Cost, Time, Difficulty, Risk, and Best For.
      After the table, add 1 short bullet point for the biggest tradeoff.

      ### SWOT Analysis
      Create a structured SWOT analysis with:
      - **Strengths**
      - **Weaknesses**
      - **Opportunities**
      - **Threats**
      Each category should have 2 bullet points.
      Keep them direct and practical.

      Important:
      - Do not add intro or outro text outside the 3 required sections.
      - Always include all 3 sections.
      - Keep the answer practical, specific, and easy to read.
      - Keep the total response compact.
      ''';

      String? lastError;

      for (final modelName in _modelFallbacks) {
        try {
          final model = GenerativeModel(
            model: modelName,
            apiKey: _apiKey,
          );

          final response = await model.generateContent([Content.text(prompt)]);
          final text = response.text?.trim() ?? '';

          if (text.isNotEmpty) {
            currentResult = _parseResponse(text, decisionPrompt);
            return;
          }

          lastError = 'Empty response from $modelName';
        } catch (e) {
          lastError = '$modelName failed: $e';
        }
      }

      errorMessage =
          lastError ?? 'Unable to generate analysis right now. Please try again.';
    } catch (e) {
      errorMessage = 'Failed: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  DecisionResult _parseResponse(String text, String decision) {
    final pros = _extractSection(text, 'Pros and Cons');
    final table = _extractSection(text, 'Comparison Table');
    final swot = _extractSection(text, 'SWOT Analysis');

    return DecisionResult(
      decision: decision,
      prosAndCons: pros ?? text,
      comparisonTable: table ?? 'No comparison table generated.',
      swotAnalysis: swot ?? 'No SWOT analysis generated.',
    );
  }

  String? _extractSection(String text, String header) {
    final pattern = RegExp(
      '###\\s*${RegExp.escape(header)}\\s*([\\s\\S]*?)(?=###\\s|\$)',
      caseSensitive: false,
    );
    final match = pattern.firstMatch(text);
    if (match == null) return null;

    final body = match.group(1)?.trim();
    if (body == null || body.isEmpty) return null;
    return '### $header\n\n$body';
  }
}
