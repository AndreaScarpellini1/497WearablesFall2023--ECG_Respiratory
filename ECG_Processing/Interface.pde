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
float time_breathing=0;
float time_heartrate=0;
float bpm =0;
PImage myIconLungs;
PImage myIconHeart;
PImage myIconHome;

boolean FitnessMode = false;
boolean MeditationMode = false;
boolean StressMode = false;
boolean SleepingMode = false;


// respiratory rate 
boolean exhale = false; // This variable keeps track of whether the user is exhaling
float prevPressure = 0;
float prevTime = 0;
float respiratoryRate = 0;


// heart rate
ArrayList<Float> ecgData = new ArrayList<Float>();
int lastPeakIndex = -1;
float peakThreshold = 620; // Adjust this threshold as needed
float BPM = 0;
float lastTime = 0;


//############################################################################################
void graph_setup_lungs() {
  //icon lungs 
  myIconLungs = loadImage("download.png"); // Load your image file (provide the correct path);
  myIconLungs.resize(60, 60);

  breathingLineChart = new XYChart(this);
  breathingLineChartX = new FloatList();
  breathingLineChartY = new FloatList();
  breathingLineChart.setData(breathingLineChartX.array(), breathingLineChartY.array());
  
  
  breathingLineChart.showXAxis(true);
  breathingLineChart.showYAxis(true);
  breathingLineChart.setMinY(0);
  
  breathingLineChart.setYFormat("00");
  breathingLineChart.setXFormat("00.00");
  
  breathingLineChart.setPointColour(color(0, 255, 0));
  breathingLineChart.setPointSize(5);
  breathingLineChart.setLineWidth(2);
  
  count = 0;
}
//############################################################################################
void graph_setup_ECG() {  
  //icon heart 
  myIconHeart = loadImage("heart.jpeg"); // Load your image file (provide the correct path);
  myIconHeart.resize(60, 60);

  heartrateLineChart = new XYChart(this);
  heartrateLineChartX = new FloatList();
  heartrateLineChartY = new FloatList();
  heartrateLineChart.setData(heartrateLineChartX.array(), heartrateLineChartY.array());

  heartrateLineChart.showXAxis(true);
  heartrateLineChart.showYAxis(true);
  heartrateLineChart.setMinY(0);
  
  heartrateLineChart.setYFormat("00");
  heartrateLineChart.setXFormat("00.00");
  
  heartrateLineChart.setPointColour(color(0, 255, 0));
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
  text("Time (seconds)", 465, 275); // Adjust position as needed

  pushMatrix();
  translate(100,100);
  rotate(-PI/2); // Rotate by 90 degrees counterclockwise
  textSize(15);   // Set the text size
  fill(0);       // Set text color to black
  text("Pressure", -100,240); 
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
  text("Time (seconds)", 465, 500); // Adjust position as needed
  popStyle();

  pushMatrix();
  translate(100,100);
  rotate(-PI/2); // Rotate by 90 degrees counterclockwise
  textSize(15);   // Set the text size
  fill(0);       // Set text color to black
  text("Voltage (mv)", -325,240); 
  popMatrix();
  
  
  pushStyle();
  //grid 
  stroke(200); // Set the color for grid lines (gray)
  for (int y =300; y <=474; y += 20) {                  
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
//##########################################################################################################
void graph_serialEvent_lungs(float pressure) {
  count++;
  time_breathing = count*0.01;
  breathingLineChartX.append(time_breathing);
  breathingLineChartY.append(pressure); 
  xVal = count;
  yVal = pressure;
  if (breathingLineChartX.size() > 8 && breathingLineChartY.size() > 8) {
    breathingLineChartX.remove(0);
    breathingLineChartY.remove(0);
  }
  breathingLineChart.setData(breathingLineChartX.array(), breathingLineChartY.array());
}
// #############################################################################################################
void graph_serialEvent_heart(float  ECG) {
  count_heartrate++;
  time_heartrate = count_heartrate*0.01;
  heartrateLineChartX.append(time_heartrate);
  heartrateLineChartY.append(ECG);
  xVal = count_heartrate;
  yVal = ECG;
  if (heartrateLineChartX.size() > 8 && heartrateLineChartY.size() > 8) {
    heartrateLineChartX.remove(0);
    heartrateLineChartY.remove(0);
  }
  heartrateLineChart.setData(heartrateLineChartX.array(), heartrateLineChartY.array());
}

// -------------------------------------------------------------------------------------------------- BUTTONS 
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
  pushStyle();
  textSize(40);
  text(BPM,450,630);
  popStyle();
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

// Function to calculate the heart rate of the user
void calculateHeartRate(float ecgValue) {
  ecgData.add(ecgValue);
  float currentTime = millis() / 1000.0; // Convert milliseconds to seconds
  float deltaTime = currentTime - lastTime;

  if (ecgData.size() >= 2) {
    // Check for peaks
    for (int i = 1; i < ecgData.size() - 1; i++) {
      float prev = ecgData.get(i - 1);
      float current = ecgData.get(i);
      float next = ecgData.get(i + 1);
      if (current > prev && current > next && current > peakThreshold && current < 700 ) {
        if (i - lastPeakIndex > 1) {
          float timeSinceLastPeak = currentTime - lastTime;
          if (timeSinceLastPeak > 0) {
            BPM = 60.0 / timeSinceLastPeak; // Heart rate in beats per minute
            lastTime = currentTime;
            lastPeakIndex = i;
            break; // Only count the first peak in this cycle
          }
        }
      }
    }
  }
  // Remove old data to limit memory usage (e.g., keep the last 10 seconds of data)
  while (ecgData.size() > 0 && (currentTime - (lastTime - (ecgData.size() - 1) * deltaTime)) > 30) {
    ecgData.remove(0);
  }
}

// Pressing the mouse 
boolean isButtonPressed(float x, float y, float w, float h) {
  return mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h && mousePressed;
}

void mousePressed() {
 if (isButtonPressed(50, 70, 230, 75)) {
     FitnessMode = true;
     MeditationMode = false; 
     StressMode = false;
     SleepingMode = false;
  }
  
  if (isButtonPressed(50, 170, 230, 75)) {
     MeditationMode = false;
     FitnessMode= false;
     SleepingMode = false; 
     StressMode = true;
  }
  
  if (isButtonPressed(50, 270, 230, 75)) {
     StressMode = false;
     FitnessMode = false;
     SleepingMode = false;
     MeditationMode = true;
  }
  
  if (isButtonPressed(50, 370, 230, 75)) {
     SleepingMode = true;
     StressMode = false;
     FitnessMode = false;
     MeditationMode = false ;
  }
     
  if (SleepingMode == true ||  StressMode == true || FitnessMode== true || MeditationMode == true){
    if (isButtonPressed(5, 5, 60, 60)) {
       MeditationMode = false ;
       FitnessMode= false;
       SleepingMode = false ; 
       StressMode = false;
    }
   }       
}
