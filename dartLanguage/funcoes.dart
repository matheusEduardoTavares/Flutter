import 'dart:math';

void main() {
  printIntro();

  calcSoma(10.0, 15.0, c: 5.0);
  double resMult = calcMult(10.0, 15.0);
  print("resMult = ${resMult}");

  double circulo = calcAreaCirculo(5.0);
  print("circulo = ${circulo}");

  double circulo2 = calcAreaCirculo2(5.0);
  print("circulo2 = ${circulo2}");

  int size = tamanho(3);
  print("size = ${size}");
}

void printIntro() {
  print("Seja bem-vindo(a)!");
  print("Escolha sua opção!");
}

void calcSoma(double a, double b, {double c}) {
  //Parâmetros posicionais = a e b
  //Parâmetros nomeados = c
  double res = a + b + c;
  print(res);
}

double calcMult(double a, double b) {
  return a * b;
}

double calcAreaCirculo(double raio) {
  return 3.14 * pow(raio, 2);
}

double calcAreaCirculo2 (double raio) => 3.14 * raio * raio;

var tamanho = (int size) => size * 2;