class ShopRepository {
  final List<Map<String, dynamic>> _data = [
    {
      "nama": "pot_kucing_1",
      "kategori": "pot",
      "deskripsi": "assets/images/iot/main_part/pot_skin_1.png",
      "status": 0,
      "image": "https://i.imgur.com/ti11cWk.png",
      "harga": 5000,
      "id": "1"
    },
    {
      "nama": "pot_kucing_2",
      "kategori": "pot",
      "deskripsi": "assets/images/iot/main_part/pot_skin_2.png",
      "status": 0,
      "image": "https://i.imgur.com/S95US6v.png",
      "harga": 5000,
      "id": "2"
    },
    {
      "nama": "pot_kucing_3",
      "kategori": "pot",
      "deskripsi": "assets/images/iot/main_part/pot_skin_3.png",
      "status": 0,
      "image": "https://i.imgur.com/UkxaAR3.png",
      "harga": 5000,
      "id": "3"
    },
    {
      "nama": "pot_kucing_4",
      "kategori": "pot",
      "deskripsi": "assets/images/iot/main_part/pot_skin_4.png",
      "status": 0,
      "image": "https://i.imgur.com/avfP5qI.png",
      "harga": 5000,
      "id": "4"
    },
    {
      "nama": "Deep Inside",
      "kategori": "background",
      "deskripsi": "#8FBC8F",
      "status": 0,
      "image": "#8FBC8F",
      "harga": 5000,
      "id": "5"
    },
    {
      "nama": "Creamy Nyummy",
      "kategori": "background",
      "deskripsi": "#FFFDD0",
      "status": 0,
      "image": "#FFFDD0v",
      "harga": 1000,
      "id": "6"
    },
    {
      "nama": "Big Brownies",
      "kategori": "background",
      "deskripsi": "#483C32",
      "status": 0,
      "image": "#483C32",
      "harga": 1000,
      "id": "7"
    },
    {
      "nama": "Cold & Rainy",
      "kategori": "musik",
      "deskripsi": "music/light_the_storm.mp3",
      "status": 0,
      "image": "https://i.imgur.com/vUsi0vt.png",
      "harga": 100,
      "id": "8"
    },
    {
      "nama": "light the storm",
      "kategori": "musik",
      "deskripsi": "music/light_the_storm.mp3",
      "status": 0,
      "image": "https://i.imgur.com/xmaoGo2.png",
      "harga": 1000,
      "id": "9"
    },
    {
      "nama": "radio on",
      "kategori": "musik",
      "deskripsi": "music/radio_on.mp3",
      "status": 0,
      "image": "https://i.imgur.com/hfYp2kP.png",
      "harga": 600,
      "id": "10"
    },
    {
      "nama": "pot_kucing_5",
      "kategori": "pot",
      "deskripsi": "assets/images/iot/main_part/pot_skin_5.png",
      "status": 0,
      "image": "https://i.imgur.com/zqYsbIp.png",
      "harga": 1000,
      "id": "11"
    },
    {
      "nama": "free_coins",
      "kategori": "pot",
      "deskripsi": "https://i.imgur.com/Ish97h3.png",
      "status": 0,
      "image": "https://i.imgur.com/Ish97h3.png",
      "harga": 500,
      "id": "12"
    },
    {
      "nama": "rendezvous",
      "kategori": "musik",
      "deskripsi": "music/rendezvous.mp3",
      "status": 0,
      "image": "https://i.imgur.com/gB7UVBY.png",
      "harga": 500,
      "id": "13"
    },
    {
      "nama": "up all night",
      "kategori": "musik",
      "deskripsi": "music/up_all_night.mp3",
      "status": 0,
      "image": "https://i.imgur.com/ENs30CL.png",
      "harga": 700,
      "id": "14"
    },
    {
      "nama": "umbra",
      "kategori": "musik",
      "deskripsi": "music/umbra.mp3",
      "status": 0,
      "image": "https://i.imgur.com/xUHgdgM.png",
      "harga": 800,
      "id": "15"
    }
  ];

  void updateStatus(String id) {
    final index = _data.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      _data[index]['id'] = 1;
    }
  }

  List<Map<String, dynamic>> initializeShop(List<dynamic> ownedList) {
    final ownedId = ownedList.map((item) => item['id'].toString()).toSet();

    for (var item in _data) {
      if (ownedId.contains(item['id'].toString())) {
        item['status'] = 1;
      }
    }

    return _data;
  }
}
