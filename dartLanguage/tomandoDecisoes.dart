void main() {
  double nota = 8.0;

  if (nota < 5.0) {
    print("Exame! :(");
  }
  else if (nota == 10.0) {
    print("Sucesso total!");
  }
  else if (nota == 9.9) {
    print("Quase sucesso total!");
  }
  else {
    print("Sucesso! :)");
  }

  bool aprovado = true;
  String info;

/*
  if (aprovado) {
    info = "Aprovado!!!";
  }
  else {
    info = "Reprovado...";
  }
*/
  info = aprovado ? "Aprovado!!!" : "Reprovado";
  print(info);

  String nome; //Se não inicializarmos a variável, ela fica
  //null
  // Agora queremos fazer que outra variável receba o valor
  //da variável nome, mas que caso o nome seja null, queremos
  //colocar outro texto no local.
  String info2 = nome ?? "Não informado!";
  print("${info2}");

  nome = "Daniel";

  info2 = nome ?? "Não informado!";

  print(info2);

  //O operador ?? é tipo o || no JS.

  print('fim');

}