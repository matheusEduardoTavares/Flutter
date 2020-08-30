class Pessoa {
  String nome;
  int idade;

  Pessoa (this.nome, this.idade);
}

void main() {
  //A list no dart é o array nas outras linguagens
  //(segue a mesma ideia de PYTHON referente a isso)
  List<String> nomes = ["Daniel", "Mari", "Thiago"];

  print(nomes[0]);
  nomes.add("Marcos");
  print(nomes);

  print(nomes.length);

  nomes.removeAt(2);
  print(nomes);

  nomes.insert(1, "Thiago");
  print(nomes);

  print(nomes.contains("Daniel"));
  print(nomes.contains("João"));

  print("\n");

  // List<Pessoa> pessoas = [];
  List<Pessoa> pessoas = List();
  pessoas.add(Pessoa("Marcelo", 30));
  pessoas.add(Pessoa("João", 20));
  
  for (Pessoa p in pessoas) {
    print(p.nome);
  }
}