class IconsRepository {
  final List<Map<String, dynamic>> data = [
    {
      "id": 1,
      'nama': 'Coin',
      "deskripsi": 'Coin yang digunakan untuk membeli item didalam game',
      "foto": "assets/images/iot/app_bar/coin.png",
    },
    {
      "id": 2,
      "nama": 'soil',
      "deskripsi": 'Hasil pembacaan nilai Kelembapan tanah tanaman',
      "foto": "assets/images/iot/app_bar/soil.png",
    },
    {
      "id": 3,
      "nama": 'water',
      "deskripsi": 'Hasil pembacaan level air pada larutan nutrisi',
      "foto": "assets/images/iot/app_bar/water.png",
    },
    {
      "id": 4,
      "nama": 'temp',
      "deskripsi": 'Hasil pembacaan suhu pada lingkungan sekitar',
      "foto": "assets/images/iot/app_bar/temp.png",
    },
  ];

  List<Map<String, dynamic>> getIconData() {
    return data;
  }
}
