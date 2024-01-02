import 'package:flutter/material.dart';

class AddMahasiswaScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nimController = TextEditingController();
  final TextEditingController semesterController = TextEditingController();
  final TextEditingController jabatanController = TextEditingController();

  final List<Map<String, String>> mahasiswaList;

  AddMahasiswaScreen({required this.mahasiswaList});

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
            ElevatedButton(
              onPressed: () {
                // Implementasi logika untuk menambahkan mahasiswa ke daftar
                // Anda dapat menyimpan data baru ke mahasiswa list atau server
                String name = nameController.text;
                String nim = nimController.text;
                String semester = semesterController.text;
                String jabatan = jabatanController.text;

                Map<String, String> newMahasiswa = {
                  'name': name,
                  'nim': 'NIM : $nim',
                  'semester': 'Semester : $semester',
                  'jabatan': jabatan,
                };

                mahasiswaList.add(newMahasiswa);

                Navigator.pop(context); // Kembali ke layar sebelumnya setelah menambahkan mahasiswa
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
}
