//Abstract Class Trasnportasi
abstract class Transportasi{
  String id;
  String nama;
  double _tarifDasar;
  int kapasitas;

  Transportasi(this.id,this.nama,this._tarifDasar, this.kapasitas);

  double get tarifDasar => _tarifDasar;

  double hitungTarif(int jumlahPenumpang);

  void tampilInfo(){
    print("ID:  : $id");
    print("Nama : $nama");
    print("Kapasitas :$kapasitas");
    print("Tarif Dasar  :$_tarifDasar");
  }
}
//Kelas Taksi
class Taksi extends Transportasi{
  double jarak;

  Taksi(String id,String nama,double tarifDasar, int kapasitas, this.jarak)
   :super(id,nama,tarifDasar,kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang){
    return tarifDasar * jarak;
  }

  @override
  void tampilInfo(){
    super.tampilInfo();
    print("jarak  :${jarak}km");
    print("jenis  :Taksi");
  }
}
//Kelas Bus
class Bus extends Transportasi {
  bool adaWifi;

  Bus(String id, String nama, double tarifDasar,int kapasitas, this.adaWifi)
    :super(id,nama,tarifDasar,kapasitas);

    @override
    double hitungTarif(int jumlahPenumpang){
      return(tarifDasar * jumlahPenumpang) + (adaWifi?5000:0);
    }

    @override
    void tampilInfo(){
      super.tampilInfo();
      print("Wifi :${adaWifi ? "Ada":"Tidak Ada"}");
      print("jenis  :Bus");

    }
}

//Kelas Pesawat
class Pesawat extends Transportasi {
  String kelas;

  Pesawat(String id, String nama, double tarifDasar, int kapasitas, this.kelas)
  :super(id,nama,tarifDasar,kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang){
    double multiplier = kelas == "Bisnis"?1.5:1.0;
    return tarifDasar * jumlahPenumpang * multiplier;
  }

  @override
  void tampilInfo(){
    super.tampilInfo();
    print("Kelas :$kelas");
    print("Jenis :Pesawat");
  }
}

//Kelas Pemesanan
class Pemesanan{
  String idPemesanan;
  String namaPelanggan;
  Transportasi transportasi;
  int jumlahPenumpang;
  double totalTarif;

  Pemesanan(this.idPemesanan, this.namaPelanggan, this.transportasi, this.jumlahPenumpang, this.totalTarif);

  void cetakStruk(){
    print("\n===Struk Pemesanan ===");
    print("ID Pemesanan :$idPemesanan");
    print("Nama :$namaPelanggan");
    transportasi.tampilInfo();
    print("JumlahPenumpang : $jumlahPenumpang");
    print("Total Tarif :RP${totalTarif.toStringAsFixed(2)}");
  }
  Map<String,dynamic>toMap(){
    return{
      'idPemesanan': idPemesanan,
      'namaPelanggan': namaPelanggan,
      'Transportasi':transportasi.nama,
      'jumlahPenumpang':jumlahPenumpang,
      'totalTarif':totalTarif,
    };
  }
}

//Fungsi Global buatPemesanan
Pemesanan buatPemesanan(Transportasi t,String nama, int jumlahPenumpang, String idPemesanan){
  double total = t.hitungTarif(jumlahPenumpang);
  return Pemesanan(idPemesanan,nama,t,jumlahPenumpang,total);
}

//Fungsi Global tampilSemuaPemesanan
void tampilSemuaPemesanan(List<Pemesanan>daftar){
  print("\n=== Riwayat Semua Pemesanan ===");
  for(var pemesanan in daftar){
    pemesanan.cetakStruk();
  }
}
//Fungsi Main
void main(){
  //Membuat objek Transportasi
  Taksi taksi1 = Taksi("T001", "Taksi BlueBird",5000,4,10);
  Bus bus1 = Bus("B001","Bus TransJakarta",2000,40,true);
  Pesawat pesawat1 = Pesawat("P001","Garuda Indonesia",150000,150,"Bisnis");

  //List untuk menyimpan Pemesanan
  List<Pemesanan>daftarPemesanan = [];

  //Membuat pemesanan
  var p1 = buatPemesanan(taksi1,"Andi",1,"PMS001");
  var p2 = buatPemesanan(bus1, "budi",5,"PMS002");
  var p3 = buatPemesanan(pesawat1,"Citra",2,"PMS003");

  daftarPemesanan.addAll([p1,p2,p3]);

  tampilSemuaPemesanan(daftarPemesanan);
}
