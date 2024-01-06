import 'package:flutter/material.dart';

class MahasiswaDetail extends StatelessWidget {
  final String mahasiswaId;
  final String mahasiswaName;
  final String mahasiswaImage;
  final String mahasiswaNim;
  final String mahasiswaSemester;
  final String mahasiswaJabatan;
  
  MahasiswaDetail({
    required this.mahasiswaId,
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
        title: Text(mahasiswaName),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'mahasiswa_image_$mahasiswaName',
                child: Image.network(
                  mahasiswaImage,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                mahasiswaName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                mahasiswaJabatan,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                mahasiswaNim,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                mahasiswaSemester,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
