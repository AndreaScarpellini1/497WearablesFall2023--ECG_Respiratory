XYChart lineChart;

FloatList lineChartX;
FloatList lineChartY;
FloatList finalLineX;
FloatList finalLineY;

float xVal;
float yVal;
int count =0;
float time=0;

boolean exhale = false; // This variable keeps track of whether the user is exhaling
float prevPressure = 0;
float prevTime = 0;
float respiratoryRate = 0;

PImage myIcon;

void graph_setup_lungs() {
  
  //icon lungs 
  myIcon = loadImage("download.png"); // Load your image file (provide the correct path);
  myIcon.resize(60, 60);

  lineChart = new XYChart(this);
  lineChartX = new FloatList();
  lineChartY = new FloatList();
  finalLineX = new FloatList();
  finalLineY = new FloatList();
  lineChart.setData(lineChartX.array(), lineChartY.array());
  //lineColor = color(0, 0, 255);
  
  lineChart.showXAxis(true);
  lineChart.showYAxis(true);
  lineChart.setMinY(0);
  
  lineChart.setYFormat("00");
  lineChart.setXFormat("00.00");
  
  //lineChart.setPointColour(color(0, 255, 0));
  lineChart.setPointSize(5);
  lineChart.setLineWidth(2);
  
  count = 0;
}

void graph_draw_lungs() {
  background(255,255,255);
  textSize(9);
  
  noStroke();
  fill(200);
  lineChart.draw(350, 65, 325,205);
  lineChart.setAxisColour(0);
  fill(0); // Set text color to black
  textSize(15);
  text("Time", 500, 275); // Adjust position as needed

  pushMatrix();
  translate(100,100);
  rotate(-PI/2); // Rotate by 90 degrees counterclockwise
  textSize(15);   // Set the text size
  fill(0);       // Set text color to black
  text("Breathing Cycle", -100,250); 
  popMatrix();
  
  
  
  //grid 
  stroke(200); // Set the color for grid lines (gray)
  for (int y = 70; y <= 265; y += 20) {
    int startX =364; // Adjust the starting X-coordinate
    int endX = startX +300; // Calculate the ending X-coordinate
    line(startX, y, constrain(endX, startX, width), y); // Limit the length of the line
  }

  for (int x = 362; x <= 680; x += 20) {
    int startY = 70; // Adjust the starting Y-coordinate
    int endY = startY + 179; // Calculate the ending Y-coordinate
    line(x, startY, x, constrain(endY, startY, height)); // Limit the length of the line
  }
  
  rect(500, 200, 0, 0);
  fill(0);
  textSize(30);
  text("ECG and Breath 479", 230, 30);
  
 // image lungs
 image(myIcon, 600, 75);
}


void graph_serialEvent_lungs(float pressure) {
  count++;
  time = count*0.1;
  lineChartX.append(time);
  lineChartY.append(pressure);
 
  finalLineX.append(time);
  finalLineY.append(pressure);
  xVal = count;
  yVal = pressure;
  
  if (lineChartX.size() > 8 && lineChartY.size() > 8) {
    lineChartX.remove(0);
    lineChartY.remove(0);
  }
  lineChart.setData(lineChartX.array(), lineChartY.array());
}

// buttons

void FitnessMode_Button() {
  // Display a submit button
  fill(61, 187, 245);
  rect(50, 70, 230, 75);
  fill(0);
  text("Fitness Mode", 60, 115);
}

void StressMode_Button() {
  // Display a submit button
  fill(61, 187, 245);
  rect(50, 170, 230, 75);
  fill(0);
  text("Stress Mode", 60, 215);
}

void MeditationMode_Button() {
  // Display a submit button
  fill(61, 187, 245);
  rect(50, 270, 230, 75);
  fill(0);
  text("Meditation Mode",60, 315);
}
void SleepMode_Button() {
  // Display a submit button
  fill(61, 187, 245);
  rect(50, 370, 230, 75);
  fill(0);
  text("Sleep Mode",60, 415);
}

// ECG graph 

// Vital Values Square 

void BreathRate_Square() {
  // Display a submit button
  fill(255);
  pushStyle();
  stroke(20);
  rect(30, 485, 640, 200);
  
  popStyle();
  fill(0);
  textSize(20);
  text("Real Time Respiratory Rate: " + String.format("%.2f", respiratoryRate), 90,530);
  text("Real Time Heartrate: ", 410, 530);
}

void calculateRespiratoryRate(float pressure) {
   //Check for a rising edge (pressure increase)
  if ((!exhale) && prevPressure > pressure) {
    float currentTime = millis();
    float timeDifference = currentTime - prevTime;
    
    // Calculate respiratory rate (in breaths per minute)
    if (timeDifference > 0) {
      respiratoryRate = 60000.0 / timeDifference; // 60 seconds / time difference
      println(respiratoryRate);
    }
    
    prevTime = currentTime;
    exhale = true;
  } else if (exhale && (prevPressure < pressure)) {
    exhale = false; 
  }
  
  prevPressure = pressure;
}
