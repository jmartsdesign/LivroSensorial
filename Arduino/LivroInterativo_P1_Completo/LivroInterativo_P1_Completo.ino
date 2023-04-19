/* Potentiometer controlling lamp program */
// Constants
#define DELAY 20 // Delay between two measurements in ms
#define MIN_RAW 0 // Analog minimum value
#define MAX_RAW 1023 // Analog maximum value
#define MIN_CMD 0 // Digital minimum value
#define MAX_CMD 200 // Digital maximum value

#define DELAY1 500 // Delay between two measurements in ms
#define VIN 5 // V power voltage
#define R1 10000 //ohm resistance value

// Parameters
const int sensorPin = A0; // Pin connected to sensor - potenciometro
const int ledPin = 3; // Pin connected to sensor
const int sensorPin1 = A1; // Pin connected to sensor - Photosensor
const int buttonPin = 2; // Pin botao
int buttonState = 0;  // pin botao

//Variables
int sensorVal; // Analog value from the sensor
int cmd; //Led command value
int sensorVal1; // Analog value from the sensor
int lux1; //Lux value

//Main
void setup(void) {
 	Serial.begin(9600);
 	pinMode(ledPin,OUTPUT);
  pinMode(buttonPin, INPUT); //botao
}
void loop(void) {
  buttonState = digitalRead(buttonPin); //botao som
  if (buttonState == HIGH) {
    Serial.println("play_sound");
    delay(100);
  }

 	sensorVal = analogRead(sensorPin); // potenciometro
   Serial.write(sensorVal/4);  //para a escala
 	cmd=sensorToLed(sensorVal);
 	analogWrite(ledPin,cmd);
 	delay(DELAY);
 /*	Serial.print("Sensor : ");
 	Serial.println(sensorVal);
 	Serial.print("Command : ");
 	Serial.println(cmd);*/
  
  sensorVal1 = analogRead(sensorPin1); //Photosensor
  lux1=sensorRawToPhys(sensorVal1);
  Serial.print(F("Raw value from sensor= "));
  Serial.println(sensorVal1); // the analog reading
  Serial.print(F("Physical value from sensor = "));
  Serial.print(lux1); // the analog reading
  Serial.println(F(" lumen")); // the analog reading
  delay(DELAY1);

  
}
//Functions
int sensorToLed(int raw){
 	int val = map(sensorVal, MIN_RAW, MAX_RAW, MIN_CMD, MAX_CMD);
 	val=max(val,MIN_CMD);
 	val=min(val,MAX_CMD);
 	return val;
}

int sensorRawToPhys(int raw){
  // Conversion rule
  float Vout = float(raw) * (VIN / float(1024));// Conversion analog to voltage
  float RLDR = (R1 * (VIN - Vout))/Vout; // Conversion voltage to resistance
  int phys=500/(RLDR/1000); // Conversion resitance to lumen
  return phys;
}
