 //Arduino code to test photo sensor
 //Earl Mark 3/23/17

int photocellPin0 = 1;     // the cell and 10K pulldown are connected to a0
int photocellReading0;    

void setup() {
  // initialize serial communication:
  Serial.begin(9600);
}

void loop(){
  photocellReading0 = analogRead(photocellPin0); //read photoresister 
  Serial.print(" _ Analog reading 0 = ");       //output value to serial port
  Serial.println(photocellReading0);
}