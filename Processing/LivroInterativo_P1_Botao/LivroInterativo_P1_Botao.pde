import processing.serial.*;
import processing.sound.*;

Serial serial;
SoundFile sound;

void setup() {
  size(400, 400);
  printArray(Serial.list()); //run this code to determine which port to use
  serial = new Serial(this, Serial.list()[2], 9600);
  sound = new SoundFile(this, "g_cair.wav");
}

void draw() {
  background(255);
  if (serial.available() > 0) {
    String message = serial.readStringUntil('\n');
    if (message != null && message.trim().equals("play_sound")) {
      sound.play();
      fill(255, 0, 0); // Define a cor vermelha para o círculo
      ellipse(width/2, height/2, 50, 50); // Desenha um círculo no centro da tela
    }
  }
}
