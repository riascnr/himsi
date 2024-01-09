import 'package:flutter/material.dart';
import 'package:himsi/api_manager.dart';
import 'package:himsi/screens/mahasiswa_detail.dart';
import 'package:provider/provider.dart';

class User extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Mahasiswa(),
    );
  }
}

class Mahasiswa extends StatefulWidget {
  @override
  _User createState() => _User();
}

class _User extends State<Mahasiswa> {
  @override
  Widget build(BuildContext context) {
    final apiManager = Provider.of<ApiManager>(context, listen: false);

    return FutureBuilder<Map<String, dynamic>>(
      future: apiManager.fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final maha = snapshot.data!;
        final mahasiswa = maha['mahasiswa'];

        return Scaffold(
          appBar: AppBar(
            title: Text('Daftar Mahasiswa'),
            backgroundColor: Color.fromARGB(255, 0, 72, 131),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Mahasiswa HIMSI',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  if (mahasiswa!.isNotEmpty)
                    for (var data in mahasiswa)
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MahasiswaDetail(
                                mahasiswaId: data['id'].toString(),
                                mahasiswaName: data['name'],
                                mahasiswaImage: data['image'],
                                mahasiswaNim: data['nim'],
                                mahasiswaSemester: data['semester'].toString(),
                                mahasiswaJabatan: data['jabatan'],
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // Gambar di sebelah kiri
                                Image.network(
                                  "http://10.10.24.4:8000/img/${data['image']}",
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 16),
                                // Teks di sebelah kanan
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        data['name'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        data['jabatan'],
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                ],
              ),
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
        );
      },
    );
  }
}
