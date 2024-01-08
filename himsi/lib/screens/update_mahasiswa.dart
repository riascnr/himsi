import 'dart:io';
import 'package:flutter/material.dart';
import 'package:himsi/api_manager.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';


class UpdateMahasiswaScreen extends StatefulWidget {
  final String mahasiswaName;
  final String mahasiswaImage;
  final String mahasiswaNim;
  final int mahasiswaSemester;
  final String mahasiswaJabatan;
  final String mahasiswaId;
  final ApiManager apiManager;

  UpdateMahasiswaScreen({
    required this.mahasiswaName,
    required this.mahasiswaImage,
    required this.mahasiswaNim,
    required this.mahasiswaSemester,
    required this.mahasiswaJabatan, 
    required this.mahasiswaId,
    required this.apiManager,
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

  late File? _image = null;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.mahasiswaName);
    nimController = TextEditingController(text: widget.mahasiswaNim);
    semesterController = TextEditingController(text: widget.mahasiswaSemester.toString());
    jabatanController = TextEditingController(text: widget.mahasiswaJabatan);
    imageController = TextEditingController(text: widget.mahasiswaImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Mahasiswa'),
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
  onPressed: () async {
    final name = nameController.text;
    final nim = nimController.text;
    final semester = semesterController.text;
    final jabatan = jabatanController.text;

    try {
      if (_image != null) {
        // Update the existing data with a new photo
        await widget.apiManager.UpdateWithFoto(
          widget.mahasiswaId,
          name,
          nim,
          semester,
          jabatan,
          _image!,
        );
      } else {
        // Update the existing data without changing the photo
        await widget.apiManager.UpdateWithoutFoto(
          widget.mahasiswaId,
          name,
          nim,
          semester,
          jabatan,
        );
      }
    } catch (e) {
      // Handle any potential errors here
      print('Error updating data: $e');
    }

    Navigator.pushReplacementNamed(context, "/mahasiswalist");
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
      'Edit',
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
        child: Center(
                        child: _image != null
                            ? Image.file(_image!, fit: BoxFit.cover)
                            : Image.network(
                                "http://10.10.24.4:8000/img/${widget.mahasiswaImage}" ??
                                    '',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                      ),
      ),
    );
  }

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
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
