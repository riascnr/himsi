import 'package:flutter/material.dart';

class UpdateMahasiswaScreen extends StatefulWidget {
  final String mahasiswaName;
  final String mahasiswaImage;
  final String mahasiswaNim;
  final String mahasiswaSemester;
  final String mahasiswaJabatan;

  UpdateMahasiswaScreen({
    required this.mahasiswaName,
    required this.mahasiswaImage,
    required this.mahasiswaNim,
    required this.mahasiswaSemester,
    required this.mahasiswaJabatan,
  });

  @override
  _UpdateMahasiswaScreenState createState() => _UpdateMahasiswaScreenState();
}

class _UpdateMahasiswaScreenState extends State<UpdateMahasiswaScreen> {
  late TextEditingController nameController;
  late TextEditingController nimController;
  late TextEditingController semesterController;
  late TextEditingController jabatanController;
  late TextEditingController imageController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.mahasiswaName);
    nimController = TextEditingController(text: widget.mahasiswaNim);
    semesterController = TextEditingController(text: widget.mahasiswaSemester);
    jabatanController = TextEditingController(text: widget.mahasiswaJabatan);
    imageController = TextEditingController(text: widget.mahasiswaImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Mahasiswa'),
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
            _buildImageTextField('Image URL', imageController),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement the logic to update the mahasiswa data
                // You can use the data entered in the form fields
                // After updating, you can navigate back to the MahasiswaList screen
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
                  'Update',
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

  Widget _buildImageTextField(String label, TextEditingController controller) {
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

  @override
  void dispose() {
    nameController.dispose();
    nimController.dispose();
    semesterController.dispose();
    jabatanController.dispose();
    imageController.dispose();
    super.dispose();
  }
}
