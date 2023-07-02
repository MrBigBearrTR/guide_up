import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../ui/material/custom_material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hakkımızda'),
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Guide UP Hakkında',
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Guide UP, mentorluk hizmetleri sunan bir platformdur. '
                    'Amacımız, insanların yeteneklerini geliştirmelerine yardımcı olmak ve '
                    'birbirleriyle bilgi ve deneyim paylaşımını sağlamaktır. '
                    'Guide UP ile kullanıcılar, deneyimli mentörlerle iletişim kurabilir, '
                    'rehberlik alabilir ve hedeflerine ulaşmak için gerekli kaynaklara erişebilir.',
                style: GoogleFonts.nunito(),
              ),
              const SizedBox(height: 16),
              Text(
                'Misyonumuz',
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Misyonumuz, insanların potansiyellerini keşfetmelerine yardımcı olmak '
                    've yeteneklerini geliştirerek hedeflerine ulaşmalarını sağlamaktır. '
                    'Mentorluk ve rehberlik aracılığıyla kullanıcılara ilham vermek, '
                    'bilgi ve deneyim paylaşımını teşvik etmek ve başarıya giden yolculuklarında '
                    'yanlarında olmak en önemli hedeflerimizdendir.',
                style: GoogleFonts.nunito(),
              ),
              const SizedBox(height: 16),
              Text(
                'Guide UP Farklı Kılanlar',
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '- Geniş mentor ağı ve çeşitli uzmanlık alanları\n'
                    '- Kişiselleştirilmiş mentor seçimi ve öneriler\n'
                    '- İletişim ve mesajlaşma araçları\n'
                    '- Zengin içerik kaynakları ve rehberlik materyalleri\n'
                    '- Kullanıcı deneyimine odaklı kullanıcı arayüzü ve kolay kullanım',
                style: GoogleFonts.nunito(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 52),
                child: Image.asset(
                  'assets/img/GuideUpLogo.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
