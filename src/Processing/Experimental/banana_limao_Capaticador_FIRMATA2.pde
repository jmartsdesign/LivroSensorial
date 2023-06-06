import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

void setup() {
  // Prints out the available serial ports.
  println(Arduino.list());
  
  // Modify this line by changing the "0" to the index of the serial
  // port corresponding to your Arduino board (as it appears in the list
  // printed by the line above).
  arduino = new Arduino(this, Arduino.list()[0], 57600);
}

void draw() {
   // Read the value from the capacitive sensor
   int value = arduino.analogRead(0);

   // Do something with the value
   println(value);
}
