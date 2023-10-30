class ModelNiat {
  final int id;
  final String judul;
  final String arabic;
  final String latin;
  final String terjemahan;
  final String deskripsi;
  final String manfaat;

  ModelNiat({
    required this.id,
    required this.judul,
    required this.arabic,
    required this.latin,
    required this.terjemahan,
    required this.deskripsi,
    required this.manfaat,
  });

  factory ModelNiat.fromJson(Map<String, dynamic> json) {
    return ModelNiat(
      id: json['id'] ?? 0, // Menggunakan 0 sebagai nilai default jika null
      judul: json['judul'] ??
          "", // Menggunakan string kosong sebagai nilai default jika null
      arabic: json['arabic'] ?? "",
      latin: json['latin'] ?? "",
      terjemahan: json['terjemahan'] ?? "",
      deskripsi: json['deskripsi'] ?? "",
      manfaat: json['manfaat'] ?? "",
    );
  }
}
