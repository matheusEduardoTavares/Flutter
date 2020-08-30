//Comentários: // e /* */
// Strings entre "" ou entre ''

void main () {

  //Implementando uma lojinha

  String nome = "Lojinha do Daniel";

  int bananas = 5;

  double preco = 10.5;

  bool aindaTem = true;

  print(nome);
  print(bananas);

  bananas = 10;

  print(bananas);

  print("O nome da lojinha é: " + nome);
  print("O nome da lojinha é: ${nome}");

  print("A ${nome} tem ${bananas} bananas");

  var teste = 1;
  print(teste);
  // Uma variável com var tem seu tipo definido
  //em sua primeira inicialização. E dart é 
  //FORTEMENTE TIPADO, logo, isso daria erro:
  // teste = "HAHAHA";

  print(teste.runtimeType); //int
  print(teste is int); //true

  //Mas podemos ter uma variável cujo tipo seja
  //alterado, desde que ela seja declarada como 
  //dynamic
  dynamic teste2 = 1;
  print(teste2);
  print("teste2.runtimeType >> ${teste2.runtimeType}");
  teste2 = "HAHAHAHA";
  print(teste2);
  print("teste2.runtimeType >> ${teste2.runtimeType}");
}