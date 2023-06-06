import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
int sensorPin = 4;
int sensorPin2 = 5;
int numAmostras = 10; // Número de amostras para a média móvel
int[] amostras = new int[numAmostras];
int indiceAmostra = 0;
int limiar = 250;  // Defina o limiar desejado aqui 250

void setup() {
  size(400, 400);
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(sensorPin, Arduino.INPUT);
  arduino.pinMode(sensorPin2, Arduino.INPUT);
}

void draw() {
  background(255);
  int valorSensor = arduino.analogRead(sensorPin); // Lê o valor do sensor
  int valorSensor2 = arduino.analogRead(sensorPin2); // Lê o valor do segundo sensor
  
  // Adiciona a amostra atual ao array
  amostras[indiceAmostra] = valorSensor;
  indiceAmostra = (indiceAmostra + 1) % numAmostras;
  
  // Calcula a média das amostras
  float media = 0;
  for (int i = 0; i < numAmostras; i++) {
    media += amostras[i];
  }
  media /= numAmostras;
  
  if (media < limiar && valorSensor2 < limiar) {
    fill(0);
    ellipse(width/2, height/2, 50, 50);
  }
  
  // Imprime os valores do sensor na janela de saída
  println("Valor Sensor 1: " + media);
  println("Valor Sensor 2: " + valorSensor2);
}
