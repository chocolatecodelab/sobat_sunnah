class ModelNiat {
  final int id;
  final String judul;
  final String image;
  final String arabic;
  final String latin;
  final String terjemahan;
  final String deskripsi;
  final String manfaat;
  final String jadwal;

  ModelNiat(
      {required this.id,
      required this.judul,
      required this.image,
      required this.arabic,
      required this.latin,
      required this.terjemahan,
      required this.deskripsi,
      required this.manfaat,
      required this.jadwal});

  factory ModelNiat.fromJson(Map<String, dynamic> json) {
    return ModelNiat(
      id: json['id'] ?? 0, // Menggunakan 0 sebagai nilai default jika null
      judul: json['judul'] ??
          "", // Menggunakan string kosong sebagai nilai default jika null
      image: json['image'] ?? "",
      arabic: json['arabic'] ?? "",
      latin: json['latin'] ?? "",
      terjemahan: json['terjemahan'] ?? "",
      deskripsi: json['deskripsi'] ?? "",
      manfaat: json['manfaat'] ?? "",
      jadwal: json['jadwal'] ?? "",
    );
  }
}
