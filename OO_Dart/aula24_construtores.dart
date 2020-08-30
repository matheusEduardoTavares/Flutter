class Pessoa {

  String nome;
  int idade;
  double altura;
/*
  Pessoa(String nome, int idade, double altura) {
    this.nome = nome;
    this.idade = idade;
    this.altura = altura;
  }
*/
  //Esse construtor tem o mesmo resultado das linhas
  //7 até a 11
  Pessoa(this.nome, this.idade, this.altura);

  //Temos tb named constructor, que possui um nome específico:
  Pessoa.nascer(this.nome, this.altura) {
    idade = 0;
    print("$nome nasceu!");
    dormir();
  }
  //No caso, esse construtor terá o nome nascer, e a diferença
  //é que ele pode ter outra assinatura. Não é possível fazer
  //sobrecarga de MÉTODOS em DART.

  void dormir() {
    print("$nome está dormindo!");
  }

  void aniver() {
    idade++;
  }
}

void main() {
  Pessoa pessoa1 = Pessoa("João", 30, 1.80);
  
  Pessoa pessoa2 = Pessoa("Thiago", 28, 1.90);

  print(pessoa1.nome);
  print(pessoa2.nome);

  print(pessoa1.idade);
  pessoa1.aniver();
  print(pessoa1.idade);

  pessoa2.dormir();

  print("\n");

  Pessoa nene = Pessoa.nascer("Enzo", 0.30);
  print(nene.nome);
  print(nene.idade);
}