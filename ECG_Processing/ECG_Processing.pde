import processing.serial.*;
import org.gicentre.utils.stat.*;
import org.gicentre.utils.stat.AbstractChart;


Serial myPort;



float pressure;
float ECG;


void setup() {
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 115200);
  myPort.bufferUntil('\n');
  myPort.write('3');
  size(700, 700);
  graph_setup_lungs();
  graph_setup_ECG();
}

void draw() {
  graph_draw();
  FitnessMode_Button();
  StressMode_Button();
  MeditationMode_Button() ;
  SleepMode_Button();
  BreathRate_Square();
  if (FitnessMode==true){
    FitnessMode_Draw();
  }
  if (StressMode==true){
    StressMode_Draw();
  }
  if (MeditationMode==true){
    MeditationMode_Draw();
  }
  if (SleepingMode==true){
    SleepingMode_Draw();
  }
}

void serialEvent(Serial myPort) {
  String tempVal = myPort.readStringUntil('\n');
  
  //print(tempVal);
  
  if (tempVal != null) {
    tempVal = trim(tempVal);
    String[] list = split(tempVal, '\t');
    
    if (list.length == 2) {
      // Parse the values as floats
      float value1 = float(list[0]);
      float value2 = float(list[1]);
      
      if (value1<400){
          value1= 400;
      }
      println(value1);
      updateBuffer(value1);
      graph_serialEvent_heart(ECG);
      
      updateECGData(); 
      calculateBPM();
      
      println(value2);
      pressure = value2;
      
      graph_serialEvent_lungs(pressure);
      calculateRespiratoryRate(pressure);
      calculateMeditation(pressure); 
      // Handle the values as needed
    } else {
      println("Invalid data format: " + tempVal);
    }
  }
}


int bufferSize = 50;
float[] circularBuffer = new float[bufferSize];
float sum = 0;
int bufferIndex = 0;


// fuction to smooth the data 
void updateBuffer(float newValue) {
  // Remove the oldest value from the sum
  sum -= circularBuffer[bufferIndex];
  
  // Add the new value to the sum
  sum += newValue;
  
  // Update the circular buffer with the new value
  circularBuffer[bufferIndex] = newValue;
  
  // Update ECG with the current moving average
  ECG = sum / bufferSize;
  
  // Increment the buffer index (circular)
  bufferIndex = (bufferIndex + 1) % bufferSize;
}
