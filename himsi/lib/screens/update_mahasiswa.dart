import 'package:flutter/material.dart';

class UpdateMahasiswaScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Mahasiswa'),
        backgroundColor: Color.fromARGB(255, 0, 72, 131),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Your update form or UI goes here
            Text(
              'Update Mahasiswa',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Add your form fields for updating the mahasiswa data
            // You can use TextFields, Dropdowns, etc.
            // Example:
            TextFormField(
              initialValue: mahasiswaName,
              decoration: InputDecoration(labelText: 'Nama Mahasiswa'),
              // Add any necessary validators or controllers
            ),
            // Add other form fields as needed
            // ...

            // Add an Update button or icon to submit the changes
            ElevatedButton(
              onPressed: () {
                // Implement the logic to update the mahasiswa data
                // You can use the data entered in the form fields
                // After updating, you can navigate back to the MahasiswaList screen
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
