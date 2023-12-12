import 'package:charge_mod/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class textFields extends StatelessWidget {
  textFields(
      {super.key,
      required this.hintText,
      this.validator,
      required this.keyBoardType,
      required this.textEditingController});
  String hintText;
  String? Function(String?)? validator;
  TextEditingController textEditingController;
  TextInputType keyBoardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: keyBoardType,
      textAlignVertical: TextAlignVertical.top,
      style: GoogleFonts.poppins(fontSize: 18),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(fontSize: 12),
          enabledBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(width: 2, color: borderColorForLoginTextField),
              borderRadius: BorderRadius.all(Radius.circular(9))),
          enabled: true,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(9))),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(9))),
          contentPadding: const EdgeInsets.only(left: 20, top: 0),
          border: const OutlineInputBorder()),
      validator: validator,
    );
  }
}
