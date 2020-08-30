abstract class Animal {
  String nome;
  double peso;

  Animal (this.nome, this.peso);

  void comer() {
    print("$nome comeu!");
  }

  void fazerSom() {
    print("$nome fez algum som!");
  }

  @override 
  String toString() {
    return "Animal | Nome: $nome, Peso: $peso";
  }

  //Em classes abstratas, conseguimos declarar 
  //métodos sem corpo:
  void fazerSoma();
  // Métodos que não tem corpo são métodos abstratos,
  //ou seja, são OBRIGADOS a serem sobrescritos em 
  //qualquer classe que herdar essa classe que o contém.
}

class Cachorro extends Animal {
  int fofura;

  Cachorro(String nome, double peso, this.fofura) : super(nome, peso);

  void brincar() {
    fofura += 10;
    print("Fofura do $nome aumentou para $fofura !!!!");
  }

  @override 
  void fazerSoma() {

  }
}

class Gato extends Animal{
  Gato(String nome, double peso) : super(nome, peso);

  bool estaAmigavel() {
    return true;
  }

  @override 
  void fazerSoma() {
    
  }
}

void main() {
  Cachorro cachorro = Cachorro("Dog", 10.0, 100);
  cachorro.fazerSom();
  cachorro.comer();
  cachorro.brincar();
  
  Gato gato = Gato("Cat", 10.0);
  gato.fazerSom();
  gato.comer();
  print("Está amigável? ${gato.estaAmigavel()}");

  //Não podemos instanciar objetos de classes abstratas.
  //Erro:
  //Animal animal = Animal("Rex", 20.0);
  //print(animal);
}