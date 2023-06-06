import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
boolean buttonState = false;

void setup() {
  size(400, 400);
  
  // Inicializa a conexão com a placa Arduino
  arduino = new Arduino(this, Arduino.list()[2], 57600);
  
  // Configura o pino 2 como entrada
  arduino.pinMode(2, Arduino.INPUT);
}

void draw() {
  background(255);
  
  // Lê o estado do botão no pino 2
  int buttonValue = arduino.digitalRead(2);
  
  // Se o botão estiver pressionado, define buttonState como true
  if (buttonValue == Arduino.HIGH) {
    buttonState = true;
  }
  
  // Se o botão não estiver pressionado, define buttonState como false
  if (buttonValue == Arduino.LOW) {
    buttonState = false;
  }
  
  // Desenha um círculo se o botão estiver pressionado
  if (buttonState) {
    fill(0);
    ellipse(width/2, height/2, 100, 100);
  }
}
