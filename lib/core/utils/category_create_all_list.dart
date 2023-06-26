import 'package:guide_up/core/models/category/category_model.dart';
import 'package:guide_up/repository/category/category_repository.dart';

class CategoryCreateAllList{


  create() async{
/*
    Category main1 = Category();
    main1.setName("Yazılım Geliştirme");
    main1 = await CategoryRepository().add(main1);

    Category webGelistirme = Category();
    webGelistirme.setName("Web Geliştirme");
    webGelistirme.setMainCategory(main1.getId()!);
    webGelistirme = await CategoryRepository().add(webGelistirme);

    Category html = Category();
    html.setName("HTML");
    html.setMainCategory(webGelistirme.getId()!);
    html = await CategoryRepository().add(html);

    Category css = Category();
    css.setName("CSS");
    css.setMainCategory(webGelistirme.getId()!);
    css = await CategoryRepository().add(css);

    Category javascript = Category();
    javascript.setName("JavaScript");
    javascript.setMainCategory(webGelistirme.getId()!);
    javascript = await CategoryRepository().add(javascript);

    Category react = Category();
    react.setName("React");
    react.setMainCategory(webGelistirme.getId()!);
    react = await CategoryRepository().add(react);

    Category nodejs = Category();
    nodejs.setName("Node.js");
    nodejs.setMainCategory(webGelistirme.getId()!);
    nodejs = await CategoryRepository().add(nodejs);

    Category angular = Category();
    angular.setName("Angular");
    angular.setMainCategory(webGelistirme.getId()!);
    angular = await CategoryRepository().add(angular);

    Category nextjs = Category();
    nextjs.setName("Next.js");
    nextjs.setMainCategory(webGelistirme.getId()!);
    nextjs = await CategoryRepository().add(nextjs);

    Category typescript = Category();
    typescript.setName("TypeScript");
    typescript.setMainCategory(webGelistirme.getId()!);
    typescript = await CategoryRepository().add(typescript);

    Category mobilUygulamaGelistirme = Category();
    mobilUygulamaGelistirme.setName("Mobil Uygulama Geliştirme");
    mobilUygulamaGelistirme.setMainCategory(main1.getId()!);
    mobilUygulamaGelistirme = await CategoryRepository().add(mobilUygulamaGelistirme);

    Category android = Category();
    android.setName("Android");
    android.setMainCategory(mobilUygulamaGelistirme.getId()!);
    android = await CategoryRepository().add(android);

    Category ios = Category();
    ios.setName("iOS");
    ios.setMainCategory(mobilUygulamaGelistirme.getId()!);
    ios = await CategoryRepository().add(ios);

    Category flutter = Category();
    flutter.setName("Flutter");
    flutter.setMainCategory(mobilUygulamaGelistirme.getId()!);
    flutter = await CategoryRepository().add(flutter);

    Category reactNative = Category();
    reactNative.setName("React Native");
    reactNative.setMainCategory(mobilUygulamaGelistirme.getId()!);
    reactNative = await CategoryRepository().add(reactNative);

    Category veritabaniYonetimi = Category();
    veritabaniYonetimi.setName("Veritabanı Yönetimi");
    veritabaniYonetimi.setMainCategory(main1.getId()!);
    veritabaniYonetimi = await CategoryRepository().add(veritabaniYonetimi);

    Category sql = Category();
    sql.setName("SQL");
    sql.setMainCategory(veritabaniYonetimi.getId()!);
    sql = await CategoryRepository().add(sql);

    Category mysql = Category();
    mysql.setName("MySQL");
    mysql.setMainCategory(veritabaniYonetimi.getId()!);
    mysql = await CategoryRepository().add(mysql);

    Category postgresql = Category();
    postgresql.setName("PostgreSQL");
    postgresql.setMainCategory(veritabaniYonetimi.getId()!);
    postgresql = await CategoryRepository().add(postgresql);

    Category mongodb = Category();
    mongodb.setName("MongoDB");
    mongodb.setMainCategory(veritabaniYonetimi.getId()!);
    mongodb = await CategoryRepository().add(mongodb);

    Category programlamaDilleri = Category();
    programlamaDilleri.setName("Programlama Dilleri");
    programlamaDilleri.setMainCategory(main1.getId()!);
    programlamaDilleri = await CategoryRepository().add(programlamaDilleri);

    Category python = Category();
    python.setName("Python");
    python.setMainCategory(programlamaDilleri.getId()!);
    python = await CategoryRepository().add(python);

    Category java = Category();
    java.setName("Java");
    java.setMainCategory(programlamaDilleri.getId()!);
    java = await CategoryRepository().add(java);

    Category cSharp = Category();
    cSharp.setName("C#");
    cSharp.setMainCategory(programlamaDilleri.getId()!);
    cSharp = await CategoryRepository().add(cSharp);

    Category ruby = Category();
    ruby.setName("Ruby");
    ruby.setMainCategory(programlamaDilleri.getId()!);
    ruby = await CategoryRepository().add(ruby);

    Category go = Category();
    go.setName("Go");
    go.setMainCategory(programlamaDilleri.getId()!);
    go = await CategoryRepository().add(go);

    Category kotlin = Category();
    kotlin.setName("Kotlin");
    kotlin.setMainCategory(programlamaDilleri.getId()!);
    kotlin = await CategoryRepository().add(kotlin);

    Category veriBilimiVeMakineOgrenimi = Category();
    veriBilimiVeMakineOgrenimi.setName("Veri Bilimi ve Makine Öğrenimi");
    veriBilimiVeMakineOgrenimi.setMainCategory(main1.getId()!);
    veriBilimiVeMakineOgrenimi = await CategoryRepository().add(veriBilimiVeMakineOgrenimi);

    Category veriManipulasyonu = Category();
    veriManipulasyonu.setName("Veri Manipülasyonu");
    veriManipulasyonu.setMainCategory(veriBilimiVeMakineOgrenimi.getId()!);
    veriManipulasyonu = await CategoryRepository().add(veriManipulasyonu);

    Category veriGorsellestirme = Category();
    veriGorsellestirme.setName("Veri Görselleştirme");
    veriGorsellestirme.setMainCategory(veriBilimiVeMakineOgrenimi.getId()!);
    veriGorsellestirme = await CategoryRepository().add(veriGorsellestirme);

    Category makineOgrenmesiAlgoritmalari = Category();
    makineOgrenmesiAlgoritmalari.setName("Makine Öğrenmesi Algoritmaları");
    makineOgrenmesiAlgoritmalari.setMainCategory(veriBilimiVeMakineOgrenimi.getId()!);
    makineOgrenmesiAlgoritmalari = await CategoryRepository().add(makineOgrenmesiAlgoritmalari);

    Category derinOgrenme = Category();
    derinOgrenme.setName("Derin Öğrenme");
    derinOgrenme.setMainCategory(veriBilimiVeMakineOgrenimi.getId()!);
    derinOgrenme = await CategoryRepository().add(derinOgrenme);

    Category yazilimTestVeKaliteGuvencesi = Category();
    yazilimTestVeKaliteGuvencesi.setName("Yazılım Test ve Kalite Güvencesi");
    yazilimTestVeKaliteGuvencesi.setMainCategory(main1.getId()!);
    yazilimTestVeKaliteGuvencesi = await CategoryRepository().add(yazilimTestVeKaliteGuvencesi);

    Category testPlanlamaVeStratejileri = Category();
    testPlanlamaVeStratejileri.setName("Test Planlama ve Stratejileri");
    testPlanlamaVeStratejileri.setMainCategory(yazilimTestVeKaliteGuvencesi.getId()!);
    testPlanlamaVeStratejileri = await CategoryRepository().add(testPlanlamaVeStratejileri);

    Category testOtomasyonu = Category();
    testOtomasyonu.setName("Test Otomasyonu");
    testOtomasyonu.setMainCategory(yazilimTestVeKaliteGuvencesi.getId()!);
    testOtomasyonu = await CategoryRepository().add(testOtomasyonu);

    Category hataAyiklamaVeHataIzleme = Category();
    hataAyiklamaVeHataIzleme.setName("Hata Ayıklama ve Hata İzleme");
    hataAyiklamaVeHataIzleme.setMainCategory(yazilimTestVeKaliteGuvencesi.getId()!);
    hataAyiklamaVeHataIzleme = await CategoryRepository().add(hataAyiklamaVeHataIzleme);

    Category performansTesti = Category();
    performansTesti.setName("Performans Testi");
    performansTesti.setMainCategory(yazilimTestVeKaliteGuvencesi.getId()!);
    performansTesti = await CategoryRepository().add(performansTesti);

    Category devOpsVeBulutBilisim = Category();
    devOpsVeBulutBilisim.setName("DevOps ve Bulut Bilişim");
    devOpsVeBulutBilisim.setMainCategory(main1.getId()!);
    devOpsVeBulutBilisim = await CategoryRepository().add(devOpsVeBulutBilisim);

    Category ciCd = Category();
    ciCd.setName("CI/CD");
    ciCd.setMainCategory(devOpsVeBulutBilisim.getId()!);
    ciCd = await CategoryRepository().add(ciCd);

    Category docker = Category();
    docker.setName("Docker");
    docker.setMainCategory(devOpsVeBulutBilisim.getId()!);
    docker = await CategoryRepository().add(docker);

    Category kubernetes = Category();
    kubernetes.setName("Kubernetes");
    kubernetes.setMainCategory(devOpsVeBulutBilisim.getId()!);
    kubernetes = await CategoryRepository().add(kubernetes);

    Category aws = Category();
    aws.setName("AWS");
    aws.setMainCategory(devOpsVeBulutBilisim.getId()!);
    aws = await CategoryRepository().add(aws);

    Category azure = Category();
    azure.setName("Azure");
    azure.setMainCategory(devOpsVeBulutBilisim.getId()!);
    azure = await CategoryRepository().add(azure);
*/
/*
    Category isletme = new Category();
    isletme.setName("İşletme");
    isletme = await CategoryRepository().add(isletme);

    Category girisimcilik = new Category();
    girisimcilik.setName("Girişimcilik");
    girisimcilik.setMainCategory(isletme.getId()!);
    girisimcilik = await CategoryRepository().add(girisimcilik);

    Category isFikriGelistirme = new Category();
    isFikriGelistirme.setName("İş Fikri Geliştirme");
    isFikriGelistirme.setMainCategory(girisimcilik.getId()!);
    isFikriGelistirme = await CategoryRepository().add(isFikriGelistirme);

    Category isPlaniOlusturma = new Category();
    isPlaniOlusturma.setName("İş Planı Oluşturma");
    isPlaniOlusturma.setMainCategory(girisimcilik.getId()!);
    isPlaniOlusturma = await CategoryRepository().add(isPlaniOlusturma);

    Category pazarArastirmasi = new Category();
    pazarArastirmasi.setName("Pazar Araştırması");
    pazarArastirmasi.setMainCategory(girisimcilik.getId()!);
    pazarArastirmasi = await CategoryRepository().add(pazarArastirmasi);

    Category maliyetAnalizi = new Category();
    maliyetAnalizi.setName("Maliyet Analizi");
    maliyetAnalizi.setMainCategory(girisimcilik.getId()!);
    maliyetAnalizi = await CategoryRepository().add(maliyetAnalizi);

    Category projeYonetimi = new Category();
    projeYonetimi.setName("Proje Yönetimi");
    projeYonetimi.setMainCategory(isletme.getId()!);
    projeYonetimi = await CategoryRepository().add(projeYonetimi);

    Category projePlanlama = new Category();
    projePlanlama.setName("Proje Planlama");
    projePlanlama.setMainCategory(projeYonetimi.getId()!);
    projePlanlama = await CategoryRepository().add(projePlanlama);

    Category kaynakYonetimi = new Category();
    kaynakYonetimi.setName("Kaynak Yönetimi");
    kaynakYonetimi.setMainCategory(projeYonetimi.getId()!);
    kaynakYonetimi = await CategoryRepository().add(kaynakYonetimi);

    Category riskYonetimi = new Category();
    riskYonetimi.setName("Risk Yönetimi");
    riskYonetimi.setMainCategory(projeYonetimi.getId()!);
    riskYonetimi = await CategoryRepository().add(riskYonetimi);

    Category iletisimVeEkipYonetimi = new Category();
    iletisimVeEkipYonetimi.setName("İletişim ve Ekip Yönetimi");
    iletisimVeEkipYonetimi.setMainCategory(projeYonetimi.getId()!);
    iletisimVeEkipYonetimi = await CategoryRepository().add(iletisimVeEkipYonetimi);

    Category isStratejisiVePlanlama = new Category();
    isStratejisiVePlanlama.setName("İş Stratejisi ve Planlama");
    isStratejisiVePlanlama.setMainCategory(isletme.getId()!);
    isStratejisiVePlanlama = await CategoryRepository().add(isStratejisiVePlanlama);

    Category stratejikPlanlamaSureci = new Category();
    stratejikPlanlamaSureci.setName("Stratejik Planlama Süreci");
    stratejikPlanlamaSureci.setMainCategory(isStratejisiVePlanlama.getId()!);
    stratejikPlanlamaSureci = await CategoryRepository().add(stratejikPlanlamaSureci);

    Category rekabetAnalizi = new Category();
    rekabetAnalizi.setName("Rekabet Analizi");
    rekabetAnalizi.setMainCategory(isStratejisiVePlanlama.getId()!);
    rekabetAnalizi = await CategoryRepository().add(rekabetAnalizi);

    Category pazarlamaStratejileri = new Category();
    pazarlamaStratejileri.setName("Pazarlama Stratejileri");
    pazarlamaStratejileri.setMainCategory(isStratejisiVePlanlama.getId()!);
    pazarlamaStratejileri = await CategoryRepository().add(pazarlamaStratejileri);

    Category inovasyonVeBuyumeStratejileri = new Category();
    inovasyonVeBuyumeStratejileri.setName("İnovasyon ve Büyüme Stratejileri");
    inovasyonVeBuyumeStratejileri.setMainCategory(isStratejisiVePlanlama.getId()!);
    inovasyonVeBuyumeStratejileri = await CategoryRepository().add(inovasyonVeBuyumeStratejileri);

    Category isGelistirmeVeBuyume = new Category();
    isGelistirmeVeBuyume.setName("İş Geliştirme ve Büyüme");
    isGelistirmeVeBuyume.setMainCategory(isletme.getId()!);
    isGelistirmeVeBuyume = await CategoryRepository().add(isGelistirmeVeBuyume);

    Category pazarGenisletmeStratejileri = new Category();
    pazarGenisletmeStratejileri.setName("Pazar Genişletme Stratejileri");
    pazarGenisletmeStratejileri.setMainCategory(isGelistirmeVeBuyume.getId()!);
    pazarGenisletmeStratejileri = await CategoryRepository().add(pazarGenisletmeStratejileri);

    Category isOrtakliklariVeIsbirlikleri = new Category();
    isOrtakliklariVeIsbirlikleri.setName("İş Ortaklıkları ve İşbirlikleri");
    isOrtakliklariVeIsbirlikleri.setMainCategory(isGelistirmeVeBuyume.getId()!);
    isOrtakliklariVeIsbirlikleri = await CategoryRepository().add(isOrtakliklariVeIsbirlikleri);

    Category satisVeMusteriIliskileriYonetimi = new Category();
    satisVeMusteriIliskileriYonetimi.setName("Satış ve Müşteri İlişkileri Yönetimi");
    satisVeMusteriIliskileriYonetimi.setMainCategory(isGelistirmeVeBuyume.getId()!);
    satisVeMusteriIliskileriYonetimi = await CategoryRepository().add(satisVeMusteriIliskileriYonetimi);

    Category yeniUrunVeHizmetGelistirme = new Category();
    yeniUrunVeHizmetGelistirme.setName("Yeni Ürün ve Hizmet Geliştirme");
    yeniUrunVeHizmetGelistirme.setMainCategory(isGelistirmeVeBuyume.getId()!);
    yeniUrunVeHizmetGelistirme = await CategoryRepository().add(yeniUrunVeHizmetGelistirme);

    Category liderlikVeYonetimBecerileri = new Category();
    liderlikVeYonetimBecerileri.setName("Liderlik ve Yönetim Becerileri");
    liderlikVeYonetimBecerileri.setMainCategory(isletme.getId()!);
    liderlikVeYonetimBecerileri = await CategoryRepository().add(liderlikVeYonetimBecerileri);

    Category motivasyonVeInsanKaynaklariYonetimi = new Category();
    motivasyonVeInsanKaynaklariYonetimi.setName("Motivasyon ve İnsan Kaynakları Yönetimi");
    motivasyonVeInsanKaynaklariYonetimi.setMainCategory(liderlikVeYonetimBecerileri.getId()!);
    motivasyonVeInsanKaynaklariYonetimi = await CategoryRepository().add(motivasyonVeInsanKaynaklariYonetimi);

    Category kararVermeVeProblemCozme = new Category();
    kararVermeVeProblemCozme.setName("Karar Verme ve Problem Çözme");
    kararVermeVeProblemCozme.setMainCategory(liderlikVeYonetimBecerileri.getId()!);
    kararVermeVeProblemCozme = await CategoryRepository().add(kararVermeVeProblemCozme);

    Category delegasyonVeTakimYonetimi = new Category();
    delegasyonVeTakimYonetimi.setName("Delegasyon ve Takım Yönetimi");
    delegasyonVeTakimYonetimi.setMainCategory(liderlikVeYonetimBecerileri.getId()!);
    delegasyonVeTakimYonetimi = await CategoryRepository().add(delegasyonVeTakimYonetimi);

    Category iletisimVeIsbirligi = new Category();
    iletisimVeIsbirligi.setName("İletişim ve İşbirliği");
    iletisimVeIsbirligi.setMainCategory(liderlikVeYonetimBecerileri.getId()!);
    iletisimVeIsbirligi = await CategoryRepository().add(iletisimVeIsbirligi);

    Category isEtiketiVeInsanKaynaklari = new Category();
    isEtiketiVeInsanKaynaklari.setName("İş Etiketi ve İnsan Kaynakları");
    isEtiketiVeInsanKaynaklari.setMainCategory(isletme.getId()!);
    isEtiketiVeInsanKaynaklari = await CategoryRepository().add(isEtiketiVeInsanKaynaklari);

    Category etikKurallarVeIsAhlaki = new Category();
    etikKurallarVeIsAhlaki.setName("Etik Kurallar ve İş Ahlakı");
    etikKurallarVeIsAhlaki.setMainCategory(isEtiketiVeInsanKaynaklari.getId()!);
    etikKurallarVeIsAhlaki = await CategoryRepository().add(etikKurallarVeIsAhlaki);

    Category calisanIliskileriVeCalismaOrtami = new Category();
    calisanIliskileriVeCalismaOrtami.setName("Çalışan İlişkileri ve Çalışma Ortamı");
    calisanIliskileriVeCalismaOrtami.setMainCategory(isEtiketiVeInsanKaynaklari.getId()!);
    calisanIliskileriVeCalismaOrtami = await CategoryRepository().add(calisanIliskileriVeCalismaOrtami);

    Category iseAlmaVeIseYerlestirme = new Category();
    iseAlmaVeIseYerlestirme.setName("İşe Alma ve İşe Yerleştirme");
    iseAlmaVeIseYerlestirme.setMainCategory(isEtiketiVeInsanKaynaklari.getId()!);
    iseAlmaVeIseYerlestirme = await CategoryRepository().add(iseAlmaVeIseYerlestirme);

    Category performansDegerlendirmeVeKariyerPlanlama = new Category();
    performansDegerlendirmeVeKariyerPlanlama.setName("Performans Değerlendirme ve Kariyer Planlama");
    performansDegerlendirmeVeKariyerPlanlama.setMainCategory(isEtiketiVeInsanKaynaklari.getId()!);
    performansDegerlendirmeVeKariyerPlanlama = await CategoryRepository().add(performansDegerlendirmeVeKariyerPlanlama);

 */

    Category finansVeMuhasebe = Category();
    finansVeMuhasebe.setName("Finans ve Muhasebe");
    finansVeMuhasebe = await CategoryRepository().add(finansVeMuhasebe);

    Category temelFinansPrensipleri = new Category();
    temelFinansPrensipleri.setName("Temel Finans Prensipleri");
    temelFinansPrensipleri.setMainCategory(finansVeMuhasebe.getId()!);
    temelFinansPrensipleri = await CategoryRepository().add(temelFinansPrensipleri);

    Category finansalTablolarinAnalizi = new Category();
    finansalTablolarinAnalizi.setName("Finansal Tabloların Analizi");
    finansalTablolarinAnalizi.setMainCategory(temelFinansPrensipleri.getId()!);
    finansalTablolarinAnalizi = await CategoryRepository().add(finansalTablolarinAnalizi);

    Category nakitAkisiYonetimi = new Category();
    nakitAkisiYonetimi.setName("Nakit Akışı Yönetimi");
    nakitAkisiYonetimi.setMainCategory(temelFinansPrensipleri.getId()!);
    nakitAkisiYonetimi = await CategoryRepository().add(nakitAkisiYonetimi);

    Category karVeZararHesaplamalari = new Category();
    karVeZararHesaplamalari.setName("Kâr ve Zarar Hesaplamaları");
    karVeZararHesaplamalari.setMainCategory(temelFinansPrensipleri.getId()!);
    karVeZararHesaplamalari = await CategoryRepository().add(karVeZararHesaplamalari);

    Category finansalOranlar = new Category();
    finansalOranlar.setName("Finansal Oranlar");
    finansalOranlar.setMainCategory(temelFinansPrensipleri.getId()!);
    finansalOranlar = await CategoryRepository().add(finansalOranlar);

    Category muhasebeVeFinansalRaporlama = new Category();
    muhasebeVeFinansalRaporlama.setName("Muhasebe ve Finansal Raporlama");
    muhasebeVeFinansalRaporlama.setMainCategory(finansVeMuhasebe.getId()!);
    muhasebeVeFinansalRaporlama = await CategoryRepository().add(muhasebeVeFinansalRaporlama);

    Category genelMuhasebeIlkeleri = new Category();
    genelMuhasebeIlkeleri.setName("Genel Muhasebe İlkeleri");
    genelMuhasebeIlkeleri.setMainCategory(muhasebeVeFinansalRaporlama.getId()!);
    genelMuhasebeIlkeleri = await CategoryRepository().add(genelMuhasebeIlkeleri);

    Category gelirTablosuVeBilancoHazirlama = new Category();
    gelirTablosuVeBilancoHazirlama.setName("Gelir Tablosu ve Bilanço Hazırlama");
    gelirTablosuVeBilancoHazirlama.setMainCategory(muhasebeVeFinansalRaporlama.getId()!);
    gelirTablosuVeBilancoHazirlama = await CategoryRepository().add(gelirTablosuVeBilancoHazirlama);

    Category vergiBeyannameleri = new Category();
    vergiBeyannameleri.setName("Vergi Beyannameleri");
    vergiBeyannameleri.setMainCategory(muhasebeVeFinansalRaporlama.getId()!);
    vergiBeyannameleri = await CategoryRepository().add(vergiBeyannameleri);

    Category maliRaporlamaVeAnaliz = new Category();
    maliRaporlamaVeAnaliz.setName("Mali Raporlama ve Analiz");
    maliRaporlamaVeAnaliz.setMainCategory(muhasebeVeFinansalRaporlama.getId()!);
    maliRaporlamaVeAnaliz = await CategoryRepository().add(maliRaporlamaVeAnaliz);

    Category yatirimVePortfoyYonetimi = new Category();
    yatirimVePortfoyYonetimi.setName("Yatırım ve Portföy Yönetimi");
    yatirimVePortfoyYonetimi.setMainCategory(finansVeMuhasebe.getId()!);
    yatirimVePortfoyYonetimi = await CategoryRepository().add(yatirimVePortfoyYonetimi);

    Category temelYatirimPrensipleri = new Category();
    temelYatirimPrensipleri.setName("Temel Yatırım Prensipleri");
    temelYatirimPrensipleri.setMainCategory(yatirimVePortfoyYonetimi.getId()!);
    temelYatirimPrensipleri = await CategoryRepository().add(temelYatirimPrensipleri);

    Category portfoyCesitlendirme = new Category();
    portfoyCesitlendirme.setName("Portföy Çeşitlendirme");
    portfoyCesitlendirme.setMainCategory(yatirimVePortfoyYonetimi.getId()!);
    portfoyCesitlendirme = await CategoryRepository().add(portfoyCesitlendirme);

    Category riskVeGetiriAnalizi = new Category();
    riskVeGetiriAnalizi.setName("Risk ve Getiri Analizi");
    riskVeGetiriAnalizi.setMainCategory(yatirimVePortfoyYonetimi.getId()!);
    riskVeGetiriAnalizi = await CategoryRepository().add(riskVeGetiriAnalizi);

    Category hisseSenetleriVeTahviller = new Category();
    hisseSenetleriVeTahviller.setName("Hisse Senetleri ve Tahviller");
    hisseSenetleriVeTahviller.setMainCategory(yatirimVePortfoyYonetimi.getId()!);
    hisseSenetleriVeTahviller = await CategoryRepository().add(hisseSenetleriVeTahviller);

    Category vergiPlanlamasiVeStratejileri = new Category();
    vergiPlanlamasiVeStratejileri.setName("Vergi Planlaması ve Stratejileri");
    vergiPlanlamasiVeStratejileri.setMainCategory(finansVeMuhasebe.getId()!);
    vergiPlanlamasiVeStratejileri = await CategoryRepository().add(vergiPlanlamasiVeStratejileri);

    Category vergiHukukuVeYasalaraUygunluk = new Category();
    vergiHukukuVeYasalaraUygunluk.setName("Vergi Hukuku ve Yasalara Uygunluk");
    vergiHukukuVeYasalaraUygunluk.setMainCategory(vergiPlanlamasiVeStratejileri.getId()!);
    vergiHukukuVeYasalaraUygunluk = await CategoryRepository().add(vergiHukukuVeYasalaraUygunluk);

    Category vergiTasarrufuVePlanlama = new Category();
    vergiTasarrufuVePlanlama.setName("Vergi Tasarrufu ve Planlama");
    vergiTasarrufuVePlanlama.setMainCategory(vergiPlanlamasiVeStratejileri.getId()!);
    vergiTasarrufuVePlanlama = await CategoryRepository().add(vergiTasarrufuVePlanlama);

    Category isletmeVeBireyselVergilendirme = new Category();
    isletmeVeBireyselVergilendirme.setName("İşletme ve Bireysel Vergilendirme");
    isletmeVeBireyselVergilendirme.setMainCategory(vergiPlanlamasiVeStratejileri.getId()!);
    isletmeVeBireyselVergilendirme = await CategoryRepository().add(isletmeVeBireyselVergilendirme);

    Category vergiIadeleriVeIstisnalar = new Category();
    vergiIadeleriVeIstisnalar.setName("Vergi İadeleri ve İstisnalar");
    vergiIadeleriVeIstisnalar.setMainCategory(vergiPlanlamasiVeStratejileri.getId()!);
    vergiIadeleriVeIstisnalar = await CategoryRepository().add(vergiIadeleriVeIstisnalar);

    Category btVeYazilim = Category();
    btVeYazilim.setName("BT ve Yazılım");
    btVeYazilim = await CategoryRepository().add(btVeYazilim);

    Category agVeSistemYonetimi = new Category();
    agVeSistemYonetimi.setName("Ağ ve Sistem Yönetimi");
    agVeSistemYonetimi.setMainCategory(btVeYazilim.getId()!);
    agVeSistemYonetimi = await CategoryRepository().add(agVeSistemYonetimi);

    Category agKurulumuVeYapilandirma = new Category();
    agKurulumuVeYapilandirma.setName("Ağ Kurulumu ve Yapılandırma");
    agKurulumuVeYapilandirma.setMainCategory(agVeSistemYonetimi.getId()!);
    agKurulumuVeYapilandirma = await CategoryRepository().add(agKurulumuVeYapilandirma);

    Category agGuvenligiVeIzleme = new Category();
    agGuvenligiVeIzleme.setName("Ağ Güvenliği ve İzleme");
    agGuvenligiVeIzleme.setMainCategory(agVeSistemYonetimi.getId()!);
    agGuvenligiVeIzleme = await CategoryRepository().add(agGuvenligiVeIzleme);

    Category sunucuYonetimi = new Category();
    sunucuYonetimi.setName("Sunucu Yönetimi");
    sunucuYonetimi.setMainCategory(agVeSistemYonetimi.getId()!);
    sunucuYonetimi = await CategoryRepository().add(sunucuYonetimi);

    Category yedeklemeVeKurtarma = new Category();
    yedeklemeVeKurtarma.setName("Yedekleme ve Kurtarma");
    yedeklemeVeKurtarma.setMainCategory(agVeSistemYonetimi.getId()!);
    yedeklemeVeKurtarma = await CategoryRepository().add(yedeklemeVeKurtarma);

    Category siberGuvenlik = new Category();
    siberGuvenlik.setName("Siber Güvenlik");
    siberGuvenlik.setMainCategory(btVeYazilim.getId()!);
    siberGuvenlik = await CategoryRepository().add(siberGuvenlik);

    Category guvenlikTehditleriVeSaldirilari = new Category();
    guvenlikTehditleriVeSaldirilari.setName("Güvenlik Tehditleri ve Saldırıları");
    guvenlikTehditleriVeSaldirilari.setMainCategory(siberGuvenlik.getId()!);
    guvenlikTehditleriVeSaldirilari = await CategoryRepository().add(guvenlikTehditleriVeSaldirilari);

    Category guvenlikDuvarlariVeAntivirusYazilimlari = new Category();
    guvenlikDuvarlariVeAntivirusYazilimlari.setName("Güvenlik Duvarları ve Antivirüs Yazılımları");
    guvenlikDuvarlariVeAntivirusYazilimlari.setMainCategory(siberGuvenlik.getId()!);
    guvenlikDuvarlariVeAntivirusYazilimlari = await CategoryRepository().add(guvenlikDuvarlariVeAntivirusYazilimlari);

    Category ethicalHackingVePenetrasyonTestleri = new Category();
    ethicalHackingVePenetrasyonTestleri.setName("Ethical Hacking ve Penetrasyon Testleri");
    ethicalHackingVePenetrasyonTestleri.setMainCategory(siberGuvenlik.getId()!);
    ethicalHackingVePenetrasyonTestleri = await CategoryRepository().add(ethicalHackingVePenetrasyonTestleri);

    Category veriSifrelemeVeIzleme = new Category();
    veriSifrelemeVeIzleme.setName("Veri Şifreleme ve İzleme");
    veriSifrelemeVeIzleme.setMainCategory(siberGuvenlik.getId()!);
    veriSifrelemeVeIzleme = await CategoryRepository().add(veriSifrelemeVeIzleme);

    Category veritabaniYonetimi = new Category();
    veritabaniYonetimi.setName("Veritabanı Yönetimi");
    veritabaniYonetimi.setMainCategory(btVeYazilim.getId()!);
    veritabaniYonetimi = await CategoryRepository().add(veritabaniYonetimi);

    Category veritabaniTasarimiVeModelleri = new Category();
    veritabaniTasarimiVeModelleri.setName("Veritabanı Tasarımı ve Modelleri");
    veritabaniTasarimiVeModelleri.setMainCategory(veritabaniYonetimi.getId()!);
    veritabaniTasarimiVeModelleri = await CategoryRepository().add(veritabaniTasarimiVeModelleri);

    Category sqlSorgulariVeOptimizasyonu = new Category();
    sqlSorgulariVeOptimizasyonu.setName("SQL Sorguları ve Optimizasyonu");
    sqlSorgulariVeOptimizasyonu.setMainCategory(veritabaniYonetimi.getId()!);
    sqlSorgulariVeOptimizasyonu = await CategoryRepository().add(sqlSorgulariVeOptimizasyonu);

    Category veriYedeklemeVeKurtarma = new Category();
    veriYedeklemeVeKurtarma.setName("Veri Yedekleme ve Kurtarma");
    veriYedeklemeVeKurtarma.setMainCategory(veritabaniYonetimi.getId()!);
    veriYedeklemeVeKurtarma = await CategoryRepository().add(veriYedeklemeVeKurtarma);

    Category veritabaniGuvenligiVeIzleme = new Category();
    veritabaniGuvenligiVeIzleme.setName("Veritabanı Güvenliği ve İzleme");
    veritabaniGuvenligiVeIzleme.setMainCategory(veritabaniYonetimi.getId()!);
    veritabaniGuvenligiVeIzleme = await CategoryRepository().add(veritabaniGuvenligiVeIzleme);

    Category yazilimGelistirmeAraclari = new Category();
    yazilimGelistirmeAraclari.setName("Yazılım Geliştirme Araçları");
    yazilimGelistirmeAraclari.setMainCategory(btVeYazilim.getId()!);
    yazilimGelistirmeAraclari = await CategoryRepository().add(yazilimGelistirmeAraclari);

    Category idelerVeKodEditorleri = new Category();
    idelerVeKodEditorleri.setName("IDE'ler ve Kod Editörleri");
    idelerVeKodEditorleri.setMainCategory(yazilimGelistirmeAraclari.getId()!);
    idelerVeKodEditorleri = await CategoryRepository().add(idelerVeKodEditorleri);

    Category debuggingVeProfilingAraclari = new Category();
    debuggingVeProfilingAraclari.setName("Debugging ve Profiling Araçları");
    debuggingVeProfilingAraclari.setMainCategory(yazilimGelistirmeAraclari.getId()!);
    debuggingVeProfilingAraclari = await CategoryRepository().add(debuggingVeProfilingAraclari);

    Category versiyonKontrolSistemleri = new Category();
    versiyonKontrolSistemleri.setName("Versiyon Kontrol Sistemleri");
    versiyonKontrolSistemleri.setMainCategory(yazilimGelistirmeAraclari.getId()!);
    versiyonKontrolSistemleri = await CategoryRepository().add(versiyonKontrolSistemleri);

    Category apiVeSdkKullanimi = new Category();
    apiVeSdkKullanimi.setName("API ve SDK Kullanımı");
    apiVeSdkKullanimi.setMainCategory(yazilimGelistirmeAraclari.getId()!);
    apiVeSdkKullanimi = await CategoryRepository().add(apiVeSdkKullanimi);

    Category veriYedeklemeVeKurtarma2 = new Category();
    veriYedeklemeVeKurtarma2.setName("Veri Yedekleme ve Kurtarma");
    veriYedeklemeVeKurtarma2.setMainCategory(btVeYazilim.getId()!);
    veriYedeklemeVeKurtarma2 = await CategoryRepository().add(veriYedeklemeVeKurtarma2);

    Category yedeklemeStratejileriVePlanlama = new Category();
    yedeklemeStratejileriVePlanlama.setName("Yedekleme Stratejileri ve Planlama");
    yedeklemeStratejileriVePlanlama.setMainCategory(veriYedeklemeVeKurtarma2.getId()!);
    yedeklemeStratejileriVePlanlama = await CategoryRepository().add(yedeklemeStratejileriVePlanlama);

    Category veriKurtarmaVeGeriYuklemeSurecleri = new Category();
    veriKurtarmaVeGeriYuklemeSurecleri.setName("Veri Kurtarma ve Geri Yükleme Süreçleri");
    veriKurtarmaVeGeriYuklemeSurecleri.setMainCategory(veriYedeklemeVeKurtarma2.getId()!);
    veriKurtarmaVeGeriYuklemeSurecleri = await CategoryRepository().add(veriKurtarmaVeGeriYuklemeSurecleri);

    Category felaketKurtarmaVeIsSurekliligi = new Category();
    felaketKurtarmaVeIsSurekliligi.setName("Felaket Kurtarma ve İş Sürekliliği");
    felaketKurtarmaVeIsSurekliligi.setMainCategory(veriYedeklemeVeKurtarma2.getId()!);
    felaketKurtarmaVeIsSurekliligi = await CategoryRepository().add(felaketKurtarmaVeIsSurekliligi);

    Category veriDepolamaVeArsivleme = new Category();
    veriDepolamaVeArsivleme.setName("Veri Depolama ve Arşivleme");
    veriDepolamaVeArsivleme.setMainCategory(veriYedeklemeVeKurtarma2.getId()!);
    veriDepolamaVeArsivleme = await CategoryRepository().add(veriDepolamaVeArsivleme);

    Category agGuvenligiVeSizmaTestleri = new Category();
    agGuvenligiVeSizmaTestleri.setName("Ağ Güvenliği ve Sızma Testleri");
    agGuvenligiVeSizmaTestleri.setMainCategory(btVeYazilim.getId()!);
    agGuvenligiVeSizmaTestleri = await CategoryRepository().add(agGuvenligiVeSizmaTestleri);

    Category sizmaTestiPlanlamaVeUygulama = new Category();
    sizmaTestiPlanlamaVeUygulama.setName("Sızma Testi Planlama ve Uygulama");
    sizmaTestiPlanlamaVeUygulama.setMainCategory(agGuvenligiVeSizmaTestleri.getId()!);
    sizmaTestiPlanlamaVeUygulama = await CategoryRepository().add(sizmaTestiPlanlamaVeUygulama);

    Category zafiyetTaramasiVeAnaliz = new Category();
    zafiyetTaramasiVeAnaliz.setName("Zafiyet Taraması ve Analiz");
    zafiyetTaramasiVeAnaliz.setMainCategory(agGuvenligiVeSizmaTestleri.getId()!);
    zafiyetTaramasiVeAnaliz = await CategoryRepository().add(zafiyetTaramasiVeAnaliz);

    Category agGuvenlikDuvarlariVeIds = new Category();
    agGuvenlikDuvarlariVeIds.setName("Ağ Güvenlik Duvarları ve Intrusion Detection Systems (IDS)");
    agGuvenlikDuvarlariVeIds.setMainCategory(agGuvenligiVeSizmaTestleri.getId()!);
    agGuvenlikDuvarlariVeIds = await CategoryRepository().add(agGuvenlikDuvarlariVeIds);

    Category sizmaTestiRaporlamaVeOneriler = new Category();
    sizmaTestiRaporlamaVeOneriler.setName("Sızma Testi Raporlama ve Öneriler");
    sizmaTestiRaporlamaVeOneriler.setMainCategory(agGuvenligiVeSizmaTestleri.getId()!);
    sizmaTestiRaporlamaVeOneriler = await CategoryRepository().add(sizmaTestiRaporlamaVeOneriler);

///////////////////////////////////////

    Category OfisteVerimlilik = new Category();
    OfisteVerimlilik.setName("Ofiste Verimlilik");
    OfisteVerimlilik = await CategoryRepository().add(OfisteVerimlilik);

    Category microsoftOfficeUygulamalari = new Category();
    microsoftOfficeUygulamalari.setName("Microsoft Office Uygulamaları");
    microsoftOfficeUygulamalari.setMainCategory(OfisteVerimlilik.getId()!);
    microsoftOfficeUygulamalari = await CategoryRepository().add(microsoftOfficeUygulamalari);

    Category word = new Category();
    word.setName("Word");
    word.setMainCategory(microsoftOfficeUygulamalari.getId()!);
    word = await CategoryRepository().add(word);

    Category excel = new Category();
    excel.setName("Excel");
    excel.setMainCategory(microsoftOfficeUygulamalari.getId()!);
    excel = await CategoryRepository().add(excel);

    Category powerpoint = new Category();
    powerpoint.setName("PowerPoint");
    powerpoint.setMainCategory(microsoftOfficeUygulamalari.getId()!);
    powerpoint = await CategoryRepository().add(powerpoint);

    Category outlook = new Category();
    outlook.setName("Outlook");
    outlook.setMainCategory(microsoftOfficeUygulamalari.getId()!);
    outlook = await CategoryRepository().add(outlook);

    Category veriAnaliziVeRaporlama = new Category();
    veriAnaliziVeRaporlama.setName("Veri Analizi ve Raporlama");
    veriAnaliziVeRaporlama.setMainCategory(OfisteVerimlilik.getId()!);
    veriAnaliziVeRaporlama = await CategoryRepository().add(veriAnaliziVeRaporlama);

    Category veriToplamaVeTemizleme = new Category();
    veriToplamaVeTemizleme.setName("Veri Toplama ve Temizleme");
    veriToplamaVeTemizleme.setMainCategory(veriAnaliziVeRaporlama.getId()!);
    veriToplamaVeTemizleme = await CategoryRepository().add(veriToplamaVeTemizleme);

    Category veriAnaliziAraclariVeIstatistikselYontemler = new Category();
    veriAnaliziAraclariVeIstatistikselYontemler.setName("Veri Analizi Araçları ve İstatistiksel Yöntemler");
    veriAnaliziAraclariVeIstatistikselYontemler.setMainCategory(veriAnaliziVeRaporlama.getId()!);
    veriAnaliziAraclariVeIstatistikselYontemler = await CategoryRepository().add(veriAnaliziAraclariVeIstatistikselYontemler);

    Category veriGorsellestirmeVeDashboardOlusturma = new Category();
    veriGorsellestirmeVeDashboardOlusturma.setName("Veri Görselleştirme ve Dashboard Oluşturma");
    veriGorsellestirmeVeDashboardOlusturma.setMainCategory(veriAnaliziVeRaporlama.getId()!);
    veriGorsellestirmeVeDashboardOlusturma = await CategoryRepository().add(veriGorsellestirmeVeDashboardOlusturma);

    Category isSurecleriVeOtomasyonu = new Category();
    isSurecleriVeOtomasyonu.setName("İş Süreçleri ve Otomasyonu");
    isSurecleriVeOtomasyonu.setMainCategory(OfisteVerimlilik.getId()!);
    isSurecleriVeOtomasyonu = await CategoryRepository().add(isSurecleriVeOtomasyonu);

    Category isAkisiAnaliziVeGelistirme = new Category();
    isAkisiAnaliziVeGelistirme.setName("İş Akışı Analizi ve Geliştirme");
    isAkisiAnaliziVeGelistirme.setMainCategory(isSurecleriVeOtomasyonu.getId()!);
    isAkisiAnaliziVeGelistirme = await CategoryRepository().add(isAkisiAnaliziVeGelistirme);

    Category isSurecleriOtomasyonuAraclari = new Category();
    isSurecleriOtomasyonuAraclari.setName("İş Süreçleri Otomasyonu Araçları");
    isSurecleriOtomasyonuAraclari.setMainCategory(isSurecleriVeOtomasyonu.getId()!);
    isSurecleriOtomasyonuAraclari = await CategoryRepository().add(isSurecleriOtomasyonuAraclari);

    Category verimlilikVeIyilestirmeStratejileri = new Category();
    verimlilikVeIyilestirmeStratejileri.setName("Verimlilik ve İyileştirme Stratejileri");
    verimlilikVeIyilestirmeStratejileri.setMainCategory(isSurecleriVeOtomasyonu.getId()!);
    verimlilikVeIyilestirmeStratejileri = await CategoryRepository().add(verimlilikVeIyilestirmeStratejileri);

    Category etkiliIletisimVeSunumBecerileri = new Category();
    etkiliIletisimVeSunumBecerileri.setName("Etkili İletişim ve Sunum Becerileri");
    etkiliIletisimVeSunumBecerileri.setMainCategory(OfisteVerimlilik.getId()!);
    etkiliIletisimVeSunumBecerileri = await CategoryRepository().add(etkiliIletisimVeSunumBecerileri);

    Category iletisimStratejileriVeInsanlarlaEtkilesim = new Category();
    iletisimStratejileriVeInsanlarlaEtkilesim.setName("İletişim Stratejileri ve İnsanlarla Etkileşim");
    iletisimStratejileriVeInsanlarlaEtkilesim.setMainCategory(etkiliIletisimVeSunumBecerileri.getId()!);
    iletisimStratejileriVeInsanlarlaEtkilesim = await CategoryRepository().add(iletisimStratejileriVeInsanlarlaEtkilesim);

    Category sunumHazirlamaVeSunmaTeknikleri = new Category();
    sunumHazirlamaVeSunmaTeknikleri.setName("Sunum Hazırlama ve Sunma Teknikleri");
    sunumHazirlamaVeSunmaTeknikleri.setMainCategory(etkiliIletisimVeSunumBecerileri.getId()!);
    sunumHazirlamaVeSunmaTeknikleri = await CategoryRepository().add(sunumHazirlamaVeSunmaTeknikleri);

    Category toplantiYonetimiVeModerasyon = new Category();
    toplantiYonetimiVeModerasyon.setName("Toplantı Yönetimi ve Moderasyon");
    toplantiYonetimiVeModerasyon.setMainCategory(etkiliIletisimVeSunumBecerileri.getId()!);
    toplantiYonetimiVeModerasyon = await CategoryRepository().add(toplantiYonetimiVeModerasyon);

    Category isYazismalariVeEpostaEtiketi = new Category();
    isYazismalariVeEpostaEtiketi.setName("İş Yazışmaları ve E-posta Etiketi");
    isYazismalariVeEpostaEtiketi.setMainCategory(etkiliIletisimVeSunumBecerileri.getId()!);
    isYazismalariVeEpostaEtiketi = await CategoryRepository().add(isYazismalariVeEpostaEtiketi);

    Category zamanYonetimiVePlanlama = new Category();
    zamanYonetimiVePlanlama.setName("Zaman Yönetimi ve Planlama");
    zamanYonetimiVePlanlama.setMainCategory(OfisteVerimlilik.getId()!);
    zamanYonetimiVePlanlama = await CategoryRepository().add(zamanYonetimiVePlanlama);

    Category gorevYonetimiVeOnceliklendirme = new Category();
    gorevYonetimiVeOnceliklendirme.setName("Görev Yönetimi ve Önceliklendirme");
    gorevYonetimiVeOnceliklendirme.setMainCategory(zamanYonetimiVePlanlama.getId()!);
    gorevYonetimiVeOnceliklendirme = await CategoryRepository().add(gorevYonetimiVeOnceliklendirme);

    Category zamanYonetimiAraclariVeTeknikleri = new Category();
    zamanYonetimiAraclariVeTeknikleri.setName("Zaman Yönetimi Araçları ve Teknikleri");
    zamanYonetimiAraclariVeTeknikleri.setMainCategory(zamanYonetimiVePlanlama.getId()!);
    zamanYonetimiAraclariVeTeknikleri = await CategoryRepository().add(zamanYonetimiAraclariVeTeknikleri);

    Category calismaPlanlariVeTakvimOlusturma = new Category();
    calismaPlanlariVeTakvimOlusturma.setName("Çalışma Planları ve Takvim Oluşturma");
    calismaPlanlariVeTakvimOlusturma.setMainCategory(zamanYonetimiVePlanlama.getId()!);
    calismaPlanlariVeTakvimOlusturma = await CategoryRepository().add(calismaPlanlariVeTakvimOlusturma);

    Category stresYonetimiVeIsBasariDengesi = new Category();
    stresYonetimiVeIsBasariDengesi.setName("Stres Yönetimi ve İş-Başarı Dengesi");
    stresYonetimiVeIsBasariDengesi.setMainCategory(zamanYonetimiVePlanlama.getId()!);
    stresYonetimiVeIsBasariDengesi = await CategoryRepository().add(stresYonetimiVeIsBasariDengesi);


/////////////////////
    Category KisiselGelisim = Category();
    KisiselGelisim.setName("Kişisel Gelişim");
    KisiselGelisim = await CategoryRepository().add(KisiselGelisim);

    Category ozguvenVeMotivasyon = new Category();
    ozguvenVeMotivasyon.setName("Özgüven ve Motivasyon");
    ozguvenVeMotivasyon.setMainCategory(KisiselGelisim.getId()!);
    ozguvenVeMotivasyon = await CategoryRepository().add(ozguvenVeMotivasyon);

    Category kendineGuvanVeOzsaygiGelistirme = new Category();
    kendineGuvanVeOzsaygiGelistirme.setName("Kendine Güven ve Özsaygı Geliştirme");
    kendineGuvanVeOzsaygiGelistirme.setMainCategory(ozguvenVeMotivasyon.getId()!);
    kendineGuvanVeOzsaygiGelistirme = await CategoryRepository().add(kendineGuvanVeOzsaygiGelistirme);

    Category motivasyonelStratejilerVeHedefBelirleme = new Category();
    motivasyonelStratejilerVeHedefBelirleme.setName("Motivasyonel Stratejiler ve Hedef Belirleme");
    motivasyonelStratejilerVeHedefBelirleme.setMainCategory(ozguvenVeMotivasyon.getId()!);
    motivasyonelStratejilerVeHedefBelirleme = await CategoryRepository().add(motivasyonelStratejilerVeHedefBelirleme);

    Category olumluDusunceVeIyimserlik = new Category();
    olumluDusunceVeIyimserlik.setName("Olumlu Düşünce ve İyimserlik");
    olumluDusunceVeIyimserlik.setMainCategory(ozguvenVeMotivasyon.getId()!);
    olumluDusunceVeIyimserlik = await CategoryRepository().add(olumluDusunceVeIyimserlik);

    Category iletisimVeiliskiBecerileri = new Category();
    iletisimVeiliskiBecerileri.setName("İletişim ve İlişki Becerileri");
    iletisimVeiliskiBecerileri.setMainCategory(KisiselGelisim.getId()!);
    iletisimVeiliskiBecerileri = await CategoryRepository().add(iletisimVeiliskiBecerileri);

    Category empatiVeAktifDinleme = new Category();
    empatiVeAktifDinleme.setName("Empati ve Aktif Dinleme");
    empatiVeAktifDinleme.setMainCategory(iletisimVeiliskiBecerileri.getId()!);
    empatiVeAktifDinleme = await CategoryRepository().add(empatiVeAktifDinleme);

    Category sozluVeYaziliIletisimBecerileri = new Category();
    sozluVeYaziliIletisimBecerileri.setName("Sözlü ve Yazılı İletişim Becerileri");
    sozluVeYaziliIletisimBecerileri.setMainCategory(iletisimVeiliskiBecerileri.getId()!);
    sozluVeYaziliIletisimBecerileri = await CategoryRepository().add(sozluVeYaziliIletisimBecerileri);

    Category catismaYonetimiVeIsbirligi = new Category();
    catismaYonetimiVeIsbirligi.setName("Çatışma Yönetimi ve İşbirliği");
    catismaYonetimiVeIsbirligi.setMainCategory(iletisimVeiliskiBecerileri.getId()!);
    catismaYonetimiVeIsbirligi = await CategoryRepository().add(catismaYonetimiVeIsbirligi);

    Category iknaVeEtkilemeSanati = new Category();
    iknaVeEtkilemeSanati.setName("İkna ve Etkileme Sanatı");
    iknaVeEtkilemeSanati.setMainCategory(iletisimVeiliskiBecerileri.getId()!);
    iknaVeEtkilemeSanati = await CategoryRepository().add(iknaVeEtkilemeSanati);

    Category stresYonetimiVeKisiselBakim = new Category();
    stresYonetimiVeKisiselBakim.setName("Stres Yönetimi ve Kişisel Bakım");
    stresYonetimiVeKisiselBakim.setMainCategory(KisiselGelisim.getId()!);
    stresYonetimiVeKisiselBakim = await CategoryRepository().add(stresYonetimiVeKisiselBakim);

    Category stresinTaninmasiVeAzaltilmasi = new Category();
    stresinTaninmasiVeAzaltilmasi.setName("Stresin Tanınması ve Azaltılması");
    stresinTaninmasiVeAzaltilmasi.setMainCategory(stresYonetimiVeKisiselBakim.getId()!);
    stresinTaninmasiVeAzaltilmasi = await CategoryRepository().add(stresinTaninmasiVeAzaltilmasi);

    Category rahatlamaTeknikleriVeMeditasyon = new Category();
    rahatlamaTeknikleriVeMeditasyon.setName("Rahatlama Teknikleri ve Meditasyon");
    rahatlamaTeknikleriVeMeditasyon.setMainCategory(stresYonetimiVeKisiselBakim.getId()!);
    rahatlamaTeknikleriVeMeditasyon = await CategoryRepository().add(rahatlamaTeknikleriVeMeditasyon);

    Category saglikliBeslenmeVeEgzersiz = new Category();
    saglikliBeslenmeVeEgzersiz.setName("Sağlıklı Beslenme ve Egzersiz");
    saglikliBeslenmeVeEgzersiz.setMainCategory(stresYonetimiVeKisiselBakim.getId()!);
    saglikliBeslenmeVeEgzersiz = await CategoryRepository().add(saglikliBeslenmeVeEgzersiz);

    Category kendineBakimVeIyiHissetme = new Category();
    kendineBakimVeIyiHissetme.setName("Kendine Bakım ve İyi Hissetme");
    kendineBakimVeIyiHissetme.setMainCategory(stresYonetimiVeKisiselBakim.getId()!);
    kendineBakimVeIyiHissetme = await CategoryRepository().add(kendineBakimVeIyiHissetme);

    Category hedefBelirlemeVeBasariStratejileri = new Category();
    hedefBelirlemeVeBasariStratejileri.setName("Hedef Belirleme ve Başarı Stratejileri");
    hedefBelirlemeVeBasariStratejileri.setMainCategory(KisiselGelisim.getId()!);
    hedefBelirlemeVeBasariStratejileri = await CategoryRepository().add(hedefBelirlemeVeBasariStratejileri);

    Category hedefAnaliziVeSmartHedefler = new Category();
    hedefAnaliziVeSmartHedefler.setName("Hedef Analizi ve SMART Hedefler");
    hedefAnaliziVeSmartHedefler.setMainCategory(hedefBelirlemeVeBasariStratejileri.getId()!);
    hedefAnaliziVeSmartHedefler = await CategoryRepository().add(hedefAnaliziVeSmartHedefler);

    Category motivasyonVeIlerlemeTakibi = new Category();
    motivasyonVeIlerlemeTakibi.setName("Motivasyon ve İlerleme Takibi");
    motivasyonVeIlerlemeTakibi.setMainCategory(hedefBelirlemeVeBasariStratejileri.getId()!);
    motivasyonVeIlerlemeTakibi = await CategoryRepository().add(motivasyonVeIlerlemeTakibi);

    Category engellerinUstesindenGelme = new Category();
    engellerinUstesindenGelme.setName("Engellerin Üstesinden Gelme");
    engellerinUstesindenGelme.setMainCategory(hedefBelirlemeVeBasariStratejileri.getId()!);
    engellerinUstesindenGelme = await CategoryRepository().add(engellerinUstesindenGelme);

    Category basariOdakliDusunmeVeStratejiler = new Category();
    basariOdakliDusunmeVeStratejiler.setName("Başarı Odaklı Düşünme ve Stratejiler");
    basariOdakliDusunmeVeStratejiler.setMainCategory(hedefBelirlemeVeBasariStratejileri.getId()!);
    basariOdakliDusunmeVeStratejiler = await CategoryRepository().add(basariOdakliDusunmeVeStratejiler);

    Category zihinselVeFizikselSaglik = new Category();
    zihinselVeFizikselSaglik.setName("Zihinsel ve Fiziksel Sağlık");
    zihinselVeFizikselSaglik.setMainCategory(KisiselGelisim.getId()!);
    zihinselVeFizikselSaglik = await CategoryRepository().add(zihinselVeFizikselSaglik);

    Category zihinselSaglikFarkindaligiVeBakimi = new Category();
    zihinselSaglikFarkindaligiVeBakimi.setName("Zihinsel Sağlık Farkındalığı ve Bakımı");
    zihinselSaglikFarkindaligiVeBakimi.setMainCategory(zihinselVeFizikselSaglik.getId()!);
    zihinselSaglikFarkindaligiVeBakimi = await CategoryRepository().add(zihinselSaglikFarkindaligiVeBakimi);

    Category uykuVeDinlenme = new Category();
    uykuVeDinlenme.setName("Uyku ve Dinlenme");
    uykuVeDinlenme.setMainCategory(zihinselVeFizikselSaglik.getId()!);
    uykuVeDinlenme = await CategoryRepository().add(uykuVeDinlenme);

    Category duzenliEgzersizVeSpor = new Category();
    duzenliEgzersizVeSpor.setName("Düzenli Egzersiz ve Spor");
    duzenliEgzersizVeSpor.setMainCategory(zihinselVeFizikselSaglik.getId()!);
    duzenliEgzersizVeSpor = await CategoryRepository().add(duzenliEgzersizVeSpor);

    Category saglikliBeslenmeVeYasamTarzi = new Category();
    saglikliBeslenmeVeYasamTarzi.setName("Sağlıklı Beslenme ve Yaşam Tarzı");
    saglikliBeslenmeVeYasamTarzi.setMainCategory(zihinselVeFizikselSaglik.getId()!);
    saglikliBeslenmeVeYasamTarzi = await CategoryRepository().add(saglikliBeslenmeVeYasamTarzi);

    ///////////////////////////////////////////
    Category Tasarim = Category();
    Tasarim.setName("Tasarım");
    Tasarim = await CategoryRepository().add(Tasarim);

    Category grafikTasarim = new Category();
    grafikTasarim.setName("Grafik Tasarım");
    grafikTasarim.setMainCategory(Tasarim.getId()!);
    grafikTasarim = await CategoryRepository().add(grafikTasarim);

    Category vektorTabanliTasarimProgramlari = new Category();
    vektorTabanliTasarimProgramlari.setName("Vektör Tabanlı Tasarım Programları");
    vektorTabanliTasarimProgramlari.setMainCategory(grafikTasarim.getId()!);
    vektorTabanliTasarimProgramlari = await CategoryRepository().add(vektorTabanliTasarimProgramlari);

    Category grafikTasarimIlkeleriVeKompozisyon = new Category();
    grafikTasarimIlkeleriVeKompozisyon.setName("Grafik Tasarım İlkeleri ve Kompozisyon");
    grafikTasarimIlkeleriVeKompozisyon.setMainCategory(grafikTasarim.getId()!);
    grafikTasarimIlkeleriVeKompozisyon = await CategoryRepository().add(grafikTasarimIlkeleriVeKompozisyon);

    Category tipografiVeRenkKurallari = new Category();
    tipografiVeRenkKurallari.setName("Tipografi ve Renk Kuralları");
    tipografiVeRenkKurallari.setMainCategory(grafikTasarim.getId()!);
    tipografiVeRenkKurallari = await CategoryRepository().add(tipografiVeRenkKurallari);

    Category logoTasarimiVeMarkaKimligi = new Category();
    logoTasarimiVeMarkaKimligi.setName("Logo Tasarımı ve Marka Kimliği");
    logoTasarimiVeMarkaKimligi.setMainCategory(grafikTasarim.getId()!);
    logoTasarimiVeMarkaKimligi = await CategoryRepository().add(logoTasarimiVeMarkaKimligi);

    Category webTasarim = new Category();
    webTasarim.setName("Web Tasarım");
    webTasarim.setMainCategory(Tasarim.getId()!);
    webTasarim = await CategoryRepository().add(webTasarim);

    Category uiVeUxTasarimi = new Category();
    uiVeUxTasarimi.setName("UI ve UX Tasarımı");
    uiVeUxTasarimi.setMainCategory(webTasarim.getId()!);
    uiVeUxTasarimi = await CategoryRepository().add(uiVeUxTasarimi);

    Category webTasarimIlkeleriVeYontemleri = new Category();
    webTasarimIlkeleriVeYontemleri.setName("Web Tasarım İlkeleri ve Yöntemleri");
    webTasarimIlkeleriVeYontemleri.setMainCategory(webTasarim.getId()!);
    webTasarimIlkeleriVeYontemleri = await CategoryRepository().add(webTasarimIlkeleriVeYontemleri);

    Category webTasarimAraclariVeFrameworkler = new Category();
    webTasarimAraclariVeFrameworkler.setName("Web Tasarım Araçları ve Framework'ler");
    webTasarimAraclariVeFrameworkler.setMainCategory(webTasarim.getId()!);
    webTasarimAraclariVeFrameworkler = await CategoryRepository().add(webTasarimAraclariVeFrameworkler);

    Category responsiveTasarimVeMobilUyumluluk = new Category();
    responsiveTasarimVeMobilUyumluluk.setName("Responsive Tasarım ve Mobil Uyumluluk");
    responsiveTasarimVeMobilUyumluluk.setMainCategory(webTasarim.getId()!);
    responsiveTasarimVeMobilUyumluluk = await CategoryRepository().add(responsiveTasarimVeMobilUyumluluk);

    Category uiUxTasarimi = new Category();
    uiUxTasarimi.setName("UI/UX Tasarımı");
    uiUxTasarimi.setMainCategory(Tasarim.getId()!);
    uiUxTasarimi = await CategoryRepository().add(uiUxTasarimi);

    Category kullanicidaneyimiTasarimi = new Category();
    kullanicidaneyimiTasarimi.setName("Kullanıcı Deneyimi Tasarımı");
    kullanicidaneyimiTasarimi.setMainCategory(uiUxTasarimi.getId()!);
    kullanicidaneyimiTasarimi = await CategoryRepository().add(kullanicidaneyimiTasarimi);

    Category kullanicilarayuzuTasarimi = new Category();
    kullanicilarayuzuTasarimi.setName("Kullanıcı Arayüzü Tasarımı");
    kullanicilarayuzuTasarimi.setMainCategory(uiUxTasarimi.getId()!);
    kullanicilarayuzuTasarimi = await CategoryRepository().add(kullanicilarayuzuTasarimi);

    Category prototipOlusturmaVeTestEtme = new Category();
    prototipOlusturmaVeTestEtme.setName("Prototip Oluşturma ve Test Etme");
    prototipOlusturmaVeTestEtme.setMainCategory(uiUxTasarimi.getId()!);
    prototipOlusturmaVeTestEtme = await CategoryRepository().add(prototipOlusturmaVeTestEtme);

    Category interaktifTasarimAraclari = new Category();
    interaktifTasarimAraclari.setName("İnteraktif Tasarım Araçları");
    interaktifTasarimAraclari.setMainCategory(uiUxTasarimi.getId()!);
    interaktifTasarimAraclari = await CategoryRepository().add(interaktifTasarimAraclari);

    Category illustrasyonVeCizim = new Category();
    illustrasyonVeCizim.setName("İllüstrasyon ve Çizim");
    illustrasyonVeCizim.setMainCategory(Tasarim.getId()!);
    illustrasyonVeCizim = await CategoryRepository().add(illustrasyonVeCizim);

    Category dijitalIllustrasyonAraclari = new Category();
    dijitalIllustrasyonAraclari.setName("Dijital İllüstrasyon Araçları");
    dijitalIllustrasyonAraclari.setMainCategory(illustrasyonVeCizim.getId()!);
    dijitalIllustrasyonAraclari = await CategoryRepository().add(dijitalIllustrasyonAraclari);

    Category karakterTasarimiVeCizimTeknikleri = new Category();
    karakterTasarimiVeCizimTeknikleri.setName("Karakter Tasarımı ve Çizim Teknikleri");
    karakterTasarimiVeCizimTeknikleri.setMainCategory(illustrasyonVeCizim.getId()!);
    karakterTasarimiVeCizimTeknikleri = await CategoryRepository().add(karakterTasarimiVeCizimTeknikleri);

    Category cizgiRomanVeCizgiRomanSanati = new Category();
    cizgiRomanVeCizgiRomanSanati.setName("Çizgi Roman ve Çizgi Roman Sanatı");
    cizgiRomanVeCizgiRomanSanati.setMainCategory(illustrasyonVeCizim.getId()!);
    cizgiRomanVeCizgiRomanSanati = await CategoryRepository().add(cizgiRomanVeCizgiRomanSanati);

    Category storyboardOlusturmaVeAnlatim = new Category();
    storyboardOlusturmaVeAnlatim.setName("Storyboard Oluşturma ve Anlatım");
    storyboardOlusturmaVeAnlatim.setMainCategory(illustrasyonVeCizim.getId()!);
    storyboardOlusturmaVeAnlatim = await CategoryRepository().add(storyboardOlusturmaVeAnlatim);

    Category animasyonVeHareketliGrafikler = new Category();
    animasyonVeHareketliGrafikler.setName("Animasyon ve Hareketli Grafikler");
    animasyonVeHareketliGrafikler.setMainCategory(Tasarim.getId()!);
    animasyonVeHareketliGrafikler = await CategoryRepository().add(animasyonVeHareketliGrafikler);

    Category ikiDVeUcDAnimasyonTemelleri = new Category();
    ikiDVeUcDAnimasyonTemelleri.setName("2D ve 3D Animasyon Temelleri");
    ikiDVeUcDAnimasyonTemelleri.setMainCategory(animasyonVeHareketliGrafikler.getId()!);
    ikiDVeUcDAnimasyonTemelleri = await CategoryRepository().add(ikiDVeUcDAnimasyonTemelleri);

    Category animasyonYazilimlariVeAraclari = new Category();
    animasyonYazilimlariVeAraclari.setName("Animasyon Yazılımları ve Araçları");
    animasyonYazilimlariVeAraclari.setMainCategory(animasyonVeHareketliGrafikler.getId()!);
    animasyonYazilimlariVeAraclari = await CategoryRepository().add(animasyonYazilimlariVeAraclari);

    Category karakterAnimasyonuVeYaratma = new Category();
    karakterAnimasyonuVeYaratma.setName("Karakter Animasyonu ve Yaratma");
    karakterAnimasyonuVeYaratma.setMainCategory(animasyonVeHareketliGrafikler.getId()!);
    karakterAnimasyonuVeYaratma = await CategoryRepository().add(karakterAnimasyonuVeYaratma);

    Category hareketliGrafiklerVeEfektler = new Category();
    hareketliGrafiklerVeEfektler.setName("Hareketli Grafikler ve Efektler");
    hareketliGrafiklerVeEfektler.setMainCategory(animasyonVeHareketliGrafikler.getId()!);
    hareketliGrafiklerVeEfektler = await CategoryRepository().add(hareketliGrafiklerVeEfektler);

    Category endustriyelTasarim = new Category();
    endustriyelTasarim.setName("Endüstriyel Tasarım");
    endustriyelTasarim.setMainCategory(Tasarim.getId()!);
    endustriyelTasarim = await CategoryRepository().add(endustriyelTasarim);

    Category urunKonseptTasarimi = new Category();
    urunKonseptTasarimi.setName("Ürün Konsept Tasarımı");
    urunKonseptTasarimi.setMainCategory(endustriyelTasarim.getId()!);
    urunKonseptTasarimi = await CategoryRepository().add(urunKonseptTasarimi);

    Category ucDModellemeVePrototipUretimi = new Category();
    ucDModellemeVePrototipUretimi.setName("3D Modelleme ve Prototip Üretimi");
    ucDModellemeVePrototipUretimi.setMainCategory(endustriyelTasarim.getId()!);
    ucDModellemeVePrototipUretimi = await CategoryRepository().add(ucDModellemeVePrototipUretimi);

    Category malzemeSecimiVeUretilebilirlikAnalizi = new Category();
    malzemeSecimiVeUretilebilirlikAnalizi.setName("Malzeme Seçimi ve Üretilebilirlik Analizi");
    malzemeSecimiVeUretilebilirlikAnalizi.setMainCategory(endustriyelTasarim.getId()!);
    malzemeSecimiVeUretilebilirlikAnalizi = await CategoryRepository().add(malzemeSecimiVeUretilebilirlikAnalizi);

    Category kullanicilarastirmasiVeErgonomi = new Category();
    kullanicilarastirmasiVeErgonomi.setName("Kullanıcı Araştırması ve Ergonomi");
    kullanicilarastirmasiVeErgonomi.setMainCategory(endustriyelTasarim.getId()!);
    kullanicilarastirmasiVeErgonomi = await CategoryRepository().add(kullanicilarastirmasiVeErgonomi);

    Category markaKimligiVeAmbalajTasarimi = new Category();
    markaKimligiVeAmbalajTasarimi.setName("Marka Kimliği ve Ambalaj Tasarımı");
    markaKimligiVeAmbalajTasarimi.setMainCategory(endustriyelTasarim.getId()!);
    markaKimligiVeAmbalajTasarimi = await CategoryRepository().add(markaKimligiVeAmbalajTasarimi);

    Category mimarlik = new Category();
    mimarlik.setName("Mimarlık");
    mimarlik.setMainCategory(Tasarim.getId()!);
    mimarlik = await CategoryRepository().add(mimarlik);

    Category mimariTasarimIlkeleri = new Category();
    mimariTasarimIlkeleri.setName("Mimari Tasarım İlkeleri");
    mimariTasarimIlkeleri.setMainCategory(mimarlik.getId()!);
    mimariTasarimIlkeleri = await CategoryRepository().add(mimariTasarimIlkeleri);

    Category binaPlanlamaVeYerlesimDuzenlemesi = new Category();
    binaPlanlamaVeYerlesimDuzenlemesi.setName("Bina Planlama ve Yerleşim Düzenlemesi");
    binaPlanlamaVeYerlesimDuzenlemesi.setMainCategory(mimarlik.getId()!);
    binaPlanlamaVeYerlesimDuzenlemesi = await CategoryRepository().add(binaPlanlamaVeYerlesimDuzenlemesi);

    Category yapiMalzemeleriVeTeknolojileri = new Category();
    yapiMalzemeleriVeTeknolojileri.setName("Yapı Malzemeleri ve Teknolojileri");
    yapiMalzemeleriVeTeknolojileri.setMainCategory(mimarlik.getId()!);
    yapiMalzemeleriVeTeknolojileri = await CategoryRepository().add(yapiMalzemeleriVeTeknolojileri);

    Category enerjiVerimliligiVeYesilBinalar = new Category();
    enerjiVerimliligiVeYesilBinalar.setName("Enerji Verimliliği ve Yeşil Binalar");
    enerjiVerimliligiVeYesilBinalar.setMainCategory(mimarlik.getId()!);
    enerjiVerimliligiVeYesilBinalar = await CategoryRepository().add(enerjiVerimliligiVeYesilBinalar);

    Category icMekanTasarimiVeDekorasyon = new Category();
    icMekanTasarimiVeDekorasyon.setName("İç Mekan Tasarımı ve Dekorasyon");
    icMekanTasarimiVeDekorasyon.setMainCategory(mimarlik.getId()!);
    icMekanTasarimiVeDekorasyon = await CategoryRepository().add(icMekanTasarimiVeDekorasyon);

    Category icTasarim = new Category();
    icTasarim.setName("İç Tasarım");
    icTasarim.setMainCategory(Tasarim.getId()!);
    icTasarim = await CategoryRepository().add(icTasarim);

    Category icMekanPlanlamaVeYerlesimDuzenlemesi = new Category();
    icMekanPlanlamaVeYerlesimDuzenlemesi.setName("İç Mekan Planlama ve Yerleşim Düzenlemesi");
    icMekanPlanlamaVeYerlesimDuzenlemesi.setMainCategory(icTasarim.getId()!);
    icMekanPlanlamaVeYerlesimDuzenlemesi = await CategoryRepository().add(icMekanPlanlamaVeYerlesimDuzenlemesi);

    Category renkVeAydinlatmaTasarimi = new Category();
    renkVeAydinlatmaTasarimi.setName("Renk ve Aydınlatma Tasarımı");
    renkVeAydinlatmaTasarimi.setMainCategory(icTasarim.getId()!);
    renkVeAydinlatmaTasarimi = await CategoryRepository().add(renkVeAydinlatmaTasarimi);

    Category mobilyaVeAksesuarSecimi = new Category();
    mobilyaVeAksesuarSecimi.setName("Mobilya ve Aksesuar Seçimi");
    mobilyaVeAksesuarSecimi.setMainCategory(icTasarim.getId()!);
    mobilyaVeAksesuarSecimi = await CategoryRepository().add(mobilyaVeAksesuarSecimi);

    Category yuzeyKaplamalariVeMalzemeSecimi = new Category();
    yuzeyKaplamalariVeMalzemeSecimi.setName("Yüzey Kaplamaları ve Malzeme Seçimi");
    yuzeyKaplamalariVeMalzemeSecimi.setMainCategory(icTasarim.getId()!);
    yuzeyKaplamalariVeMalzemeSecimi = await CategoryRepository().add(yuzeyKaplamalariVeMalzemeSecimi);

    Category konseptGelistirmeVeGorsellestirme = new Category();
    konseptGelistirmeVeGorsellestirme.setName("Konsept Geliştirme ve Görselleştirme");
    konseptGelistirmeVeGorsellestirme.setMainCategory(icTasarim.getId()!);
    konseptGelistirmeVeGorsellestirme = await CategoryRepository().add(konseptGelistirmeVeGorsellestirme);
//////////////////////////////////////////////

    Category pazarlama = Category();
    pazarlama.setName("Pazarlama");
    pazarlama = await CategoryRepository().add(pazarlama);

    Category dijitalPazarlama = new Category();
    dijitalPazarlama.setName("Dijital Pazarlama");
    dijitalPazarlama.setMainCategory(pazarlama.getId()!);
    dijitalPazarlama = await CategoryRepository().add(dijitalPazarlama);

    Category seo = new Category();
    seo.setName("SEO (Arama Motoru Optimizasyonu)");
    seo.setMainCategory(dijitalPazarlama.getId()!);
    seo = await CategoryRepository().add(seo);

    Category sem = new Category();
    sem.setName("SEM (Arama Motoru Pazarlaması)");
    sem.setMainCategory(dijitalPazarlama.getId()!);
    sem = await CategoryRepository().add(sem);

    Category epostaPazarlamasi = new Category();
    epostaPazarlamasi.setName("E-posta Pazarlaması");
    epostaPazarlamasi.setMainCategory(dijitalPazarlama.getId()!);
    epostaPazarlamasi = await CategoryRepository().add(epostaPazarlamasi);

    Category icerikPazarlamasi = new Category();
    icerikPazarlamasi.setName("İçerik Pazarlaması");
    icerikPazarlamasi.setMainCategory(dijitalPazarlama.getId()!);
    icerikPazarlamasi = await CategoryRepository().add(icerikPazarlamasi);

    Category eticaretPazarlamasi = new Category();
    eticaretPazarlamasi.setName("E-ticaret Pazarlaması");
    eticaretPazarlamasi.setMainCategory(dijitalPazarlama.getId()!);
    eticaretPazarlamasi = await CategoryRepository().add(eticaretPazarlamasi);

    Category sosyalMedyaPazarlamasi = new Category();
    sosyalMedyaPazarlamasi.setName("Sosyal Medya Pazarlaması");
    sosyalMedyaPazarlamasi.setMainCategory(pazarlama.getId()!);
    sosyalMedyaPazarlamasi = await CategoryRepository().add(sosyalMedyaPazarlamasi);

    Category facebookPazarlamasi = new Category();
    facebookPazarlamasi.setName("Facebook Pazarlaması");
    facebookPazarlamasi.setMainCategory(sosyalMedyaPazarlamasi.getId()!);
    facebookPazarlamasi = await CategoryRepository().add(facebookPazarlamasi);

    Category instagramPazarlamasi = new Category();
    instagramPazarlamasi.setName("Instagram Pazarlaması");
    instagramPazarlamasi.setMainCategory(sosyalMedyaPazarlamasi.getId()!);
    instagramPazarlamasi = await CategoryRepository().add(instagramPazarlamasi);

    Category twitterPazarlamasi = new Category();
    twitterPazarlamasi.setName("Twitter Pazarlaması");
    twitterPazarlamasi.setMainCategory(sosyalMedyaPazarlamasi.getId()!);
    twitterPazarlamasi = await CategoryRepository().add(twitterPazarlamasi);

    Category linkedInPazarlamasi = new Category();
    linkedInPazarlamasi.setName("LinkedIn Pazarlaması");
    linkedInPazarlamasi.setMainCategory(sosyalMedyaPazarlamasi.getId()!);
    linkedInPazarlamasi = await CategoryRepository().add(linkedInPazarlamasi);

    Category youtubePazarlamasi = new Category();
    youtubePazarlamasi.setName("YouTube Pazarlaması");
    youtubePazarlamasi.setMainCategory(sosyalMedyaPazarlamasi.getId()!);
    youtubePazarlamasi = await CategoryRepository().add(youtubePazarlamasi);

    Category internetReklamciligi = new Category();
    internetReklamciligi.setName("İnternet Reklamcılığı");
    internetReklamciligi.setMainCategory(pazarlama.getId()!);
    internetReklamciligi = await CategoryRepository().add(internetReklamciligi);

    Category googleAds = new Category();
    googleAds.setName("Google Ads");
    googleAds.setMainCategory(internetReklamciligi.getId()!);
    googleAds = await CategoryRepository().add(googleAds);

    Category bannerReklamlari = new Category();
    bannerReklamlari.setName("Banner Reklamları");
    bannerReklamlari.setMainCategory(internetReklamciligi.getId()!);
    bannerReklamlari = await CategoryRepository().add(bannerReklamlari);

    Category ppcReklamlari = new Category();
    ppcReklamlari.setName("PPC (Tıklama Başına Ödeme) Reklamları");
    ppcReklamlari.setMainCategory(internetReklamciligi.getId()!);
    ppcReklamlari = await CategoryRepository().add(ppcReklamlari);

    Category affiliateMarketing = new Category();
    affiliateMarketing.setName("Affiliate Marketing");
    affiliateMarketing.setMainCategory(internetReklamciligi.getId()!);
    affiliateMarketing = await CategoryRepository().add(affiliateMarketing);

    Category nativeAdvertising = new Category();
    nativeAdvertising.setName("Native Advertising");
    nativeAdvertising.setMainCategory(internetReklamciligi.getId()!);
    nativeAdvertising = await CategoryRepository().add(nativeAdvertising);

    Category markaYonetimi = new Category();
    markaYonetimi.setName("Marka Yönetimi");
    markaYonetimi.setMainCategory(pazarlama.getId()!);
    markaYonetimi = await CategoryRepository().add(markaYonetimi);

    Category markaStratejisi = new Category();
    markaStratejisi.setName("Marka Stratejisi");
    markaStratejisi.setMainCategory(markaYonetimi.getId()!);
    markaStratejisi = await CategoryRepository().add(markaStratejisi);

    Category markaKimligiVeLogoTasarimi = new Category();
    markaKimligiVeLogoTasarimi.setName("Marka Kimliği ve Logo Tasarımı");
    markaKimligiVeLogoTasarimi.setMainCategory(markaYonetimi.getId()!);
    markaKimligiVeLogoTasarimi = await CategoryRepository().add(markaKimligiVeLogoTasarimi);

    Category markaIletisimi = new Category();
    markaIletisimi.setName("Marka İletişimi");
    markaIletisimi.setMainCategory(markaYonetimi.getId()!);
    markaIletisimi = await CategoryRepository().add(markaIletisimi);

    Category krizYonetimi = new Category();
    krizYonetimi.setName("Kriz Yönetimi");
    krizYonetimi.setMainCategory(markaYonetimi.getId()!);
    krizYonetimi = await CategoryRepository().add(krizYonetimi);

    Category musteriDeneyimiYonetimi = new Category();
    musteriDeneyimiYonetimi.setName("Müşteri Deneyimi Yönetimi");
    musteriDeneyimiYonetimi.setMainCategory(markaYonetimi.getId()!);
    musteriDeneyimiYonetimi = await CategoryRepository().add(musteriDeneyimiYonetimi);

    Category pazarlamaStratejileri = new Category();
    pazarlamaStratejileri.setName("Pazarlama Stratejileri");
    pazarlamaStratejileri.setMainCategory(pazarlama.getId()!);
    pazarlamaStratejileri = await CategoryRepository().add(pazarlamaStratejileri);

    Category hedefPazarBelirleme = new Category();
    hedefPazarBelirleme.setName("Hedef Pazar Belirleme");
    hedefPazarBelirleme.setMainCategory(pazarlamaStratejileri.getId()!);
    hedefPazarBelirleme = await CategoryRepository().add(hedefPazarBelirleme);

    Category segmentasyonVeKonumlandirma = new Category();
    segmentasyonVeKonumlandirma.setName("Segmentasyon ve Konumlandırma");
    segmentasyonVeKonumlandirma.setMainCategory(pazarlamaStratejileri.getId()!);
    segmentasyonVeKonumlandirma = await CategoryRepository().add(segmentasyonVeKonumlandirma);

    Category rekabetAnalizi = new Category();
    rekabetAnalizi.setName("Rekabet Analizi");
    rekabetAnalizi.setMainCategory(pazarlamaStratejileri.getId()!);
    rekabetAnalizi = await CategoryRepository().add(rekabetAnalizi);

    Category fiyatlandirmaStratejileri = new Category();
    fiyatlandirmaStratejileri.setName("Fiyatlandırma Stratejileri");
    fiyatlandirmaStratejileri.setMainCategory(pazarlamaStratejileri.getId()!);
    fiyatlandirmaStratejileri = await CategoryRepository().add(fiyatlandirmaStratejileri);

    Category dagitimKanallariVeLojistik = new Category();
    dagitimKanallariVeLojistik.setName("Dağıtım Kanalları ve Lojistik");
    dagitimKanallariVeLojistik.setMainCategory(pazarlamaStratejileri.getId()!);
    dagitimKanallariVeLojistik = await CategoryRepository().add(dagitimKanallariVeLojistik);

    Category pazarArastirmasiVeAnalizi = new Category();
    pazarArastirmasiVeAnalizi.setName("Pazar Araştırması ve Analizi");
    pazarArastirmasiVeAnalizi.setMainCategory(pazarlama.getId()!);
    pazarArastirmasiVeAnalizi = await CategoryRepository().add(pazarArastirmasiVeAnalizi);

    Category veriToplamaVeAnalizYontemleri = new Category();
    veriToplamaVeAnalizYontemleri.setName("Veri Toplama ve Analiz Yöntemleri");
    veriToplamaVeAnalizYontemleri.setMainCategory(pazarArastirmasiVeAnalizi.getId()!);
    veriToplamaVeAnalizYontemleri = await CategoryRepository().add(veriToplamaVeAnalizYontemleri);

    Category pazarTrendleriVeTalepAnalizi = new Category();
    pazarTrendleriVeTalepAnalizi.setName("Pazar Trendleri ve Talep Analizi");
    pazarTrendleriVeTalepAnalizi.setMainCategory(pazarArastirmasiVeAnalizi.getId()!);
    pazarTrendleriVeTalepAnalizi = await CategoryRepository().add(pazarTrendleriVeTalepAnalizi);

    Category musteriProfilAnalizi = new Category();
    musteriProfilAnalizi.setName("Müşteri Profil Analizi");
    musteriProfilAnalizi.setMainCategory(pazarArastirmasiVeAnalizi.getId()!);
    musteriProfilAnalizi = await CategoryRepository().add(musteriProfilAnalizi);

    Category swotAnalizi = new Category();
    swotAnalizi.setName("SWOT Analizi");
    swotAnalizi.setMainCategory(pazarArastirmasiVeAnalizi.getId()!);
    swotAnalizi = await CategoryRepository().add(swotAnalizi);

    Category pazarlamaStratejilerininDegerlendirilmesi = new Category();
    pazarlamaStratejilerininDegerlendirilmesi.setName("Pazarlama Stratejilerinin Değerlendirilmesi");
    pazarlamaStratejilerininDegerlendirilmesi.setMainCategory(pazarArastirmasiVeAnalizi.getId()!);
    pazarlamaStratejilerininDegerlendirilmesi = await CategoryRepository().add(pazarlamaStratejilerininDegerlendirilmesi);
////////////////////////////////////////////////////////
    Category main9 = Category();
    main9.setName("Yaşam Tarzı");
    main9 = await CategoryRepository().add(main9);
/*
    Category main10 = Category();
    main10.setName("Proje Yönetimi");
    main10 = await CategoryRepository().add(main10);

    Category main11 = Category();
    main11.setName("İnsan Kaynakları");
    main11 = await CategoryRepository().add(main11);

    Category main12 = Category();
    main12.setName("Satış");
    main12 = await CategoryRepository().add(main12);

    Category main13 = Category();
    main13.setName("E-ticaret");
    main13 = await CategoryRepository().add(main13);

    Category main14 = Category();
    main14.setName("Veritabanı Yönetimi");
    main14 = await CategoryRepository().add(main14);

    Category main15 = Category();
    main15.setName("Mobil Uygulama Geliştirme");
    main15 = await CategoryRepository().add(main15);

    Category main16 = Category();
    main16.setName("Veri Analitiği");
    main16 = await CategoryRepository().add(main16);

    Category main17 = Category();
    main17.setName("Bulut Bilişim");
    main17 = await CategoryRepository().add(main17);

    Category main18 = Category();
    main18.setName("Web Tasarımı");
    main18 = await CategoryRepository().add(main18);

    Category main19 = Category();
    main19.setName("Yaratıcı Yazma");
    main19 = await CategoryRepository().add(main19);

    Category main20 = Category();
    main20.setName("Dijital Pazarlama");
    main20 = await CategoryRepository().add(main20);*/

  }
}