//Em DART , toda classe por default extende a classe
//Object , de forma implícita. Essa classe tem um 
//método chamado toString() que é quem é chamado quando
//printamos um objeto.

class Animal {
  String nome;
  double peso;

  Animal (this.nome, this.peso);

  void comer() {
    print("$nome comeu!");
  }

  void fazerSom() {
    print("$nome fez algum som!");
  }
}

class Cachorro extends Animal {
  int fofura;

  Cachorro(String nome, double peso, this.fofura) : super(nome, peso);

  void brincar() {
    fofura += 10;
    print("Fofura do $nome aumentou para $fofura !!!!");
  }

  @override 
  void fazerSom(){
    print("$nome fez au au!");
  }

  @override 
  String toString(){
    return "Cachorro | Nome: $nome, Peso: $peso, Fofura: $fofura";
  }

}

class Gato extends Animal{
  Gato(String nome, double peso) : super(nome, peso);

  bool estaAmigavel() {
    return true;
  }

  @override
  void fazerSom(){
    print("${nome} fez miaaaaaau!!");
  }

  @override 
  String toString(){
    return "Gato | Nome: $nome, Peso: $peso";
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
  print(gato);

  //Sem sobrescrever o toString, o default é:
  //Instance of 'Cachorro'
  print(cachorro);
}