class Question{

  int? id;
  String? question;
  List<dynamic>? choices;


    Question({this.id, this.question, this.choices});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    choices = List<dynamic>.from(json['choices']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['choices'] = choices;
    return data;
  }
}