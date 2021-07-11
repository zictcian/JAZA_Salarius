import 'dart:ffi';

class Movement {
  int id;
  String type;
  String concept;
  String mount;

  Movement({this.type, this.concept, this.mount});
  Movement.withId({this.id,this.type, this.concept, this.mount});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if(id != null){
      map['id'] = id;
    }
    map['type'] = type;
    map['concept'] = concept;
    map['mount'] = mount;
    return map;
  }

  factory Movement.fromMap(Map<String, dynamic> map) {
    return Movement.withId(
        id: map['id'],
        type: map['type'],
        concept: map['concept'],
        mount: map['mount']);
  }
}