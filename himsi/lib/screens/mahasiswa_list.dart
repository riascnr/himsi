import 'package:flutter/material.dart';
import 'package:himsi/screens/mahasiswa_detail.dart';
import 'package:himsi/screens/add_mahasiswa.dart';
import 'package:himsi/screens/update_mahasiswa.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MahasiswaList extends StatefulWidget {
  @override
  _MahasiswaListState createState() => _MahasiswaListState();
}

class _MahasiswaListState extends State<MahasiswaList> {
  late Future<List<Map<String, String>>> mahasiswa;

  @override
  void initState() {
    super.initState();
    mahasiswa = fetchData();
  }

  Future<List<Map<String, String>>> fetchData() async {
    final response = await http.get(
      Uri.parse('http://10.10.24.2/api_php/get_mahasiswa.php'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, String>>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

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
            Text(
              'Mahasiswa HIMSI',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Map<String, String>>>(
                future: mahasiswa,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MahasiswaDetail(
                                  mahasiswaName: snapshot.data![index]['name']!,
                                  mahasiswaImage: snapshot.data![index]['image']!,
                                  mahasiswaNim: snapshot.data![index]['nim']!,
                                  mahasiswaSemester: snapshot.data![index]['semester']!,
                                  mahasiswaJabatan: snapshot.data![index]['jabatan']!,
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
                                    snapshot.data![index]['name']!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Image.network(
                                    snapshot.data![index]['image']!,
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    snapshot.data![index]['jabatan']!,
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
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UpdateMahasiswaScreen(
                                                mahasiswaName: snapshot.data![index]['name']!,
                                                mahasiswaImage: snapshot.data![index]['image']!,
                                                mahasiswaNim: snapshot.data![index]['nim']!,
                                                mahasiswaSemester: snapshot.data![index]['semester']!,
                                                mahasiswaJabatan: snapshot.data![index]['jabatan']!,
                                              ),
                                            ),
                                          );
                                        },
                                        tooltip: 'Edit Mahasiswa',
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
                    );
                  }
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
