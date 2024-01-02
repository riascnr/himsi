class Mahasiswa {
  int id;
  String nama;
  String jurusan;

  Mahasiswa({required this.id, required this.nama, required this.jurusan});

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      id: json['id'],
      nama: json['nama'],
      jurusan: json['jurusan'],
    );
  }
}
