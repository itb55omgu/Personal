

import 'package:logintask/exeption/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SharedPrefsData {
  // устанавливаются и сохраняются в режиме Auth
  String firstname;
  String guid;
  String guidS;
  String nameS;
  String authHeader;


  SharedPrefsData({
    this.firstname = '',
    this.guid = '',
    this.authHeader = '',
    this.guidS = '',
    this.nameS = '',
  });

  String get eternalguid => guid.decodePipe64ToString();

  set eternalguid(String _guid) => guid = _guid.encodeStringToPipe64();

  String get eternalfirstname => firstname.decodePipe64ToString();

  set eternalfirstname(String _firstname) =>
      firstname = _firstname.encodeStringToPipe64();

  String get eternalauthHeader => authHeader.decodePipe64ToString();

  set eternalauthHeader(String _authHeader) =>
      authHeader = _authHeader.encodeStringToPipe64();

  String get eternalguidS => guidS.decodePipe64ToString();

  set eternalguidS(String _guidS) => guidS = _guidS.encodeStringToPipe64();

  String get eternalnameS => nameS.decodePipe64ToString();

  set eternalnameS(String _nameS) => nameS = _nameS.encodeStringToPipe64();


  @override
  String toString() {
    return "$eternalfirstname: $eternalguid";
  }

  // void encodePinCode(String _pin) {
  //   int _seed = Random().nextInt(100000)+10000;
  //   pinCode64 = '$_pin$_seed'.encodeStringToPipe64();
  // }

  Future<void> fromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('firstname'))
      firstname = prefs.getString('firstname')!;
    if (prefs.containsKey('guid')) guid = prefs.getString('guid')!;
    if (prefs.containsKey('nameS')) nameS = prefs.getString('nameS')!;
    if (prefs.containsKey('guidS')) guidS = prefs.getString('guidS')!;
    if (prefs.containsKey('authHeader')) {
      authHeader = prefs.getString('authHeader')!;
    }
  }

  Future<void> toPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('firstname', firstname);
    prefs.setString('guid', guid);
    prefs.setString('authHeader', authHeader);
    prefs.setString('nameS', nameS);
    prefs.setString('guidS', guidS);
  }

}