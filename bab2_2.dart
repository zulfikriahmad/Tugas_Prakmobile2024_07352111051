// Enum untuk jenis kendaraan
enum JenisKendaraan {
  mobil,
  motor,
  truk,
}

// Kelas abstrak untuk Kendaraan
abstract class Kendaraan {
  String merek;
  String model;
  int tahun;

  Kendaraan({required this.merek, required this.model, required this.tahun});

  void infoKendaraan(); // Metode abstrak
}

// Mixin untuk fitur tambahan
mixin FiturKendaraan {
  String? fiturTambahan;

  void tambahFitur(String fitur) {
    fiturTambahan = fitur;
    print('Fitur tambahan telah ditambahkan: $fiturTambahan');
  }
}

// Kelas Mobil yang menginherit dari Kendaraan dan menggunakan mixin FiturKendaraan
class Mobil extends Kendaraan with FiturKendaraan {
  int jumlahPintu;

  Mobil({
    required String merek,
    required String model,
    required int tahun,
    required this.jumlahPintu,
  }) : super(merek: merek, model: model, tahun: tahun);

  @override
  void infoKendaraan() {
    print('Kendaraan: Mobil');
    print('Merek: $merek, Model: $model, Tahun: $tahun, Jumlah Pintu: $jumlahPintu');
  }
}

// Kelas Motor yang menginherit dari Kendaraan
class Motor extends Kendaraan {
  bool adaRemCakram;

  Motor({
    required String merek,
    required String model,
    required int tahun,
    this.adaRemCakram = false,
  }) : super(merek: merek, model: model, tahun: tahun);

  @override
  void infoKendaraan() {
    print('Kendaraan: Motor');
    print('Merek: $merek, Model: $model, Tahun: $tahun, Rem Cakram: ${adaRemCakram ? "Ya" : "Tidak"}');
  }
}

// Kelas Truk yang menginherit dari Kendaraan
class Truk extends Kendaraan {
  double kapasitasMuatan;

  Truk({
    required String merek,
    required String model,
    required int tahun,
    required this.kapasitasMuatan,
  }) : super(merek: merek, model: model, tahun: tahun);

  @override
  void infoKendaraan() {
    print('Kendaraan: Truk');
    print('Merek: $merek, Model: $model, Tahun: $tahun, Kapasitas Muatan: ${kapasitasMuatan} ton');
  }
}

// Kelas untuk mengelola daftar kendaraan
class ManajemenKendaraan {
  List<Kendaraan> daftarKendaraan = [];

  void tambahKendaraan(Kendaraan kendaraan) {
    daftarKendaraan.add(kendaraan);
  }

  void tampilkanSemuaKendaraan() {
    for (var kendaraan in daftarKendaraan) {
      kendaraan.infoKendaraan();
      print('--------------------------------');
    }
  }
}

// Contoh penggunaan
void main() {
  // Membuat instance ManajemenKendaraan
  ManajemenKendaraan manajemenKendaraan = ManajemenKendaraan();

  // Membuat kendaraan
  Mobil mobil1 = Mobil(merek: "Toyota", model: "Camry", tahun: 2020, jumlahPintu: 4);
  Motor motor1 = Motor(merek: "Honda", model: "CBR", tahun: 2019, adaRemCakram: true);
  Truk truk1 = Truk(merek: "Volvo", model: "FH", tahun: 2021, kapasitasMuatan: 18.0);

  // Menambahkan kendaraan ke manajemen
  manajemenKendaraan.tambahKendaraan(mobil1);
  manajemenKendaraan.tambahKendaraan(motor1);
  manajemenKendaraan.tambahKendaraan(truk1);

  // Menampilkan semua kendaraan
  print('Daftar Kendaraan:');
  manajemenKendaraan.tampilkanSemuaKendaraan();

  // Menambahkan fitur tambahan ke mobil
  mobil1.tambahFitur("Sunroof");
}