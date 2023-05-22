class User {
  int? firstname;
  int? id;
  String? idno;
  int? lastname;
  String? score;

  User(
      {this.firstname, this.id, this.idno, this.lastname, this.score});

  User.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    id = json['id'];
    idno = json['idno'];
    lastname = json['lastname'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstname;
    data['id'] = id;
    data['idno'] = idno;
    data['lastname'] = lastname;
    data['score'] = score;
    return data;
  }
}