boolean isBaselineActive = false;    // to know if baseline is active or not
int startTime;                       // for storing the starting time of baseline
float restingHeartRate = 0;          // the calculated resting heart rate

int age; 

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
  fill(180, 0, 255); // RGB color representation (purple)
  rect(50, 275, 230, 40);
  popMatrix();
  
  pushMatrix();
  fill(0);
  textSize(15);
  text("High Activation",50+5, 275+25);
  popMatrix();
  
  pushMatrix();
  fill(255);fill(255, 0, 0); // RGB color representation (red)
  rect(50, 325, 230, 40);
  popMatrix();
  
  pushMatrix();
  fill(0); // RGB color representation (orange)
  text ("Moderate Activation",50+5, 325+25);
  popMatrix();
  
  pushMatrix();
  fill(255, 255, 0); // RGB color representation (yellow)
  rect(50, 375, 230, 40);
  popMatrix();
  
  pushMatrix();
  fill(0);
  text ("Low Activation",50+5, 375+25);
  popMatrix();
  
  pushMatrix();
  fill(0, 255, 0); // RGB color representation (green)
  rect(50, 425, 230, 40);
  popMatrix();
  
  pushMatrix();
  fill(0);
  text ("Resting State",50+5, 425+25);
  popMatrix();
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
boolean resting = false ; 

// once you have to decide the modes based on the baseline 
void mode_identification(){
  
  int maxHeartRate = 220 - age;
  float HRR = maxHeartRate - restingHeartRate;
  float HRP = ((BPM/100)*HRR)+restingHeartRate;
  
  if ((0.50*(HRR)+ restingHeartRate) <= HRP && HRP <= (0.60*(HRR)+ restingHeartRate)) {
      resting = true;
      high = false ;
      low = false ;
      moderate = false; 
  }
  else if  ((0.60*(HRR)+ restingHeartRate) <= HRP && HRP <= (0.70*(HRR)+ restingHeartRate)){
      resting = false;
      high = false ;
      low = true;
      moderate = false; 
  }
  else if  ((0.70*(HRR)+ restingHeartRate) <= HRP && HRP <= (0.80*(HRR)+ restingHeartRate)){
      resting = false;
      high = false ;
      low = false;
      moderate = true; 
  }
  else if ((0.80*(HRR)+ restingHeartRate) <= HRP) {
      resting = false;
      high = true;
      low = false;
      moderate = false; 
  }
}
