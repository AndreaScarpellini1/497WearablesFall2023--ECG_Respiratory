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
  
  if (tempVal != null) {
    tempVal = trim(tempVal);
    String[] list = split(tempVal, '\t');
    
    if (list.length == 2) {
      // Parse the values as floats
      float value1 = float(list[0]);
      float value2 = float(list[1]);
      
      //println("Value 1: " + value1);
      ECG = value1;
      //println("Value 2: " + value2);
      pressure = value2;
      
      graph_serialEvent_lungs(pressure);
      graph_serialEvent_heart(ECG);
      calculateRespiratoryRate(pressure);
      calculateHeartRate(ECG);
      // Handle the values as needed
    } else {
      println("Invalid data format: " + tempVal);
    }
  }
}
