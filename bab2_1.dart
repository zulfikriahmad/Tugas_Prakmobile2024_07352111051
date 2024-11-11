// ignore_for_file: unused_import

import "dart:collection";

class ProdukDigital {
  String nama;
  double harga;

  ProdukDigital({required this.nama, required this.harga});

  void terapkanDiskon(double persentase) {
    if (persentase > 0 && persentase <= 100) {
      harga -= harga * (persentase / 100);
    } else {
      print("Persentase diskon tidak valid.");
    }
  }

  @override
  String toString() {
    return 'Produk: $nama, Harga: \$${harga.toStringAsFixed(2)}';
  }
}
class Karyawan {
  String nama;
  int umur;
  String peran;

  Karyawan({required this.nama, required this.umur, required this.peran});

  void bekerja() {
    print('$nama sedang bekerja sebagai $peran.');
  }

  @override
  String toString() {
    return 'Karyawan: $nama, Umur: $umur, Peran: $peran';
  }
}
class KaryawanTetap extends Karyawan {
  double gaji;

  KaryawanTetap({required String nama, required int umur, required String peran, required this.gaji})
      : super(nama: nama, umur: umur, peran: peran);

  void tunjangan() {
    print('$nama mendapatkan tunjangan.');
  }

  @override
  String toString() {
    return super.toString() + ', Gaji: \$${gaji.toStringAsFixed(2)}';
  }
}

class KaryawanKontrak extends Karyawan {
  double tarifPerJam;

  KaryawanKontrak({required String nama, required int umur, required String peran, required this.tarifPerJam})
      : super(nama: nama, umur: umur, peran: peran);

  void hitungGaji(int jamKerja) {
    double gaji = jamKerja * tarifPerJam;
    print('$nama mendapatkan gaji \$${gaji.toStringAsFixed(2)} untuk $jamKerja jam kerja.');
  }

  @override
  String toString() {
    return super.toString() + ', Tarif per Jam: \$${tarifPerJam.toStringAsFixed(2)}';
  }
}
void main() {
  // Membuat produk digital
  ProdukDigital produk1 = ProdukDigital(nama: "Software A", harga: 100.0);
  print(produk1);
  produk1.terapkanDiskon(20);
  print("Setelah diskon: $produk1");

  // Membuat karyawan tetap
  KaryawanTetap karyawan1 = KaryawanTetap(nama: "Alice", umur: 30, peran: "Developer", gaji: 5000.0);
  karyawan1.bekerja();
  karyawan1.tunjangan();
  print(karyawan1);

  // Membuat karyawan kontrak
  KaryawanKontrak karyawan2 = KaryawanKontrak(nama: "Bob", umur: 25, peran: "Designer", tarifPerJam: 50.0);
  karyawan2.bekerja();
  karyawan2.hitungGaji(40); // Menghitung gaji untuk 40 jam kerja
  print(karyawan2);
}