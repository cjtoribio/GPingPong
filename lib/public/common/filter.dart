import 'package:angular2/core.dart';

@Pipe('filter')
@Injectable()
class FilterPipe implements PipeTransform {

  List transform(List items ,String term) {
    return items.where((u) {
      if(term == null || term.length == 0)return true;
      return findRecursively(u.toJson(), term.toLowerCase());
    });
  }

  bool findRecursively(Map m, String term){
    for(Object v in m.values){
      if(v is String){
        if(v.toLowerCase().indexOf(term) != -1){
          return true;
        }
      }else if(v is Map){
        if(findRecursively(v, term)){
          return true;
        }
      }
    }
    return false;
  }

}