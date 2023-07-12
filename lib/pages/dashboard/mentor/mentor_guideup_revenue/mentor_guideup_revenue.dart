import 'package:flutter/material.dart';

import '../../../../core/constant/color_constants.dart';

class MentorGuideUpRevenuePage extends StatelessWidget {
  const MentorGuideUpRevenuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Dashboard',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 64.0,
              backgroundImage: AssetImage('assets/img/unknown_user.png'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Ali Yalçın',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.attach_money,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    '\$974',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Card(
              color: ColorConstants.success,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Toplam Bakiye',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.itemWhite,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Ok iconuna tıklanınca yapılacak işlemler
                          },
                          icon: Icon(Icons.arrow_forward),
                          color: ColorConstants.itemWhite,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '1035 \$',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold,color: ColorConstants.itemWhite,),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Beklenen Ödeme: 0 \$',
                      style: TextStyle(fontSize: 16.0,color: ColorConstants.itemWhite,),
                    ),
                    Text(
                      'Yapılan Ödeme: 0 \$',
                      style: TextStyle(fontSize: 16.0,color: ColorConstants.itemWhite,),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Ali Yalçın',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold,color: ColorConstants.itemWhite,)
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Text(
                          'TR39 00001 0090 1024 6113 0050 01',
                          style: TextStyle(fontSize: 14.0,color: ColorConstants.itemWhite,),
                        ),
                        SizedBox(width: 8.0),
                        IconButton(
                          onPressed: () {
                            // Kalem butonuna tıklanınca yapılacak işlemler
                          },
                          icon: Icon(Icons.edit, size: 16.0),color: ColorConstants.itemWhite,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  color: Colors.green,
                  size: 16.0,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Toplam ',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '9745 \$ ',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'kazandın',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Card(
              color: ColorConstants.theme1White,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.credit_card,
                          color: ColorConstants.itemBlack,
                          size: 16.0,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Banka Hesabına Aktar',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.itemBlack,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            // Ok iconuna tıklanınca yapılacak işlemler
                          },
                          icon: Icon(Icons.arrow_forward),
                          color: ColorConstants.itemBlack,
                        ),
                      ],
                    ),
                    SizedBox(height: 3.0),
                    Text(
                      'Bakiyen, 5 iş günü içinde otomatik hesabına aktarılacak',
                      style: TextStyle(fontSize: 10.0,color: ColorConstants.itemBlack,),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
