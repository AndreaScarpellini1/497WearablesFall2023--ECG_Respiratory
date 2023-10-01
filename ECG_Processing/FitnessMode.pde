boolean isBaselineActive = false;    // to know if baseline is active or not
int startTime;                       // for storing the starting time of baseline
float restingHeartRate = 0;          // the calculated resting heart rate

int age;

//variable for each time
int timeInResting = 0;
int timeInLow = 0;
int timeInModerate = 0;
int timeInHigh = 0;
int lastTimeChecked = 0;


void FitnessMode_Draw() {
  fill(255);
  rect(30, 65, 280, 425);
  fill(0);
  rect(500, 200, 0, 0);
  fill(0);
  textSize(30);
  text("Fitness Mode", 95, 100);
  myIconHome = loadImage("home.png");
  myIconHome.resize(60, 60);
  image(myIconHome, 5, 5);

  fill(61, 187, 245);
  rect(50, 170, 230, 75);
  fill(0);
  if (isBaselineActive) {
    int remainingTime = 10 - ((millis() - startTime) / 1000);
    if (remainingTime <= 0) {
      endBaseline();
    } else {
      text("Calc... " + nf(remainingTime, 0) + " Sec", 60, 215);
    }
  } else {
    pushMatrix();
    textSize(25);
    text("Rest HR: " + nf(restingHeartRate, 0, 2) + " BPM", 60, 215);
    popMatrix();
  }

  pushMatrix();
  fill(200, 0, 0); // RGB color representation (red)
  rect(50, 275, 230, 40);
  popMatrix();

  pushMatrix();
  fill(0);
  textSize(15);
  text("Hard (80 - 100%)", 50+5, 275+25);
  popMatrix();

  pushMatrix();
  fill(255);
  fill(255, 145, 0); // RGB color representation (orange)
  rect(50, 325, 230, 40);
  popMatrix();

  pushMatrix();
  fill(0);
  text ("Moderate (70 - 80%)", 50+5, 325+25);
  popMatrix();

  pushMatrix();
  fill(255,255,51); // RGB color representation (yellow)
  rect(50, 375, 230, 40);
  popMatrix();

  pushMatrix();
  fill(0);
  text ("Light (60 - 70%)", 50+5, 375+25);
  popMatrix();

  pushMatrix();
  fill(0, 200, 0); // RGB color representation (green)
  rect(50, 425, 230, 40);
  popMatrix();

  pushMatrix();
  fill(0);
  text ("Very Light (50 - 60%)", 50+5, 425+25);
  popMatrix();


  // Display the time spent in each zone
  text("" + nf(timeInHigh/1000) + "s", 250, 300);
  text("" + nf(timeInModerate/1000) + "s", 250, 350);
  text("" + nf(timeInLow/1000) + "s", 250, 400);
  text("" + nf(timeInResting/1000) + "s", 250, 450);
}

void startBaseline() {
  if (!isBaselineActive) {
    isBaselineActive = true;          // Set baseline active
    startTime = millis();             // Store the current time as the starting time
    restingHeartRate = 0;             // Reset resting heart rate
  }
}

void endBaseline() {
  isBaselineActive = false;           // Set baseline inactive
  calculateBPM();
  restingHeartRate= BPM;
}

boolean high = false ;
boolean low = false ;
boolean moderate = false;
boolean resting = true ;

void testTime() {
  if (timeInResting/1000 > 5) {
    resting = false;
    low = true;
  }
  if(timeInLow/1000 > 4) {
    low = false;
    moderate = true;
  }
  if (timeInModerate/1000 > 7) {
    moderate = false;
    high = true;
  }
  if (timeInHigh/1000 > 10) {
    high = false;
    moderate = true;
  }
}

void updateTimeInZones() {
  // Calculate the time elapsed since last checked
  int deltaTime = millis() - lastTimeChecked;

  if (resting) {
    timeInResting += deltaTime;
  } else if (low) {
    timeInLow += deltaTime;
  } else if (moderate) {
    timeInModerate += deltaTime;
  } else if (high) {
    timeInHigh += deltaTime;
  }

  // Update the last time checked
  lastTimeChecked = millis();
}

// once you have to decide the modes based on the baseline
void mode_identification() {

//  int maxHeartRate = 220 - age;
//  float HRR = maxHeartRate - restingHeartRate;
//  float HRP = ((BPM/100)*HRR)+restingHeartRate;


//  if ((0.50*(HRR)+ restingHeartRate) <= HRP && HRP <= (0.60*(HRR)+ restingHeartRate)) {
//      resting = true;
//      high = false ;
//      low = false ;
//      moderate = false;
//  }
//  else if  ((0.60*(HRR)+ restingHeartRate) <= HRP && HRP <= (0.70*(HRR)+ restingHeartRate)){
//      resting = false;
//      high = false ;
//      low = true;
//      moderate = false;
//  }
//  else if  ((0.70*(HRR)+ restingHeartRate) <= HRP && HRP <= (0.80*(HRR)+ restingHeartRate)){
//      resting = false;
//      high = false ;
//      low = false;
//      moderate = true;
//  }
//  else if ((0.80*(HRR)+ restingHeartRate) <= HRP) {
//      resting = false;
//      high = true;
//      low = false;
//      moderate = false;
  //}
}
