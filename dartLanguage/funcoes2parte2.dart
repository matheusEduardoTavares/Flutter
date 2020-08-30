void main() {
  criarBotao("BotaoSair", botaoCriado, cor: "Cinza");
  print("\n");

  //Função anônima:
  criarBotao("BotaoCamera", () {
    print("Botão criado por func anonima");
  });

  print("\n");

  //Função anônima parecida com arrow function:
  criarBotao("BotaoCamera", () => {
    print("Botão criado por func anonima 2")
  });

  print("\n");
  print(cc(2).runtimeType);
}

//DART é multiparadigma
//DART também é HIGHER ORDER FUNCTION

void botaoCriado() {
  print("Botão criado!!!");
}

void criarBotao (String texto, Function criadoFunc, { String cor, double largura }) {
  print(texto);
  print(cor ?? "Preto");
  print(largura ?? 10.0);

  criadoFunc();
  print(criadoFunc.runtimeType);
  // () => void
  // () => null
  // () => Set<void>
}

// var cc = (double a) {
//   return a;
// };

// o retorno disso é um _CompactLinkedHashSet<double>
var cc = (double a) => {
  a
};