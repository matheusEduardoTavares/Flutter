class Pessoa {

  String nome;
  //em DART Sempre que um atributo tem _ na frente ele é private.
  //Se não tiver ele é public, isso é uma CONVENÇÃO.
  int _idade;
  double _altura;

  Pessoa(this.nome, this._idade, this._altura);

  Pessoa.nascer(this.nome, this._altura) {
    _idade = 0;
    print("$nome nasceu!");
    dormir();
  }

  void dormir() {
    print("$nome está dormindo!");
  }

  void aniver() {
    _idade++;
  }

  //Esse é o idade que será acessível
  // int get idade{
  //   return _idade;
  // }

  set idade (int idade) {
    _idade = idade;
  }

  //Podemos simplificar bem os GETTERS : 
  int get idade => _idade;


  double get altura {
    return _altura;
  }

  set altura(double altura) {
    if (altura > 0.0 && altura < 3.0) {
      _altura = altura;
    }
  }  
}

void main() {
  Pessoa pessoa1 = Pessoa("João", 30, 1.80);
  
  Pessoa pessoa2 = Pessoa("Thiago", 28, 1.90);

  //Não devemos usar pessoa1._nome por exemplo, jamais 
  //acessar um atributo diretamente se ele tem _ na frente.
  //Aí usamos getters and setters.
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

  print(nene.altura);
  nene.altura = 2.0;
  print(nene.altura);
  nene.altura = 15.0;
  print(nene.altura);
}