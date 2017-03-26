import 'package:GPingPong/model/user.dart';
import 'package:GPingPong/model/single_match.dart';
import 'package:GPingPong/service/elo.dart';
import "package:test/test.dart";

void main() {

  test("Rating changes coincide with hardcoded formula in excel", () {
    User a = new User("Juan", "juancruzlepore");
    User b = new User("Carlos", "carlosceballos");

    SingleMatch m = new SingleMatch(a,b,2,0);

    Elo.updateRating(m);

    expect(a.rating.score, 1592.3004591138501);
    expect(b.rating.score, 1403.3413442778901);
  });

}