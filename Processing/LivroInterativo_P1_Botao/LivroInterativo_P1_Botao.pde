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
  if (serial.available() > 0) {
    String message = serial.readStringUntil('\n');
    if (message != null && message.trim().equals("play_sound")) {
      sound.play();
    }
  }
}
