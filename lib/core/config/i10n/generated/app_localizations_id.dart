// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get network => 'Jaringan';

  @override
  String get flights => 'Penerbangan';

  @override
  String get controllers => 'Pengontrol';

  @override
  String get observers => 'Pengamat';

  @override
  String get home => 'Beranda';

  @override
  String get map => 'Peta';

  @override
  String get menu => 'Menu';

  @override
  String get altitude => 'Ketinggian';

  @override
  String get speed => 'Kecepatan';

  @override
  String get heading => 'Menuju';

  @override
  String get totalDistance => 'Jarak Total';

  @override
  String get distanceTravelled => 'Jarak Yang Telah Di Tempuh';

  @override
  String get distanceRemaining => 'Jarak Tersisa';

  @override
  String get timeToDestination => 'Waktu Menuju Tujuan';

  @override
  String get etaLocal => 'Perkiraan Waktu Ketibaan';

  @override
  String get etaZulu => 'ETA Zulu';

  @override
  String get country => 'Negara';

  @override
  String get name => 'Nama';

  @override
  String get callsign => 'Kode Panggilan';

  @override
  String get airlineDetails => 'Detail Maskapai';

  @override
  String get flightDetails => 'Informasi Penerbangan';

  @override
  String captain(Object name) {
    return 'Kapten $name';
  }

  @override
  String get aircraft => 'Pesawat';

  @override
  String get company => 'Perusahaan';

  @override
  String get arrived => 'Telah Tiba';

  @override
  String get enRoute => 'Dalam Perjalanan';

  @override
  String get approaching => 'Sedang Mendekati';

  @override
  String get circuits => 'Circuits';

  @override
  String get virtualAirline => 'Virtual Airline';

  @override
  String get flag => 'Bendera';

  @override
  String get region => 'Wilayah';

  @override
  String get clearance => 'Ijin';

  @override
  String get boarding => 'Menaiki Pesawat';

  @override
  String get departing => 'Berangkat';

  @override
  String get arrivingShortly => 'Segera Tiba';

  @override
  String get unknown => 'Tidak Diketahui';

  @override
  String get notAvailable => 'Tidak Tersedia';

  @override
  String get noOFP => 'Tidak Ada Rencana Penerbangan';

  @override
  String get waitingOFP => 'Menunggu Rencana Penerbangan';

  @override
  String get unknownAircraft => 'Pesawat Tidak Diketahui';

  @override
  String get noFlightDetails =>
      'Tidak Dapat Memuat Informasi Penerbangan. Coba Lagi Nanti';

  @override
  String get flightDisconnected =>
      'Penerbangan Ini Telah Terputus Dari Jaringan ';

  @override
  String get errorFlightLoad =>
      'Ada kesalahan dalam mendapatkan informasi penerbangan. Silahkan lihat penerbangan lainnya atau coba lagi nanti. Kami mohon maaf atas ketidak nyamannya.';

  @override
  String get airportSearch => 'Pencarian Airport';

  @override
  String get vatsimEvents => 'Acara VATSIM';

  @override
  String get settings => 'Pengaturan';

  @override
  String get atcNetwork => 'Jaringan ATC';

  @override
  String get language => 'Bahasa';

  @override
  String get aboutApp =>
      'Sim Flight Tracker adalah sebuah aplikasi pelacakan pesawat yang sedang terbang di jaringan VATSIM dan ICAO. Aplikasi ini menggunakan data umum yang tersedia dari VATSIM dan dari ICAO.';

  @override
  String get appDisclaimer =>
      'Semua produk pihak ketiga, nama perusahaan dan logo merek dagang™ atau merek dagang terdaftar® adalah tetap merupakan properti pemiliknya. Menggunakannya tidak berarti berafiliasi dan atau mendapat dukungan dari mereka.';

  @override
  String get loaderText => 'Memuat Informasi';

  @override
  String get searchATC => 'Cari Dengan Kode Area atau ICAO Bandara';

  @override
  String get noControllers =>
      'Tidak Ada ATC Ditemukan Berdasarkan Pencarianmu, Silahkan Coba lagi';

  @override
  String get searchAirports => 'Cari Airport Dengan Nama Atau ICAO';

  @override
  String get airportsInfo =>
      'Cari Dan Temukan Informasi Mengenai Bandara Di Seluruh Dunia';

  @override
  String get oops => 'Oops! Ada Kesalahan. Coba Lagi Nanti';

  @override
  String get noFlightsQuery =>
      'Tidak Ada Penerbangan Ditemukan Berdasarkan Pencarianmu. Silahkan Coba Lagi';

  @override
  String get searchWithFlightNumber => 'Cari Dengan Nomor Penerbangan';

  @override
  String get onlineControllers => 'Online ATC';

  @override
  String get identification => 'Identifikasi';

  @override
  String get surface => 'Permukaan';

  @override
  String get hasLights => 'Has lights?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get viewDetails => 'Melihat Detail';

  @override
  String get elevation => 'Ketinggian';

  @override
  String get lostInternetConnection =>
      'Internet Terputus. Silahkan Sambungkan Kembali';

  @override
  String get hasNotStarted => 'Belum Mulai';

  @override
  String get startingNow => 'Memulai Sekarang';

  @override
  String get inProgress => 'Dalam Proses';

  @override
  String get endingNow => 'Berakhir Sekarang';

  @override
  String get hasEnded => 'Telah Selesai';

  @override
  String get tapToExit => 'Tekan Lagi Untuk Keluar';

  @override
  String get variable => 'Variabel';

  @override
  String get noMetar => 'Tidak Ada Informasi METAR Tersedia';

  @override
  String get windCalm => 'Angin Redah';

  @override
  String get goBack => 'Kembali';

  @override
  String get noEvents => 'Tidak Ada Acara Ditemukan';

  @override
  String get noEventsPlanned => 'Tidak Ada Acara Untuk Hari Ini';

  @override
  String get dateType => 'Jenis Tanggal/Waktu';

  @override
  String get hourLetter => 'J';

  @override
  String get minuteShort => 'menit';

  @override
  String get local => 'Lokal';

  @override
  String timeSelection(Object type) {
    return 'Waktu dan tangga adalah waktu $type';
  }

  @override
  String get delivery => 'Pengiriman';

  @override
  String get ground => 'Darat';

  @override
  String get tower => 'Menara';

  @override
  String get approach => 'Mendekati';

  @override
  String get center => 'Tengah';

  @override
  String get atcFull => 'Pengontrol lalu lintas udara';

  @override
  String get flyingNoOfp => 'Terbang tanpa rencana penerbangan yang valid.';

  @override
  String get shareEvent => 'Bagikan Acara';

  @override
  String get partakingAirports => 'Mengambil Bagian';

  @override
  String get endTime => 'Akhir Waktu';

  @override
  String get startTime => 'Waktu Mulaia';

  @override
  String get organizer => 'Penyelenggara';

  @override
  String get eventDetails => 'Detail Acara';

  @override
  String get eventReminderRemoved => 'Pengingat acara telah dihapus.';

  @override
  String get eventReminderSet => 'Pengingat acara telah ditambahkan.';

  @override
  String get eventAdd => 'Tambahkan pengingat';

  @override
  String get eventRemove => 'Hapus pengingat';

  @override
  String get minutes => 'Menit';

  @override
  String get hours => 'jam';

  @override
  String get watchAd => 'Menonton Iklan';

  @override
  String get flightsLog => 'Profil VATSIM';

  @override
  String get flightInProgress => 'Penerbangan Sedang Berlangsung';

  @override
  String get noFlightHistory =>
      'Tidak ada riwayat. Silakan periksa ID Vatsim Anda di pengaturan aplikasi';

  @override
  String get helipad => 'Helipad';

  @override
  String get runways => 'Landasan Pacu';

  @override
  String get vatsimId => 'ID Vatsim';

  @override
  String get about => 'Tentang';

  @override
  String get latestHundredFlights => 'Profil dan penerbangan VATSIM';

  @override
  String get searchAirportInformation => 'Cari informasi bandara dan METAR';

  @override
  String get vatsimEventsDescription =>
      'Acara saat ini dan yang akan datang di Vatsim';

  @override
  String get settingsDescription => 'Preferensi dan kontribusi';

  @override
  String get aboutAppDescription => 'Informasi tentang aplikasi dan pengembang';

  @override
  String get totalFlightCount => 'Total penerbangan';

  @override
  String get viewMore => 'Lagi';

  @override
  String get events => 'Acara';

  @override
  String get supportApp =>
      'Suka aplikasi ini ? Bantu kami terus berkembang dengan membuat kontribusi! Bantuanmu sangat berarti. Sementara Anda disini, kami mengapresiasi jika Anda dapat mengambil waktu sebentar untuk menilai kami di Google Play atau Apps Store. Terima kasih!';

  @override
  String get donatePaypal => 'Belikan saya kopi';

  @override
  String get pilotHours => 'Keseluruhan Jam Terbang';

  @override
  String get atcHours => 'Jam pengontrol keseluruhan';

  @override
  String get supHours => 'Jam Pengawas Keseluruhan';

  @override
  String get generalSettings => 'Pengaturan umum';

  @override
  String get vatsimSettings => 'Pengaturan VATSIM';

  @override
  String get supportTheApp => 'Dukung aplikasinya';

  @override
  String get cruiseAltitude => 'Ketinggian Jelajah';

  @override
  String get cruiseSpeed => 'Kecepatan Pesawat';

  @override
  String get navbarStyle => 'Gaya bilah navigasi';

  @override
  String get loginWithVatsim => 'Masuk dengan akun VATSIM Anda';

  @override
  String get loginWithVatsimLabel =>
      'Lihat detail profil, riwayat penerbangan, dan lainnya';

  @override
  String get authWithVatsim => 'Masuk dengan VATSIM';

  @override
  String get logout => 'Keluar';

  @override
  String get configLoadFail =>
      'Tidak dapat memuat konfigurasi aplikasi. Silakan mulai ulang aplikasinya.';

  @override
  String get screenNotFound => 'Layar yang Anda cari tidak ada.';
}
