import 'package:flutter/material.dart';

SnackBar showSnackBar(BuildContext context, String text,
    {Function()? onVisible, double? width}) {
  return SnackBar(
    backgroundColor: Colors.black54,
    content: Text(text, style: TextStyle(color: Colors.white, fontSize: 15)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    elevation: 0,
    width: width,
    behavior: SnackBarBehavior.floating,
    // onVisible: () {if (onVisible != null) onVisible();},
    onVisible: onVisible, // запускается 3 раза ?
    // margin: EdgeInsets.fromLTRB(_m_side, 0, _m_side, _m_bottom),
  );
}
