import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, String>>> fetchData() async {
  final response = await http.get(Uri.parse('YOUR_API_ENDPOINT/get_mahasiswa.php'));

  if (response.statusCode == 200) {
    // Konversi response ke List<Map<String, String>>
    List<dynamic> data = json.decode(response.body);
    return List<Map<String, String>>.from(data);
  } else {
    throw Exception('Failed to load data');
  }
}
