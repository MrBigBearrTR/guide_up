import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/ui/material/custom_material.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yardım ve Destek',
          style: GoogleFonts.nunito(),
        ),
      ),
      body: Container(
        decoration: CustomMaterial.backgroundBoxDecoration ,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sıkça Sorulan Sorular:',
                style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const FAQItem(
                question: 'Nasıl bir mentor seçebilirim?',
                answer:
                'Mentorlar arasında gezinmek için ana sayfadaki arama çubuğunu kullanabilir veya kategorileri inceleyebilirsiniz.',
              ),
              const FAQItem(
                question: 'Mentorlarla nasıl iletişim kurabilirim?',
                answer:
                'Mentor profiline giderek iletişim bilgilerini veya mesajlaşma seçeneklerini bulabilirsiniz.',
              ),
              // Diğer sıkça sorulan soruları buraya ekleyebilirsiniz.
              const SizedBox(height: 16),
              Text(
                'Destek İçin İletişim:',
                style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('E-posta: info@GuideUP.com',style: GoogleFonts.nunito(),),
              Text('Telefon: 123-456-7890',style: GoogleFonts.nunito(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 60),
                child: Image.asset(
                  'assets/logo/guideUpLogo.png',
                  width: 250,
                  height: 250,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({Key? key, required this.question, required this.answer})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.question,
                  style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                ),
                Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(widget.answer),
          ),
      ],
    );
  }
}
