int potPin = 0; 
void setup() { 
 Serial.begin(9600); 
} 
void loop() { 
 int sensorValue = analogRead(potPin); 
 Serial.write(sensorValue/4);  
 delay(100); 
}