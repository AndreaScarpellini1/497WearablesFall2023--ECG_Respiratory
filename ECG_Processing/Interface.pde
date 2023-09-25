XYChart breathingLineChart;
XYChart heartrateLineChart;

FloatList breathingLineChartX;
FloatList breathingLineChartY;
FloatList heartrateLineChartX;
FloatList heartrateLineChartY;
FloatList finalLineX;
FloatList finalLineY;

float xVal;
float yVal;
int count =0;
int count_heartrate = 0;
float time=0;

boolean exhale = false; // This variable keeps track of whether the user is exhaling
float prevPressure = 0;
float prevTime = 0;
float respiratoryRate = 0;

PImage myIconLungs;
PImage myIconHeart;

void graph_setup_lungs() {
  
  //icon lungs 
  myIconLungs = loadImage("download.png"); // Load your image file (provide the correct path);
  myIconLungs.resize(60, 60);

  breathingLineChart = new XYChart(this);
  breathingLineChartX = new FloatList();
  breathingLineChartY = new FloatList();
  finalLineX = new FloatList();
  finalLineY = new FloatList();
  breathingLineChart.setData(breathingLineChartX.array(), breathingLineChartY.array());
  //lineColor = color(0, 0, 255);
  
  breathingLineChart.showXAxis(true);
  breathingLineChart.showYAxis(true);
  breathingLineChart.setMinY(0);
  
  breathingLineChart.setYFormat("00");
  breathingLineChart.setXFormat("00.00");
  
  //lineChart.setPointColour(color(0, 255, 0));
  breathingLineChart.setPointSize(5);
  breathingLineChart.setLineWidth(2);
  
  count = 0;
}

void graph_setup_ECG() {
  
  //icon heart 
  myIconHeart = loadImage("heart.jpeg"); // Load your image file (provide the correct path);
  myIconHeart.resize(60, 60);

  heartrateLineChart = new XYChart(this);
  heartrateLineChartX = new FloatList();
  heartrateLineChartY = new FloatList();
  //finalLineX = new FloatList();
  //finalLineY = new FloatList();
  heartrateLineChart.setData(heartrateLineChartX.array(), heartrateLineChartY.array());
  //lineColor = color(0, 0, 255);
  
  heartrateLineChart.showXAxis(true);
  heartrateLineChart.showYAxis(true);
  heartrateLineChart.setMinY(0);
  
  heartrateLineChart.setYFormat("00");
  heartrateLineChart.setXFormat("00.00");
  
  //lineChart.setPointColour(color(0, 255, 0));
  heartrateLineChart.setPointSize(5);
  heartrateLineChart.setLineWidth(2);
  
  count_heartrate = 0;
}



void graph_draw() {
  background(255,255,255);
  textSize(9);
  
  noStroke();
  fill(200);
  breathingLineChart.draw(350, 60, 325,205);
  breathingLineChart.setAxisColour(0);
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
 image(myIconLungs, 600, 75);
  
  //----------------------------------------------------------//
  // Same code as above, but for the ECG chart
  pushStyle();
  noStroke();
  fill(200);
  textSize(9);
  heartrateLineChart.draw(350, 280, 325,205);
  heartrateLineChart.setAxisColour(0);
  fill(0); // Set text color to black
  textSize(15);
  text("Time", 500, 275); // Adjust position as needed
  popStyle();

  pushMatrix();
  translate(100,100);
  rotate(-PI/2); // Rotate by 90 degrees counterclockwise
  textSize(15);   // Set the text size
  fill(0);       // Set text color to black
  text("Breathing Cycle", -100,250); 
  popMatrix();
  
  
  pushStyle();
  //grid 
  stroke(200); // Set the color for grid lines (gray)
  for (int y =300; y <=474; y += 20) {                   // TODO: Fix the horizontal lines by moving it down
    int startX =364;                                     // Adjust the starting X-coordinate
    int endX = startX +300;                              // Calculate the ending X-coordinate
    line(startX, y, constrain(endX, startX, width), y);  // Limit the length of the line
  }

  for (int x = 362; x <= 680; x += 20) {
    int startY = 290; // Adjust the starting Y-coordinate
    int endY = startY + 179; // Calculate the ending Y-coordinate
    line(x, startY, x, constrain(endY, startY, height)); // Limit the length of the line
  }
  popStyle();
  
 // image lungs
 image(myIconHeart, 600, 300);

}

void graph_serialEvent_lungs(float pressure) {
  count++;
  time = count*0.1;
  breathingLineChartX.append(time);
  breathingLineChartY.append(pressure);
 
  finalLineX.append(time);
  finalLineY.append(pressure);
  xVal = count;
  yVal = pressure;
  
  if (breathingLineChartX.size() > 8 && breathingLineChartY.size() > 8) {
    breathingLineChartX.remove(0);
    breathingLineChartY.remove(0);
  }
  breathingLineChart.setData(breathingLineChartX.array(), breathingLineChartY.array());
}

// buttons

void FitnessMode_Button() {
  // Display a submit button
  fill(61, 187, 245);
  rect(50, 70, 230, 75);
  fill(0);
  textSize(30);
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

// Vital Values Display Square 

void BreathRate_Square() {
  // Display a submit button
  fill(255);
  pushStyle();
  stroke(20);
  rect(30, 520, 640, 160);
  
  popStyle();
  fill(0);
  textSize(20);
  text("Real Time Respiratory Rate: ",90,560);
  pushStyle();
  textSize(40);
  text(respiratoryRate,147,630);
  popStyle();
  text("Real Time Heartrate: ", 410, 560);
}

// Function to calculate the respiratory rate of the user
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
