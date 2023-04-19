import processing.serial.*;
import processing.sound.*;

Serial serial;
SoundFile sound;

int sensorVal;  // potenciometro
PShape bot;

void setup() {
  size(640, 360);
  printArray(Serial.list()); //run this code to determine which port to use
  serial = new Serial(this, Serial.list()[2], 9600);
  sound = new SoundFile(this, "g_cair.wav");

  bot = loadShape("bot1.svg");  //imagem potenciometro
}

void draw() {
  if (serial.available() > 0) {
    String message = serial.readStringUntil('\n');
    if (message != null && message.trim().equals("play_sound")) {
      sound.play();
    }
  }

  if (serial.available()>0)
  {
    sensorVal=serial.read();
  }
  background(102);
  translate(width/2, height/2);
  float zoom = map(sensorVal, 0, width, 0.1, 5);
  scale(zoom);
  shape(bot, -140, -140);
}
