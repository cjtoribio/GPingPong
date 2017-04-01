import 'dart:mirrors';

class JsonField {
  const JsonField();
}


class Serializable {

  Map toJson(Object obj){
    InstanceMirror instanceMirror = reflect(obj);
    ClassMirror f = reflectClass(Car);
    print(f.declarations);
    Map ret = {};
    for(DeclarationMirror mirror in f.declarations.values){
      if(mirror.metadata.any((m) => m.reflectee is JsonField)){
        InstanceMirror field = instanceMirror.getField(mirror.simpleName);
        var value = field.reflectee;
        if(value is String) {
          return field.reflectee;
        }
        if(value is DateTime) {
          return value.toIso8601String();
        }
        if(value is num){
          ret[mirror.simpleName.toString()] value;
        }
        if(value is Object){

        }
      }
    }
    return ret;
  }
}

class Car {
  @JsonField()
  String model;
}



void main() {

  Car c = new Car();
  c.model = "hello";

  InstanceMirror instanceMirror = reflect(c);
  ClassMirror f = reflectClass(Car);
  print(f.declarations);
  Map ret = {};
  for(DeclarationMirror mirror in f.declarations.values){
    if(mirror.metadata.any((m) => m.reflectee is JsonField)){
      InstanceMirror field = instanceMirror.getField(mirror.simpleName);
      var value = field.reflectee;
      instanceMirror.getField(mirror);
//      if(value is String) {
//        return field.reflectee;
//      }
//      if(value is DateTime) {
//        return value.toIso8601String();
//      }
//      if(value is num){
//        ret[mirror.simpleName.toString()] value;
//      }
//      if(value is Object){
//
//      }
    }
  }
//  return ret;

}