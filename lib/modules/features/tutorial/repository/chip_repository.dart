class ChipRepository {
  final List<Map<String, dynamic>> data = [
    {
      "id": 1,
      'nama': 'sawi',
      "foto": "assets/images/tutorial/sawi.png",
      'color': '',
    },
    {
      "id": 2,
      "nama": 'selada',
      "foto": "assets/images/tutorial/selada.png",
    },
    {
      "id": 3,
      "nama": 'kangkung',
      "foto": "assets/images/tutorial/kangkung.png",
    },
    {
      "id": 4,
      "nama": 'sprayer',
      "foto": "assets/images/iot/app_bar/soil.png",
    },
    {
      "id": 4,
      "nama": 'sprayer',
      "foto": "assets/images/tutorial/sprayer.png",
    },
  ];

  List<Map<String, dynamic>> getChipData() {
    return data;
  }
}
