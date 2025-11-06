class TrophySayuranRepository {
  final List<Map<String, dynamic>> data = [
    {
      "id": 1,
      "kategori": "kangkung",
      "trophy_level": 1,
      "deskripsi": 'Raih Level 1 Reward :',
      "trophy": "assets/images/trophy/trophy_1.png",
      "status": 0,
    },
    {
      "id": 2,
      "kategori": "kangkung",
      "trophy_level": 2,
      "deskripsi": 'Raih Level 2 Reward :',
      "trophy": "assets/images/trophy/trophy_2.png",
      "status": 0,
    },
    {
      "id": 3,
      "kategori": "kangkung",
      "trophy_level": 3,
      "deskripsi": 'Raih Level 3 Reward :',
      "trophy": "assets/images/trophy/trophy_3.png",
      "status": 0,
    },
    {
      "id": 4,
      "kategori": "sawi",
      "trophy_level": 1,
      "deskripsi": 'Raih Level 1 Reward :',
      "trophy": "assets/images/trophy/trophy_1.png",
      "status": 0,
    },
    {
      "id": 5,
      "kategori": "sawi",
      "trophy_level": 2,
      "deskripsi": 'Raih Level 2 Reward :',
      "trophy": "assets/images/trophy/trophy_2.png",
      "status": 0,
    },
    {
      "id": 6,
      "kategori": "sawi",
      "trophy_level": 3,
      "deskripsi": 'Raih Level 3 Reward :',
      "trophy": "assets/images/trophy/trophy_3.png",
      "status": 0,
    },
    {
      "id": 7,
      "kategori": "selada",
      "trophy_level": 1,
      "deskripsi": 'Raih Level 1 Reward :',
      "trophy": "assets/images/trophy/trophy_1.png",
      "status": 0,
    },
    {
      "id": 8,
      "kategori": "selada",
      "trophy_level": 2,
      "deskripsi": 'Raih Level 2 Reward :',
      "trophy": "assets/images/trophy/trophy_2.png",
      "status": 0,
    },
    {
      "id": 9,
      "kategori": "selada",
      "trophy_level": 3,
      "deskripsi": 'Raih Level 3 Reward :',
      "trophy": "assets/images/trophy/trophy_3.png",
      "status": 0,
    },
  ];

  List<Map<String, dynamic>> getTrophySayuranData() => data;

  Map<String, dynamic> claimTrophy(int id, int waterCount) {
    final index = data.indexWhere((item) => item['id'] == id);
    if (index == -1) return {'data': data, 'success': false};

    final isValid = _validationTrophy(data[index]['trophy_level'], waterCount);
    if (isValid) {
      data[index]['status'] = 1;
    }
    return {'data': data, 'success': isValid};
  }

  bool _validationTrophy(int level, int waterCount) {
    switch (level) {
      case 1:
        return waterCount > 1;

      case 2:
        return waterCount > 7;

      case 3:
        return waterCount > 14;

      default:
        return false;
    }
  }
}
