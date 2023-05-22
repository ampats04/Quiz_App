
  class Question {
  int? id;
  List<dynamic>? option;
  int? qid;
  String? question;

  Question({this.id, this.option, this.qid, this.question});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    option =  List<dynamic>.from(json['OPTION']);
    qid = json['QID'];
    question = json['QUESTION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['OPTION'] = option;
    data['QID'] = qid;
    data['QUESTION'] = question;
    return data;
  }
}
