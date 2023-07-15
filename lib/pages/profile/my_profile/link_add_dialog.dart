import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guide_up/core/enumeration/extensions/ExLinkType.dart';
import 'package:guide_up/core/models/users/user_detail/user_detail_model.dart';

import '../../../core/constant/color_constants.dart';
import '../../../core/enumeration/enums/EnLinkType.dart';
import '../../../core/models/users/user_detail/user_links_model.dart';
import '../../../core/utils/user_info_helper.dart';
import '../../../repository/user/user_detail/user_links_repository.dart';

class LinkAddDialog extends StatefulWidget {
  const LinkAddDialog({Key? key, required this.userDetail}) : super(key: key);
  final UserDetail userDetail;

  @override
  State<LinkAddDialog> createState() => _LinkAddDialogState();
}

class _LinkAddDialogState extends State<LinkAddDialog> {
  String link = "";
  EnLinkType? selectedLinkType;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "+ Link Ekle",
        style: GoogleFonts.nunito(
          color: ColorConstants.buttonPurple,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<EnLinkType>(
            focusColor: ColorConstants.buttonPurple,
            value: selectedLinkType,
            style: GoogleFonts.nunito(color: ColorConstants.buttonPurple),
            dropdownColor: ColorConstants.background,
            isExpanded: true,
            onChanged: (EnLinkType? value) {
              selectedLinkType = value!;
              setState(() {});
            },
            items: EnLinkType.values
                .map<DropdownMenuItem<EnLinkType>>((EnLinkType value) {
              return DropdownMenuItem<EnLinkType>(
                value: value,
                child: Text(value.getDisplayName()),
              );
            }).toList(),
          ),
          const SizedBox(height: 8.0),
          TextFormField(
            style: GoogleFonts.nunito(
              textStyle: const TextStyle(
                color: ColorConstants.buttonPurple,
              ),
            ),
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.buttonPurple),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.buttonPurple),
              ),
              labelText: "Link",
              labelStyle:
                  GoogleFonts.nunito(color: ColorConstants.buttonPurple),
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) {
              link = value;
            },
          ),
        ],
      ),
      backgroundColor: ColorConstants.background,
      // Arka plan rengi olarak kullanıldı

      actions: [
        ElevatedButton(
          onPressed: () {
            if (selectedLinkType != null && link.isNotEmpty) {
              String error="";

               if(link.isNotEmpty && !UserInfoHelper.hasValidUrl(link)){
                error="Lütfen URL bilgisini doğru formatta giriniz.";
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: ColorConstants.buttonPurple,
                    content: Text(
                      error,
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.background,
                        ),
                      ),
                    ),
                  ),
                );
              }
              UserLinks links = UserLinks();
              links.setLink(link);
              links.setEnLinkType(selectedLinkType);
              links.setUserId(widget.userDetail.getUserId()!);
              UserLinksRepository().add(links);
              Navigator.pop(context);
              setState(() {});
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.background),
          child: Text(
            "Tamam",
            style: GoogleFonts.nunito(
                color: ColorConstants.buttonPurple // Metin rengi
                ),
          ),
        ),
      ],
    );
  }
}
