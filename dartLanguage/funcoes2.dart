void main() {
  criarBotao("BotaoSair", cor: "Preto", largura: 15.0);
  print("\n");
  criarBotao("BotaoSair", cor: "Cinza");
}
//PARÂMETROS OPCIONAIS DEVEM SER NOMEADOS

void criarBotao(String texto, {String cor, double largura}) {
  print(texto);
  print(cor); // se não passar nada fica null, pois é um
  //parâmetro nomeado portanto opcional.
  print(largura); // se não passar nada fica null, pois é um
  //parâmetro nomeado portanto opcional.

  print("-------------");
  print(cor ?? "Preto");
  print(largura ?? 10.0);
}