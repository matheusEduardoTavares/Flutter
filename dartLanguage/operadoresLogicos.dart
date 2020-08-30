void main() {
  // Os operadores lógicos são os mesmos do JAVA

  bool testeComp = (10 > 20);
  print("COMP: ${testeComp}");
  testeComp = (10 < 20);
  print("COMP: ${testeComp}");
  testeComp = (10 == 20);
  print("COMP: ${testeComp}");
  testeComp = (10 != 20);
  print("COMP: ${testeComp}");

  double num1 = 15.0;
  testeComp = (10 != num1);
  print("COMP: ${testeComp}");

  bool testeOr = (true || false);
  print("TesteOr: ${testeOr}");

  testeOr = (false || false);
  print("TesteOr: ${testeOr}");

  bool testeAnd = (false && true);
  print("TesteAnd ${testeAnd}");

  testeAnd = (true && true);
  print("TesteAnd ${testeAnd}");

  bool end = (10 > 20) && (30 < 20) || testeAnd;
  print("end ${end}");

  print(!false);
}