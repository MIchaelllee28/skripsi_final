class SawiRepository {
  final List<Map<String, dynamic>> data = [
    {
      "id": 1,
      "sayur": "Sawi",
      "level": 1,
      "tahap": "Penanaman dan Perkecambahan",
      "waktu": "(0-2 minggu)",
      "deskripsi": r"""
          <p class="demoTitle">&nbsp;</p>
          <p>Proses Pertumbuhan</p>
          <ul style="list-style-type: circle;">
            <li><span style="color: #ff0000;">Hari 0-2:</span> Benih sawi ditanam di pot yang telah disiapkan dengan media tanam.</li>
            <li><span style="color: #ff0000;">Hari 3-7:</span> Benih mulai berkecambah dan tumbuh tunas kecil.</li>
            <li><span style="color: #ff0000;">Hari 8-14:</span> Tunas berkembang menjadi bibit kecil dengan beberapa daun sejati muncul.</li>
          </ul>
        """,
      "foto": "lib/assets/images/tutorial/sawi.png",
    },
    {
      "id": 2,
      "sayur": "Sawi",
      "level": 1,
      "tahap": "Penanaman dan Perkecambahan",
      "waktu": "(0-2 minggu)",
      "deskripsi": r"""
          <p>Cara Perawatan</p>
          <ul style="list-style-type: circle;">
            <li><span style="color: #ff0000;">Penyiraman:</span> Pastikan tanah tetap lembab tetapi tidak terlalu basah. Siram secara rutin di aplikasi, atau hidupkan fitur auto.</li>
            <li><span style="color: #ff0000;">Pencahayaan:</span> Letakkan pot di tempat yang mendapatkan sinar matahari langsung selama 4-6 jam per hari.</li>
            <li><span style="color: #ff0000;">Perlindungan:</span> Lindungi benih dan bibit dari serangga dan hama. Jika perlu, gunakan penutup transparan untuk menjaga kelembaban dan melindungi dari hama.</li>
          </ul>
        """,
      "foto": "lib/assets/images/tutorial/sawi.png",
    },
    {
      "id": 3,
      "sayur": "Sawi",
      "level": 2,
      "tahap": "Pertumbuhan Vegetatif",
      "waktu": "(2-4 minggu)",
      "deskripsi": r"""
          <p>Proses Pertumbuhan</p>
          <ul style="list-style-type: circle;">
            <li><span style="color: #ff0000;">Hari 15-28:</span> Tanaman mulai tumbuh lebih cepat, dengan daun yang lebih besar dan lebih banyak, serta batang yang semakin panjang dan kokoh.</li>
          </ul>
        """,
      "foto": "lib/assets/images/tutorial/sawi.png",
    },
    {
      "id": 4,
      "sayur": "Sawi",
      "level": 2,
      "tahap": "Pertumbuhan Vegetatif",
      "waktu": "(2-4 minggu)",
      "deskripsi": r"""
          <p>Cara Perawatan</p>
          <ul style="list-style-type: circle;">
            <li><span style="color: #ff0000;">Penyiraman:</span> Siram tanaman secara teratur, setiap pagi atau sore hari melalui fitur siram di aplikasi, atau hidupkan fitur auto.</li>
            <li><span style="color: #ff0000;">Pemupukan:</span> Berikan pupuk organik cair atau kompos setiap 2 minggu sekali. Pupuk dapat diberikan dengan cara disiramkan ke tanah.</li>
            <li><span style="color: #ff0000;">Penyiangan:</span> Cabut gulma yang tumbuh di sekitar pot untuk mengurangi persaingan nutrisi.</li>
            <li><span style="color: #ff0000;">Pencahayaan:</span> Pastikan tanaman tetap mendapatkan sinar matahari langsung selama 4-6 jam per hari.</li>
          </ul>
        """,
      "foto": "lib/assets/images/tutorial/sawi.png",
    },
    {
      "id": 5,
      "sayur": "Sawi",
      "level": 3,
      "tahap": "Pemeliharaan dan Panen",
      "waktu": "(4-6 Minggu)",
      "deskripsi": r"""
          <p>Proses Pertumbuhan</p>
          <ul style="list-style-type: circle;">
            <li><span style="color: #ff0000;">Hari 29-42:</span> Tanaman mencapai tinggi optimal dan siap untuk dipanen. Daun dan batang sudah cukup besar dan segar.</li>
          </ul>
        """,
      "foto": "lib/assets/images/tutorial/sawi.png",
    },
    {
      "id": 6,
      "sayur": "Sawi",
      "level": 3,
      "tahap": "Pemeliharaan dan Panen",
      "waktu": "(4-6 Minggu)",
      "deskripsi": r"""
          <p>Cara Perawatan</p>
          <ul style="list-style-type: circle;">
            <li><span style="color: #ff0000;">Penyiraman:</span> Tetap siram tanaman secara teratur melalui aplikasi, atau nyalakan fitur auto untuk penyiraman otomatis.</li>
            <li><span style="color: #ff0000;">Pemupukan:</span> Lanjutkan pemberian pupuk organik setiap 2 minggu sekali untuk menjaga nutrisi yang cukup hingga panen.</li>
            <li><span style="color: #ff0000;">Pemangkasan:</span> Jika ada daun atau batang yang rusak atau kering, pangkas untuk mendorong pertumbuhan baru yang sehat.</li>
            <li><span style="color: #ff0000;">Panen:</span> Sawi dapat dipanen sekitar 6-8 minggu setelah tanam. Potong seluruh bagian tanaman di dekat pangkal. Pastikan untuk memanen sebelum tanaman berbunga untuk mendapatkan kualitas daun yang terbaik.</li>
          </ul>
        """,
      "foto": "lib/assets/images/tutorial/sawi.png",
    },
  ];

  List<Map<String, dynamic>> getSawiData() {
    return data;
  }
}
