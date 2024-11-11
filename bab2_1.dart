// ignore: unused_import
import "dart:collection";

// Enum untuk kategori produk
enum KategoriProduk { DataManagement, NetworkAutomation }

// Enum untuk fase proyek
enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

// Kelas untuk produk digital
class ProdukDigital {
  String _namaProduk;
  double _harga;
  KategoriProduk _kategori;
  int _terjual;

  ProdukDigital(this._namaProduk, this._harga, this._kategori, {int terjual = 0}) : _terjual = terjual {
    _validasiHarga();
  }

  String get namaProduk => _namaProduk;
  double get harga => _harga;
  KategoriProduk get kategori => _kategori;
  int get terjual => _terjual;

  void _validasiHarga() {
    if (_kategori == KategoriProduk.NetworkAutomation && _harga < 200000) {
      throw Exception('Harga untuk produk NetworkAutomation harus minimal 200.000');
    } else if (_kategori == KategoriProduk.DataManagement && _harga >= 200000) {
      throw Exception('Harga untuk produk DataManagement harus di bawah 200.000');
    }
  }

  double hargaAkhir() {
    if (_kategori == KategoriProduk.NetworkAutomation && _terjual > 50) {
      double diskon = _harga * 0.15;
      double hargaSetelahDiskon = _harga - diskon;
      return hargaSetelahDiskon < 200000 ? 200000 : hargaSetelahDiskon;
    }
    return _harga;
  }
}

// Mixin untuk kinerja karyawan
mixin Kinerja {
  int _produktivitas = 0;

  int get produktivitas => _produktivitas;

  void updateProduktivitas(int nilai) {
    if (nilai < 0 || nilai > 100) {
      throw Exception('Nilai produktivitas harus antara 0 dan 100');
    }
    _produktivitas = nilai;
  }
}

// Kelas dasar untuk karyawan
abstract class Karyawan {
  String _nama;
  int _umur;
  String _peran;

  Karyawan(this._nama, {required int umur, required String peran})
      : _umur = umur,
        _peran = peran;

  String get nama => _nama;
  int get umur => _umur;
  String get peran => _peran;

  void tampilkanInfo();
}

// Kelas untuk karyawan tetap
class KaryawanTetap extends Karyawan with Kinerja {
  KaryawanTetap(String nama, {required int umur, required String peran}) : super(nama, umur: umur, peran: peran) {
    if (peran == 'Manager' && umur < 30) {
      throw Exception('Manager harus berusia minimal 30 tahun');
    }
  }

  @override
  void tampilkanInfo() {
    print('Karyawan Tetap: $nama, Umur: $umur, Peran: $peran, Produktivitas: $produktivitas');
  }
}

// Kelas untuk karyawan kontrak
class KaryawanKontrak extends Karyawan with Kinerja {
  KaryawanKontrak(String nama, {required int umur, required String peran}) : super(nama, umur: umur, peran: peran) {
    if (peran == 'Developer' && umur < 25) {
      throw Exception('Developer harus berusia minimal 25 tahun');
    }
  }

  @override
  void tampilkanInfo() {
    print('Karyawan Kontrak: $nama, Umur: $umur, Peran: $peran, Produktivitas: $produktivitas');
  }
}

// Kelas untuk proyek
class Proyek {
  String _namaProyek;
  FaseProyek _fase;
  List<Karyawan> _tim;
  DateTime _tanggalMulai;

  Proyek(this._namaProyek)
      : _fase = FaseProyek.Perencanaan,
        _tim = [],
        _tanggalMulai = DateTime.now();

  List<Karyawan> get karyawanAktif => _tim;
  FaseProyek get fase => _fase;

  void tambahKaryawan(Karyawan karyawan) {
    if (_tim.length >= 20) {
      throw Exception('Maksimal 20 karyawan aktif diperbolehkan');
    }
    _tim.add(karyawan);
  }

    void pindahFase() {
    switch (_fase) {
      case FaseProyek.Perencanaan:
        if (_tim.length < 5) {
          throw Exception('Minimal 5 karyawan aktif diperlukan untuk pindah ke Pengembangan');
        }
        _fase = FaseProyek.Pengembangan;
        break;
      case FaseProyek.Pengembangan:
        if (DateTime.now().difference(_tanggalMulai).inDays > 45) {
          _fase = FaseProyek.Evaluasi;
        } else {
          throw Exception('Proyek harus berjalan lebih dari 45 hari untuk pindah ke Evaluasi');
        }
        break;
      case FaseProyek.Evaluasi:
        // Tidak ada fase setelah Evaluasi
        break;
    }
  }

  void tampilkanInfoProyek() {
    print('Proyek: $_namaProyek, Fase: $_fase, Karyawan dalam tim: ${_tim.length}');
    for (var karyawan in _tim) {
      karyawan.tampilkanInfo();
    }
  }
}

void main() {
  try {
    // Membuat karyawan
    KaryawanTetap karyawan1 = KaryawanTetap('Alice', umur: 30, peran: 'Manager');
    KaryawanTetap karyawan2 = KaryawanTetap('Bob', umur: 40, peran: 'Developer');
    KaryawanKontrak karyawan3 = KaryawanKontrak('Charlie', umur: 25, peran: 'Developer');

    // Mengupdate produktivitas
    karyawan1.updateProduktivitas(90);
    karyawan2.updateProduktivitas(80);
    karyawan3.updateProduktivitas(70);

    print('${karyawan1.nama} - Produktivitas: ${karyawan1.produktivitas}');
    print('${karyawan2.nama} - Produktivitas: ${karyawan2.produktivitas}');
    print('${karyawan3.nama} - Produktivitas: ${karyawan3.produktivitas}');

    // Membuat proyek
    Proyek proyek = Proyek('Proyek Pengembangan Software');

    // Menambah karyawan ke proyek
    proyek.tambahKaryawan(karyawan1);
    proyek.tambahKaryawan(karyawan2);
    proyek.tambahKaryawan(karyawan3);

    // Coba pindah fase proyek
    try {
      proyek.pindahFase(); // Pindah ke fase Pengembangan
      print('Fase proyek sekarang: ${proyek.fase}');
    } catch (e) {
      print('Kesalahan saat pindah fase: $e');
    }

    // Menambahkan lebih banyak karyawan untuk memenuhi syarat pindah fase
    KaryawanTetap karyawan4 = KaryawanTetap('David', umur: 35, peran: 'Developer');
    KaryawanTetap karyawan5 = KaryawanTetap('Eva', umur: 28, peran: 'Developer');
    KaryawanTetap karyawan6 = KaryawanTetap('Frank', umur: 32, peran: 'Manager');
    KaryawanTetap karyawan7 = KaryawanTetap('Grace', umur: 29, peran: 'Developer');

    proyek.tambahKaryawan(karyawan4);
    proyek.tambahKaryawan(karyawan5);
    proyek.tambahKaryawan(karyawan6);
    proyek.tambahKaryawan(karyawan7);

    // Coba pindah fase lagi
    try {
      proyek.pindahFase(); // Pindah ke fase Evaluasi
      print('Fase proyek sekarang: ${proyek.fase}');
    } catch (e) {
      print('Kesalahan saat pindah fase: $e');
    }

    // Menampilkan semua karyawan dalam proyek
    print('Karyawan dalam proyek:');
    for (var karyawan in proyek.karyawanAktif) {
      print('${karyawan.nama} - Peran: ${karyawan.peran}');
    }
  } catch (e) {
    print('Kesalahan: $e');
  }
}