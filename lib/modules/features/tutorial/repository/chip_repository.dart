class ChipRepository {
  final List<Map<String, dynamic>> data = [
    {
      "id": 1,
      'nama': 'sawi',
      "foto": "lib/assets/images/tutorial/sawi.png",
      'color': '',
    },
    {
      "id": 2,
      "nama": 'selada',
      "foto": "lib/assets/images/tutorial/selada.png",
    },
    {
      "id": 3,
      "nama": 'kangkung',
      "foto": "lib/assets/images/tutorial/kangkung.png",
    },
    {
      "id": 4,
      "nama": 'sprayer',
      "foto": "lib/assets/images/iot/app_bar/soil.png",
    },
    {
      "id": 4,
      "nama": 'sprayer',
      "foto": "lib/assets/images/tutorial/sprayer.png",
    },
  ];

  List<Map<String, dynamic>> getChipData() {
    return data;
  }
}
