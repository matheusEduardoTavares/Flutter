void main() {

  double num1 = 10.0;
  double num2 = 20.0;

  double result = num1 + num2;
  double result2 = num1 * num2;
  double result3 = (num1 * num2) - 30;

  print(result);
  print(result2);
  print("${result3}\n");

  //Operador resumido:
  num1 = num1 + 15;
  print(num1);
  num1 += 15;
  print(num1);
  num1++;
  print(num1);

  num1 *= 15;
  print(num1);
  num1--;
  print(num1);
}