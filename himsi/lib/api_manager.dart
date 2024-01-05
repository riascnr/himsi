import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiManager {
  final String baseUrl;
  final storage = FlutterSecureStorage();

  ApiManager({required this.baseUrl});

//   Future<void> addmahasiswa(
//   String name,
//   String nim,
//   String semester,
//   String jabatan,
//   String image,
// ) async {
  
//     final response = await http.post(
//       Uri.parse('$baseUrl/mahasiswa'),
//       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//       body: {
//         'name': name,
//         'nim': nim,
//         'semester': semester,
//         'jabatan': jabatan,
//         'image': image,
//       },
//     );

//     print(response);

//     print('Response status: ${response.statusCode}');
//     print('Response body: ${response.body}');

//     if (response.statusCode != 200) {
//       throw Exception('Failed to add mahasiswa');
//     }
  
// }

Future<dynamic> addmahasiswa(
  String name,
  String nim,
  String semester,
  String jabatan,
  File image,
  ) async {
    final uri = Uri.parse('$baseUrl/mahasiswa');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', image.path))
      ..fields['name'] = name
      ..fields['nim'] = nim
      ..fields['semester'] = semester
      ..fields['jabatan'] = jabatan
      ..headers['Content-Type'] = 'application/json';

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(responseBody);
      return jsonResponse['message'];
    } else {
      return 'Failed to add mahasiswa. Status Code: ${response.statusCode}';
    }
  }

  // Future<void> addmahasiswa(
  //   String name,
  //   String nim,
  //   String semester,
  //   String jabatan,
  //   String image,
  // ) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/add_mahasiswa.php'),
  //     headers: {'Content-Type': 'application/x-www-form-urlencoded'},
  //     body: {
  //       'name': name,
  //       'nim': nim,
  //       'semester': semester,
  //       'jabatan': jabatan,
  //       'image': image,
  //     },
  //   );

  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to add mahasiswa');
  //   }
  // }

  Future<List<Map<String, dynamic>>> getmahasiswa() async {
    final response = await http.get(Uri.parse('$baseUrl/mahasiswa'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(jsonResponse);
    } else {
      throw Exception('Failed to get mahasiswa');
    }
  }

  Future<void> updatemahasiswa(String id, String name, String nim, String semester, String jabatan, String image) async {
    final response = await http.put(
      Uri.parse('$baseUrl/mahasiswa/{id}'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'id': id,
        'name': name,
        'nim': nim,
        'semester': semester,
        'jabatan': jabatan,
        'image': image,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update mahasiswa');
    }
  }

  Future<int?> deletemahasiswa(int id) async {
    final token = await storage.read(key: 'kode_rahassia');
     final response = await http.delete(
      Uri.parse('$baseUrl/mahasiswa'),
      headers: {'Authorization': 'Bearer $token'},
      body: jsonEncode({'id': id}), 
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete mahasiswa ${token}');
    }
    else{
      return response.statusCode;
    }
  }

  Future<String?> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'name': name,
        'email': email,
        'password': password
      },
    );

    if (response.statusCode == 201) {
      final token = "Succesfully";
      return token;
    } else {
      throw Exception('Failed to register, email sudah tersedia');

    }
  }


  // Future<void> login2(String email, String password) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/login.php'),
  //     headers: {'Content-Type': 'application/x-www-form-urlencoded'},
  //     body: {
  //       'email': email,
  //       'password': password,
  //     },
  //   );

    
  //     final jsonResponse = jsonDecode(response.body);
  //     final token = jsonResponse['token'];

  //     await storage.write(key: 'auth_token', value: token);

  //     return token;
    
    
  // }

  Future<String?> login(String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['token'];
      
      await storage.write(key: 'auth_token', value: token);

      return token;
    } else {
      throw Exception('Failed to login ${response.statusCode} ');
    }
  } catch (e) {
    print('Error in login: $e');
    throw e;
  }
}


  Future<String?> authenticate(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['token'];

      // Save the token securely
      await storage.write(key: 'kode_rahassia', value: token);

      return token;
    } else {
      throw Exception('Failed to authenticate');
    }
  }
}