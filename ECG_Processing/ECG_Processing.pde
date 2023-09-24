import processing.serial.*;
import org.gicentre.utils.stat.*;
import org.gicentre.utils.stat.AbstractChart;

Serial myPort;


float pressure;

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
}

void serialEvent(Serial myPort) {
  
  String tempVal = myPort.readStringUntil('\n');
  
  if (tempVal != null) {
        pressure = float(tempVal);
        println(pressure);
        graph_serialEvent_lungs(pressure);
        calculateRespiratoryRate(pressure);
   } 
}
