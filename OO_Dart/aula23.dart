class Pessoa {

  String nome;
  int idade;
  double altura;

  void dormir() {
    // Podemos printar uma variável apenas com $ + a variável
    //sem precisar dos {}.
    print("$nome está dormindo!");
  }

  void aniver() {
    idade++;
  }
}

void main() {
  String algumaCoisa = "valor";

  //Em DART , o new é opcional, com ou sem ele irá ter o 
  //mesmo resultado e funcionamento. Em flutter o new é 
  //pouco usado.
  Pessoa pessoa = new Pessoa();

  Pessoa pessoa1 = Pessoa();
  pessoa1.nome = "João";
  pessoa1.idade = 30;
  pessoa1.altura = 1.80;
  
  Pessoa pessoa2 = Pessoa();
  pessoa2.nome = "Thiago";
  pessoa2.idade = 28;
  pessoa2.altura = 1.90;

  print(pessoa1.nome);
  print(pessoa2.nome);

  print(pessoa1.idade);
  pessoa1.aniver();
  print(pessoa1.idade);

  pessoa2.dormir();
}