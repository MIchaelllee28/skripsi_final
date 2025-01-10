class TrophyChipRepository {
  final List<Map<String, dynamic>> data = [
    {
      "id": 1,
      'nama': 'trophy_sawi',
      "foto": "lib/assets/images/trophy/buttons/trophy_button_sawi.png",
    },
    {
      "id": 2,
      "nama": 'trophy_selada',
      "foto": "lib/assets/images/trophy/buttons/trophy_button_selada.png",
    },
    {
      "id": 3,
      "nama": 'trophy_kangkung',
      "foto": "lib/assets/images/trophy/buttons/trophy_button_kangkung.png",
    },
  ];

  List<Map<String, dynamic>> getTrophyChipData() {
    return data;
  }
}
