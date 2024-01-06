import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddMahasiswaScreen extends StatefulWidget {
  @override
  _AddMahasiswaScreenState createState() => _AddMahasiswaScreenState();
}

class _AddMahasiswaScreenState extends State<AddMahasiswaScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nimController = TextEditingController();
  final TextEditingController semesterController = TextEditingController();
  final TextEditingController jabatanController = TextEditingController();

  File? _image;

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> addMahasiswa() async {
    final uri = Uri.parse('http://127.0.0.1:8000/mahasiswa');
    final request = http.MultipartRequest('POST', uri);

    request.fields['name'] = nameController.text;
    request.fields['nim'] = nimController.text;
    request.fields['semester'] = semesterController.text;
    request.fields['jabatan'] = jabatanController.text;

    if (_image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
    }

    final response = await request.send();

    if (response.statusCode == 201) {
      // If the Mahasiswa is added successfully, pop the screen
      Navigator.pop(context);
    } else {
      // Handle the error
      print('Error adding Mahasiswa: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Mahasiswa'),
        backgroundColor: Color.fromARGB(255, 0, 72, 131),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildTextField('Nama Mahasiswa', nameController),
            SizedBox(height: 16),
            _buildTextField('NIM', nimController),
            SizedBox(height: 16),
            _buildTextField('Semester', semesterController),
            SizedBox(height: 16),
            _buildTextField('Jabatan', jabatanController),
            SizedBox(height: 20),
            _buildImagePicker(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement your logic to add a student with the entered data and the selected image
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 0, 72, 131),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Tambah',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color.fromARGB(255, 0, 72, 131), width: 2),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: getImage,
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: _image == null
            ? Center(
                child: Text(
                  'Pilih Foto',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : Image.file(
                _image!,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
