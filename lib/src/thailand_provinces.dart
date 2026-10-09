import 'package:flutter/foundation.dart';

/// A registering province: the Thai name printed under the number.
///
/// Seventy-seven provinces, each by its English name and the name the plates
/// print. Betong, the one district with its own registrar, is not listed.
@immutable
class ThailandProvince {
  const ThailandProvince._(this.id, this.name, this.thai);

  /// Stable identifier, used in spec ids.
  final String id;

  /// English name.
  final String name;

  /// The Thai name on the plate.
  final String thai;

  static const ThailandProvince amnatCharoen = ThailandProvince._(
    'amnat_charoen',
    'Amnat Charoen',
    'อำนาจเจริญ',
  );

  static const ThailandProvince angThong = ThailandProvince._(
    'ang_thong',
    'Ang Thong',
    'อ่างทอง',
  );

  static const ThailandProvince bangkok = ThailandProvince._(
    'bangkok',
    'Bangkok',
    'กรุงเทพมหานคร',
  );

  static const ThailandProvince buengKan = ThailandProvince._(
    'bueng_kan',
    'Bueng Kan',
    'บึงกาฬ',
  );

  static const ThailandProvince buriram = ThailandProvince._(
    'buriram',
    'Buriram',
    'บุรีรัมย์',
  );

  static const ThailandProvince chachoengsao = ThailandProvince._(
    'chachoengsao',
    'Chachoengsao',
    'ฉะเชิงเทรา',
  );

  static const ThailandProvince chaiNat = ThailandProvince._(
    'chai_nat',
    'Chai Nat',
    'ชัยนาท',
  );

  static const ThailandProvince chaiyaphum = ThailandProvince._(
    'chaiyaphum',
    'Chaiyaphum',
    'ชัยภูมิ',
  );

  static const ThailandProvince chanthaburi = ThailandProvince._(
    'chanthaburi',
    'Chanthaburi',
    'จันทบุรี',
  );

  static const ThailandProvince chiangMai = ThailandProvince._(
    'chiang_mai',
    'Chiang Mai',
    'เชียงใหม่',
  );

  static const ThailandProvince chiangRai = ThailandProvince._(
    'chiang_rai',
    'Chiang Rai',
    'เชียงราย',
  );

  static const ThailandProvince chonburi = ThailandProvince._(
    'chonburi',
    'Chonburi',
    'ชลบุรี',
  );

  static const ThailandProvince chumphon = ThailandProvince._(
    'chumphon',
    'Chumphon',
    'ชุมพร',
  );

  static const ThailandProvince kalasin = ThailandProvince._(
    'kalasin',
    'Kalasin',
    'กาฬสินธุ์',
  );

  static const ThailandProvince kamphaengPhet = ThailandProvince._(
    'kamphaeng_phet',
    'Kamphaeng Phet',
    'กำแพงเพชร',
  );

  static const ThailandProvince kanchanaburi = ThailandProvince._(
    'kanchanaburi',
    'Kanchanaburi',
    'กาญจนบุรี',
  );

  static const ThailandProvince khonKaen = ThailandProvince._(
    'khon_kaen',
    'Khon Kaen',
    'ขอนแก่น',
  );

  static const ThailandProvince krabi = ThailandProvince._(
    'krabi',
    'Krabi',
    'กระบี่',
  );

  static const ThailandProvince lampang = ThailandProvince._(
    'lampang',
    'Lampang',
    'ลำปาง',
  );

  static const ThailandProvince lamphun = ThailandProvince._(
    'lamphun',
    'Lamphun',
    'ลำพูน',
  );

  static const ThailandProvince loei = ThailandProvince._(
    'loei',
    'Loei',
    'เลย',
  );

  static const ThailandProvince lopburi = ThailandProvince._(
    'lopburi',
    'Lopburi',
    'ลพบุรี',
  );

  static const ThailandProvince maeHongSon = ThailandProvince._(
    'mae_hong_son',
    'Mae Hong Son',
    'แม่ฮ่องสอน',
  );

  static const ThailandProvince mahaSarakham = ThailandProvince._(
    'maha_sarakham',
    'Maha Sarakham',
    'มหาสารคาม',
  );

  static const ThailandProvince mukdahan = ThailandProvince._(
    'mukdahan',
    'Mukdahan',
    'มุกดาหาร',
  );

  static const ThailandProvince nakhonNayok = ThailandProvince._(
    'nakhon_nayok',
    'Nakhon Nayok',
    'นครนายก',
  );

  static const ThailandProvince nakhonPathom = ThailandProvince._(
    'nakhon_pathom',
    'Nakhon Pathom',
    'นครปฐม',
  );

  static const ThailandProvince nakhonPhanom = ThailandProvince._(
    'nakhon_phanom',
    'Nakhon Phanom',
    'นครพนม',
  );

  static const ThailandProvince nakhonRatchasima = ThailandProvince._(
    'nakhon_ratchasima',
    'Nakhon Ratchasima',
    'นครราชสีมา',
  );

  static const ThailandProvince nakhonSawan = ThailandProvince._(
    'nakhon_sawan',
    'Nakhon Sawan',
    'นครสวรรค์',
  );

  static const ThailandProvince nakhonSiThammarat = ThailandProvince._(
    'nakhon_si_thammarat',
    'Nakhon Si Thammarat',
    'นครศรีธรรมราช',
  );

  static const ThailandProvince nan = ThailandProvince._('nan', 'Nan', 'น่าน');

  static const ThailandProvince narathiwat = ThailandProvince._(
    'narathiwat',
    'Narathiwat',
    'นราธิวาส',
  );

  static const ThailandProvince nongBuaLamphu = ThailandProvince._(
    'nong_bua_lamphu',
    'Nong Bua Lamphu',
    'หนองบัวลำภู',
  );

  static const ThailandProvince nongKhai = ThailandProvince._(
    'nong_khai',
    'Nong Khai',
    'หนองคาย',
  );

  static const ThailandProvince nonthaburi = ThailandProvince._(
    'nonthaburi',
    'Nonthaburi',
    'นนทบุรี',
  );

  static const ThailandProvince pathumThani = ThailandProvince._(
    'pathum_thani',
    'Pathum Thani',
    'ปทุมธานี',
  );

  static const ThailandProvince pattani = ThailandProvince._(
    'pattani',
    'Pattani',
    'ปัตตานี',
  );

  static const ThailandProvince phangNga = ThailandProvince._(
    'phang_nga',
    'Phang Nga',
    'พังงา',
  );

  static const ThailandProvince phatthalung = ThailandProvince._(
    'phatthalung',
    'Phatthalung',
    'พัทลุง',
  );

  static const ThailandProvince phayao = ThailandProvince._(
    'phayao',
    'Phayao',
    'พะเยา',
  );

  static const ThailandProvince phetchabun = ThailandProvince._(
    'phetchabun',
    'Phetchabun',
    'เพชรบูรณ์',
  );

  static const ThailandProvince phetchaburi = ThailandProvince._(
    'phetchaburi',
    'Phetchaburi',
    'เพชรบุรี',
  );

  static const ThailandProvince phichit = ThailandProvince._(
    'phichit',
    'Phichit',
    'พิจิตร',
  );

  static const ThailandProvince phitsanulok = ThailandProvince._(
    'phitsanulok',
    'Phitsanulok',
    'พิษณุโลก',
  );

  static const ThailandProvince ayutthaya = ThailandProvince._(
    'ayutthaya',
    'Phra Nakhon Si Ayutthaya',
    'พระนครศรีอยุธยา',
  );

  static const ThailandProvince phrae = ThailandProvince._(
    'phrae',
    'Phrae',
    'แพร่',
  );

  static const ThailandProvince phuket = ThailandProvince._(
    'phuket',
    'Phuket',
    'ภูเก็ต',
  );

  static const ThailandProvince prachinburi = ThailandProvince._(
    'prachinburi',
    'Prachinburi',
    'ปราจีนบุรี',
  );

  static const ThailandProvince prachuapKhiriKhan = ThailandProvince._(
    'prachuap_khiri_khan',
    'Prachuap Khiri Khan',
    'ประจวบคีรีขันธ์',
  );

  static const ThailandProvince ranong = ThailandProvince._(
    'ranong',
    'Ranong',
    'ระนอง',
  );

  static const ThailandProvince ratchaburi = ThailandProvince._(
    'ratchaburi',
    'Ratchaburi',
    'ราชบุรี',
  );

  static const ThailandProvince rayong = ThailandProvince._(
    'rayong',
    'Rayong',
    'ระยอง',
  );

  static const ThailandProvince roiEt = ThailandProvince._(
    'roi_et',
    'Roi Et',
    'ร้อยเอ็ด',
  );

  static const ThailandProvince saKaeo = ThailandProvince._(
    'sa_kaeo',
    'Sa Kaeo',
    'สระแก้ว',
  );

  static const ThailandProvince sakonNakhon = ThailandProvince._(
    'sakon_nakhon',
    'Sakon Nakhon',
    'สกลนคร',
  );

  static const ThailandProvince samutPrakan = ThailandProvince._(
    'samut_prakan',
    'Samut Prakan',
    'สมุทรปราการ',
  );

  static const ThailandProvince samutSakhon = ThailandProvince._(
    'samut_sakhon',
    'Samut Sakhon',
    'สมุทรสาคร',
  );

  static const ThailandProvince samutSongkhram = ThailandProvince._(
    'samut_songkhram',
    'Samut Songkhram',
    'สมุทรสงคราม',
  );

  static const ThailandProvince saraburi = ThailandProvince._(
    'saraburi',
    'Saraburi',
    'สระบุรี',
  );

  static const ThailandProvince satun = ThailandProvince._(
    'satun',
    'Satun',
    'สตูล',
  );

  static const ThailandProvince singBuri = ThailandProvince._(
    'sing_buri',
    'Sing Buri',
    'สิงห์บุรี',
  );

  static const ThailandProvince sisaket = ThailandProvince._(
    'sisaket',
    'Sisaket',
    'ศรีสะเกษ',
  );

  static const ThailandProvince songkhla = ThailandProvince._(
    'songkhla',
    'Songkhla',
    'สงขลา',
  );

  static const ThailandProvince sukhothai = ThailandProvince._(
    'sukhothai',
    'Sukhothai',
    'สุโขทัย',
  );

  static const ThailandProvince suphanBuri = ThailandProvince._(
    'suphan_buri',
    'Suphan Buri',
    'สุพรรณบุรี',
  );

  static const ThailandProvince suratThani = ThailandProvince._(
    'surat_thani',
    'Surat Thani',
    'สุราษฎร์ธานี',
  );

  static const ThailandProvince surin = ThailandProvince._(
    'surin',
    'Surin',
    'สุรินทร์',
  );

  static const ThailandProvince tak = ThailandProvince._('tak', 'Tak', 'ตาก');

  static const ThailandProvince trang = ThailandProvince._(
    'trang',
    'Trang',
    'ตรัง',
  );

  static const ThailandProvince trat = ThailandProvince._(
    'trat',
    'Trat',
    'ตราด',
  );

  static const ThailandProvince ubonRatchathani = ThailandProvince._(
    'ubon_ratchathani',
    'Ubon Ratchathani',
    'อุบลราชธานี',
  );

  static const ThailandProvince udonThani = ThailandProvince._(
    'udon_thani',
    'Udon Thani',
    'อุดรธานี',
  );

  static const ThailandProvince uthaiThani = ThailandProvince._(
    'uthai_thani',
    'Uthai Thani',
    'อุทัยธานี',
  );

  static const ThailandProvince uttaradit = ThailandProvince._(
    'uttaradit',
    'Uttaradit',
    'อุตรดิตถ์',
  );

  static const ThailandProvince yala = ThailandProvince._(
    'yala',
    'Yala',
    'ยะลา',
  );

  static const ThailandProvince yasothon = ThailandProvince._(
    'yasothon',
    'Yasothon',
    'ยโสธร',
  );

  static const List<ThailandProvince> values = <ThailandProvince>[
    amnatCharoen,
    angThong,
    bangkok,
    buengKan,
    buriram,
    chachoengsao,
    chaiNat,
    chaiyaphum,
    chanthaburi,
    chiangMai,
    chiangRai,
    chonburi,
    chumphon,
    kalasin,
    kamphaengPhet,
    kanchanaburi,
    khonKaen,
    krabi,
    lampang,
    lamphun,
    loei,
    lopburi,
    maeHongSon,
    mahaSarakham,
    mukdahan,
    nakhonNayok,
    nakhonPathom,
    nakhonPhanom,
    nakhonRatchasima,
    nakhonSawan,
    nakhonSiThammarat,
    nan,
    narathiwat,
    nongBuaLamphu,
    nongKhai,
    nonthaburi,
    pathumThani,
    pattani,
    phangNga,
    phatthalung,
    phayao,
    phetchabun,
    phetchaburi,
    phichit,
    phitsanulok,
    ayutthaya,
    phrae,
    phuket,
    prachinburi,
    prachuapKhiriKhan,
    ranong,
    ratchaburi,
    rayong,
    roiEt,
    saKaeo,
    sakonNakhon,
    samutPrakan,
    samutSakhon,
    samutSongkhram,
    saraburi,
    satun,
    singBuri,
    sisaket,
    songkhla,
    sukhothai,
    suphanBuri,
    suratThani,
    surin,
    tak,
    trang,
    trat,
    ubonRatchathani,
    udonThani,
    uthaiThani,
    uttaradit,
    yala,
    yasothon,
  ];
}
