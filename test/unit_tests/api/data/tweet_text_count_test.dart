import 'package:flutter_test/flutter_test.dart';
import 'package:harpy/api/api.dart';

void main() {
  group('tweet text count', () {
    test('counts each url as 23 characters', () {
      final count = tweetTextCount(
        'this tweet is rad! check out https://www.robertodoering.com and '
        'www.flutter.dev!',
      );

      const part1 = 'this tweet is rad! check out ';
      const part2 = ' and ';
      const part3 = '!';

      expect(
        count,
        equals(part1.length + part2.length + part3.length + 23 * 2),
      );
    });

    test(
        'counts emojis with and without combining modifiers as '
        '2 characters each', () {
      final count = tweetTextCount(
        // ๐พ (U+1F47E)
        '๐พ'
        // Emoji with skin tone modifier
        // ๐ (U+1F64B) + ๐ฝ (U+1F3FD)
        '๐๐ฝ'
        // Emoji sequence using combining glyph (zero-width joiner)
        // ๐จ (U+1F468) + U+200D + ๐ค (U+1F3A4)
        '๐จโ๐ค'
        // Emoji sequence using multiple combining glyphs (zero-width joiners)
        // ๐จ (U+1F468) + U+200D + ๐ฉ (U+1F469) + U+200D + ๐ง (U+1F467) +
        // U+200D + ๐ฆ (U+1F466)
        '๐จโ๐ฉโ๐งโ๐ฆ',
      );

      expect(count, equals(8));
    });

    test('counts special characters as 2', () {
      final count = tweetTextCount('ๅนฝ้ใๅฉๅฃใ้ใๅใซ');

      expect(count, equals(20));
    });

    test('counts normal-weighted characters as 1', () {
      final count = tweetTextCount('never gonna give you up');

      expect(count, equals(23));
    });
  });
}
