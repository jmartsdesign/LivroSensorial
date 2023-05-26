import processing.serial.*;

Serial arduinoPort;
int capSensorValue1;
int capSensorValue2;

void setup() {
  String portName = Serial.list()[2]; // Ajuste o índice para corresponder à porta serial correta
  arduinoPort = new Serial(this, portName, 579600);
}

void draw() {
  if (arduinoPort.available() > 0) {
    String data = arduinoPort.readStringUntil('\n');
    if (data != null) {
      String[] values = data.trim().split(",");
      if (values.length == 2) {
        capSensorValue1 = int(values[0]);
        capSensorValue2 = int(values[1]);
        // Faça o que for necessário com os valores dos sensores capacitivos
        println("Sensor 1: " + capSensorValue1);
        println("Sensor 2: " + capSensorValue2);
      }
    }
  }
}
