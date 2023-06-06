import processing.serial.*;

Serial arduinoPort;
int capSensorValue1;
int capSensorValue2;
int buzzerPin = 6; // Pino do buzzer

void setup() {
  String portName = Serial.list()[2]; // Ajuste o índice conforme necessário
  arduinoPort = new Serial(this, portName, 57600);

  // Enviar comando para configurar o pino do buzzer como saída
  arduinoPort.write("M5");
}

void draw() {
  // Ler os valores dos sensores capacitivos
  arduinoPort.write("R4");
  capSensorValue1 = Integer.parseInt(arduinoPort.readStringUntil('\n').trim());

  arduinoPort.write("R5");
  capSensorValue2 = Integer.parseInt(arduinoPort.readStringUntil('\n').trim());

  // Faça o que for necessário com os valores dos sensores capacitivos
  println("Sensor 1: " + capSensorValue1);
  println("Sensor 2: " + capSensorValue2);

  // Ativar o buzzer se algum dos sensores detectar algo
  if (capSensorValue1 > 0 || capSensorValue2 > 0) {
    arduinoPort.write("H6"); // Enviar comando para ligar o buzzer
  } else {
    arduinoPort.write("L6"); // Enviar comando para desligar o buzzer
  }

  delay(100); // Atraso entre leituras dos sensores (ajuste conforme necessário)
}
