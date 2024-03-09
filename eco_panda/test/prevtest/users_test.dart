import 'package:flutter_test/flutter_test.dart';
import 'package:eco_panda/models/users.dart';

void main() {
  group('User', () {
    test('toMap converts a User instance into a map', () {
      final user = User(
        id: 1,
        username: 'test',
        carbonFootprintScore: 100,
        ecoScore: 200,
        history: [{'event': 'recycling', 'points': 10}],
      );

      final map = user.toMap();

      expect(map, {
        'id': 1,
        'username': 'test',
        'carbonFootprintScore': 100,
        'ecoScore': 200,
        'history': [{'event': 'recycling', 'points': 10}],
      });
    });
  });
}