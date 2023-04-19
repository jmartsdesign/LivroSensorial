import processing.serial.*; 
Serial serial; 
int sensorValue; 
PShape bot; 
void setup() { 
 size(640, 360); 
   serial=new Serial(this,Serial.list()[2],9600); 
 // The file "bot1.svg" must be in the data folder 
 // of the current sketch to load successfully 
 bot = loadShape("bot1.svg"); 
}  
void draw() { 
 if(serial.available()>0) 
 { 
   sensorValue=serial.read(); 
 } 
 background(102); 
 translate(width/2, height/2); 
 float zoom = map(sensorValue, 0, width, 0.1, 5); 
 scale(zoom); 
 shape(bot, -140, -140); 
}
