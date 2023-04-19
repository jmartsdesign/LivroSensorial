
import processing.serial.*;

Serial myPort;    // The serial port
String inString;  // Input string from serial port
int lf = 10;      // ASCII linefeed

String[] photoSensorRead; //for text array for output from arduino
float n;                    //for raw value from arduino
//int brightness;           //for adjusted value from arduino

 

void setup(){
  size(1280, 720);
  // List all the available serial ports:
  printArray(Serial.list()); //run this code to determine which port to use
  // SEE ALSO, void "serialEvent" function below, running in background
  // Open the port you are using at the rate you want:
  // Open the port you are using at the rate you want:
  // Try different ports (e.g., 1, 2, 3) in next line if not working
  myPort = new Serial(this, Serial.list()[2], 9600);
  myPort.bufferUntil(lf);
}

void draw(){
  background(150,200,255);
  
  //read photosensor value from serial port
  photoSensorRead = split(inString, '='); //subdivide text string at " = "
  //println("photoSensorRead " +  photoSensorRead);
  
  //parse text value of photosensor value
  if (null != photoSensorRead && photoSensorRead.length > 1) {
    String num = photoSensorRead[1];
    n = float(Integer.parseInt(num.trim()));
  }
  randomSeed(0);
  float scale = map(n, 0.0, 1025, 0.5, random(0.5, 5.75));
  owl(width/2.0, height - 10, int(random(5, 220)), scale); 
}

void owl(float x, float y, int g, float s) {
  pushMatrix();
    translate(x, y);
    scale(s); // Set the size
    stroke(138-g, 138-g, 125-g); // Set the color value
    strokeWeight(70);
    line(0, -35, 0, -65); // Body
    noStroke();
    fill(255);
    ellipse(-17.5, -65, 35, 35); // Left eye dome
    ellipse(17.5, -65, 35, 35);  // Right eye dome
    arc(0, -65, 70, 70, 0, PI);  // Chin
    fill(51, 51, 30);
    ellipse(-14, -65, 8, 8); // Left eye
    ellipse(14, -65, 8, 8);  // Right eye
    quad(0, -58, 4, -51, 0, -44, -4, -51); // Beak
    strokeWeight(1);
  popMatrix();
}

void serialEvent(Serial p) {
  inString = p.readString();
}
