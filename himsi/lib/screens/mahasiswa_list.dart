import 'package:flutter/material.dart';
import 'package:himsi/screens/mahasiswa_detail.dart';
import 'package:himsi/screens/add_mahasiswa.dart';
import 'package:himsi/screens/update_mahasiswa.dart';

class MahasiswaList extends StatelessWidget {

  final List<Map<String, String>> mahasiswa = [
    {'name': 'Kiki Alfaini Nurrizki',
      'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      'nim' : 'NIM : 200112004',
      'semester' : 'Semester : 7',
      'jabatan': 'Ketua HIMSI 2022/2023'
    },
    {'name': 'Azkiyatun Nadroh',
      'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      'nim' : 'NIM : 200112004',
      'semester' : 'Semester : 7',
      'jabatan': 'Sekretaris HIMSI 2023/2024'
    },
    {'name': 'Ria Suci Nurhalizah',
      'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      'nim' : 'NIM : 210112004',
      'semester' : 'Semester : 5',
      'jabatan': 'Wakil ketua HIMSI 2022/2023'
    },
    {'name': 'Ulan Juniarti',
      'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      'nim' : 'NIM : 210112004',
      'semester' : 'Semester : 5',
      'jabatan': 'Div. Litbang - Ketua HIMSI 2023/2024'
    },
    {'name': 'Ariefah Khairinna',
      'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      'nim' : 'NIM : 210112004',
      'semester' : 'Semester : 5',
      'jabatan': 'Bendahara HIMSI 2022/2023 - Div. Technopreneur 2023/2024'
    },
    {'name': 'Evana Anugrah P',
      'image': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
      'nim' : 'NIM : 220112004',
      'semester' : 'Semester : 3',
      'jabatan': 'Div. Humas - Wakil Ketua HIMSI 2023/2024'
    },
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Color.fromARGB(255, 0, 72, 131),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Header Section
            Text(
              'Mahasiswa HIMSI',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: mahasiswa.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Navigate to the mahasiswa detail screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MahasiswaDetail (
                            mahasiswaName: mahasiswa[index]['name']!,
                            mahasiswaImage: mahasiswa[index]['image']!,
                            mahasiswaNim: mahasiswa[index]['nim']!,
                            mahasiswaSemester: mahasiswa[index]['semester']!,
                            mahasiswaJabatan: mahasiswa[index]['jabatan']!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4.0,
                      color: Color.fromARGB(255, 0, 72, 131),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              mahasiswa[index]['name']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Image.network(
                              mahasiswa[index]['image']!,
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 8),
                            Text(
                              mahasiswa[index]['jabatan']!,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // Navigate to the update_mahasiswa.dart screen
                                    Navigator.pushNamed(context, '/update_mahasiswa');
                                  },
                                  icon: Icon(Icons.edit, color: Colors.white),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // Handle delete action
                                    // You can show a confirmation dialog, and if confirmed, delete the item
                                  },
                                  icon: Icon(Icons.delete, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 72, 131),
              ),
              child: Text(
                'HIMSI',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Daftar Mahasiswa'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke layar tambah mahasiswa
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMahasiswaScreen()),
          );
        },
        tooltip: 'Tambah Mahasiswa',
        child: Icon(Icons.add),
      ),
    );
  }
}
