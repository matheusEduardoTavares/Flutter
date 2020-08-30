class Valores {
  static int vezesClicado ;
}

class Pessoa {
  String nome;
}

void main() {
  Valores.vezesClicado = 2;

  //Constantes:
  const numero = 3;
  //O const é uma contante em TEMPO DE COMPILAÇÃO, então
  //em qualquer lugar que usarmos essa variável numero,
  //ela será substituída por 3.
  print(numero);

  //O final faz com que uma variável não seja mais 
  //alterada em nenhum momento.
  final Pessoa pessoa = Pessoa();
  pessoa.nome = "Oi";
  print(pessoa.nome);
  //Sem o final, isso seria possível:
  // pessoa = Pessoa();
}