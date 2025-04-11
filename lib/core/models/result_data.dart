abstract class ResultData {
  Map<String, dynamic> toJson();
  ResultData converter(Map<String, dynamic> map);
}

class EmptyResultData extends ResultData {

  @override
  ResultData converter(Map<String, dynamic> map) => EmptyResultData();

  @override
  Map<String, dynamic> toJson() => {};
}