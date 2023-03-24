class SendUnit {
  String? somecode;

  SendUnit({
    required this.somecode
  });

  @override
  String toString() {
    return "$somecode";
  }

  factory SendUnit.fromJson(Map<String, dynamic> json) {
    return SendUnit(
        somecode: json['somecode']
    );
  }

}
class SendData {
  final List<SendUnit> list;

  SendData({
    required this.list,
  });

  factory SendData.fromJson(List<dynamic> jsc) {
    return SendData(
      list: List<SendUnit>.generate(
          jsc.length, (index) => SendUnit.fromJson(jsc[index])
      ),
    );
  }
}

