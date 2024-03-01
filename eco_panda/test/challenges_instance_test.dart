import 'package:flutter_test/flutter_test.dart';
import 'package:eco_panda/models/challenges.dart';

void main() {
  group('Challenges', () {
    test('toMap converts a Challenges instance into a map', () {
      final challenge = Challenges(
        id: 1,
        title: 'Daily Challenge',
        description: 'First Eco route of the day',
        requirements: 'Plan a route',
        rewardScore: 100,
      );

      final map = challenge.toMap();

      expect(map, {
        'id': 1,
        'title': 'Daily Challenge',
        'description': 'First Eco route of the day',
        'requirements': 'Plan a route',
        'reward score': 100,
      });
    });
  });
}