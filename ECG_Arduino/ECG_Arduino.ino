const int pressureSensorPin = A1;

void setup() {
  // initialize the serial communication:
  Serial.begin(115200);
  pinMode(10, INPUT); // Setup for leads off detection LO +
  pinMode(11, INPUT); // Setup for leads off detection LO -

}

void loop() {
  
  if((digitalRead(10) == 1)||(digitalRead(11) == 1)){
    //Serial.println('!');
  }
  else{
    // send the value of analog input 0:
    //  Serial.println(analogRead(A0));
  }

  int sensorValue = analogRead(pressureSensorPin); // Read the analog voltage from the sensor
  float pressure = map(sensorValue, 0, 1023, 0, 100); // Map the sensor value to a pressure range (adjust as needed)

  Serial.println(pressure);
  
  delay(100);
}