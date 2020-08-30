//O Map no DART seria o objeto no JS: conjunto CHAVE X VALOR

class InfosPessoa {
  int idade;
  InfosPessoa(this.idade);
}

void main() {
  Map<int, String> ddds = Map();
  ddds[11] = "São Paulo";
  ddds[19] = "Campinas";
  ddds[13] = "Não sei!";

  print(ddds.keys); //(11, 19, 13)
  print(ddds.values); //(São Paulo, Campinas, Não sei!)
  print(ddds[11]);

  ddds.remove(11);
  print(ddds); //{19: Campinas, 13: Não sei!}

  print('\n');

  Map<String, dynamic> pessoa = Map();

  pessoa["nome"] = "Enzo";
  pessoa["idade"] = 10;
  pessoa["altura"] = 1.50;
  print(pessoa); //{nome: Enzo, idade: 10, altura: 1.5}

  print('\n');

  Map<String, InfosPessoa> pessoas = Map();
  pessoas["João"] = InfosPessoa(30);
  pessoas["Marcelo"] = InfosPessoa(20);
  print(pessoas); //{João: Instance of 'InfosPessoa', Marcelo: Instance of 'InfosPessoa'}
}