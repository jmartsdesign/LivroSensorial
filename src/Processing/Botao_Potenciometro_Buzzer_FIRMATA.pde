import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
boolean buttonState = false;
int potValue = 0;
boolean potActive = false;

// Configuração do buzzer
int buzzerPin = 6;
boolean alarmActive = false;

void setup() {
  size(400, 400);

  // Inicializa a conexão com a placa Arduino
  arduino = new Arduino(this, Arduino.list()[2], 57600);

  // Configura o pino 2 como entrada para o botão
  arduino.pinMode(2, Arduino.INPUT);

  // Configura o pino A0 como entrada analógica para o potenciômetro
  arduino.pinMode(0, Arduino.INPUT);

  // Configura o pino 6 como saída para o buzzer
  arduino.pinMode(buzzerPin, Arduino.OUTPUT);
}

void draw() {
  background(255);

  // Lê o estado do botão no pino 2
  int buttonValue = arduino.digitalRead(2);

  // Se o botão for pressionado, atualiza o estado do botão e desativa o potenciômetro
  if (buttonValue == Arduino.HIGH && !buttonState) {

    buttonState = true;
    potActive = false;
  }

  // Se o botão for solto, atualiza o estado do botão e ativa o potenciômetro
  if (buttonValue == Arduino.LOW && buttonState) {
    buttonState = false;
      arduino.analogWrite(buzzerPin, 1255); // Ligar o buzzer com uma frequência alta
  delay(1000);
  arduino.analogWrite(buzzerPin, 0); // Desligar o buzzer
  //delay(1000);
    potActive = true;
  }

  // Lê o valor do potenciômetro no pino A0
  potValue = arduino.analogRead(0);

  // Desenha um quadrado quando o botão não está pressionado
  if (!buttonState) {
    fill(0);
    rectMode(CENTER);
    rect(width/2, height/2, 100, 100);
  }

  // Rotação do quadrado controlada pelo potenciômetro
  if (potActive) {
    if (potValue > 50) {
      float rotation = map(potValue, 50, 1023, 0, TWO_PI);
      translate(width/2, height/2);
      rotate(rotation);
      rectMode(CENTER);
      rect(0, 0, 100, 100);

      // Verifica se o valor do potenciômetro atingiu o máximo
      if (potValue == 1023 && !alarmActive) {
        alarmActive = true;
        playAlarm();
      } else if (potValue < 1023 && alarmActive) {
        alarmActive = false;
        stopAlarm();
      }
    } else {
      // Retorna à posição inicial se o valor do potenciômetro for inferior a 50
      rectMode(CENTER);
      rect(width/2, height/2, 100, 100);
    }
  }
}

// Função para tocar o alarme
void playAlarm() {
  //arduino.digitalWrite(buzzerPin, Arduino.HIGH);
  //delay(500);  // Atraso de 500 milissegundos (0,5 segundo)
  arduino.analogWrite(buzzerPin, 1255); // Ligar o buzzer com uma frequência alta
  delay(1000);
  arduino.analogWrite(buzzerPin, 0); // Desligar o buzzer
  delay(1000);
}

// Função para parar o alarme
void stopAlarm() {
  arduino.digitalWrite(buzzerPin, Arduino.LOW);
  delay(500);  // Atraso
}
