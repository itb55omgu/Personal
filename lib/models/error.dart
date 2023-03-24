class Error{
  String errorData;

  Error({
    required this.errorData
});

  factory Error.fromJson(var json) {
    return Error(
      errorData: json['errorData']
    );
  }
}