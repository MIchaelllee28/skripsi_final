class AlatBahanRepository {
  final List<Map<String, dynamic>> data = [
    {
      "id": 1,
      'nama': 'tanah',
      "deskripsi": 'Tanah Subur',
      "foto": "lib/assets/images/tutorial/tanah.png",
    },
    {
      "id": 2,
      "nama": 'benih',
      "deskripsi": 'Benih kangkung, sawi, atau selada',
      "foto": "lib/assets/images/tutorial/benih.png",
    },
    {
      "id": 3,
      "nama": 'air',
      "deskripsi": 'Air',
      "foto": "lib/assets/images/tutorial/air.png",
    },
    {
      "id": 4,
      "nama": 'sprayer',
      "deskripsi": 'Sprayer (alat penyiram tanaman)',
      "foto": "lib/assets/images/tutorial/sprayer.png",
    },
  ];

  List<Map<String, dynamic>> getAlatBahanData() {
    return data;
  }
}
