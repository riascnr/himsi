import 'package:flutter/material.dart';
import 'package:himsi/api_manager.dart';
import 'package:himsi/screens/mahasiswa_detail.dart';
import 'package:himsi/screens/add_mahasiswa.dart';
import 'package:provider/provider.dart';

class MahasiswaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Mahasiswa(),
    );
  }
}


class Mahasiswa extends StatefulWidget {
  @override
  _MahasiswaList createState() => _MahasiswaList();
}

class _MahasiswaList extends State<Mahasiswa> {
  
  @override
  Widget build(BuildContext context) {
    final apiManager = Provider.of<ApiManager>(context, listen: false);

    return FutureBuilder<Map<String, dynamic>>(
      future: apiManager.fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final maha = snapshot.data!;
        final mahasiswa = maha['mahasiswa'];

        return Scaffold(
          appBar: AppBar(
            title: Text('Dashboard'),
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
                                mahasiswaId: data['id'],
                                mahasiswaName: data['name'],
                                mahasiswaImage: data['image'],
                                mahasiswaNim: data['nim'],
                                mahasiswaSemester: data['semester'],
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                Image.network(
                                  "http://10.10.24.4:8000/img/${data['image']}",
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
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
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // Handle edit action
                                      },
                                      tooltip: 'Edit Mahasiswa',
                                      icon: Icon(Icons.edit, color: Colors.white),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Konfirmasi Hapus"),
                                              content: Text("Apakah anda yakin ingin menghapus data mahasiswa?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () async {
                                                    final delete = await apiManager.deletemahasiswa(data["id"]);
                                                    if (delete == 200) {
                                                      Navigator.pop(context); // Tutup dialog
                                                      setState(() {}); // Perbarui tampilan
                                                    }
                                                  },
                                                  child: Text("Ok"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(Icons.delete, color: Colors.white),
                                    ),
                                  ],
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
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddMahasiswaScreen()),
              );

              setState(() {});
            },
            tooltip: 'Tambah Mahasiswa',
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
