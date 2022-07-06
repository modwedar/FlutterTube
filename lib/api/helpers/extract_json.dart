import 'dart:convert';

Map<String, dynamic>? extractJson(String s,[String separator = '']) {
  final index = s.indexOf(separator) + separator.length;
  if (index > s.length) {
    return null;
  }

  final str = s.substring(index);

  final startIdx = str.indexOf('{');
  var endIdx = str.lastIndexOf('}');

  while (true) {
    try {
      return json.decode(str.substring(startIdx, endIdx + 1))
      as Map<String, dynamic>;
    } on FormatException {
      endIdx = str.lastIndexOf(str.substring(0, endIdx));
      if (endIdx == 0) {
        return null;
      }
    }
  }
}