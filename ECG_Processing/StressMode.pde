// Declare variables for the button dimensions
int buttonX = 100, buttonY = 450, buttonWidth = 200, buttonHeight = 75;
int button2x = 450, button2y = 450, button2Width = 200, button2Height = 75;

//boolean variables to check of modes are active
boolean isStressBaselineCalcOn = false;
boolean isCalculateMentalModeOn = false;
boolean isStressBaselineCalBefore = false;
boolean isCalculateMentalModeBefore = false;

//variable to display resting heart rate
float restingStressHeartRate = 0;

//variable to display heart rate during mental test
float averageMentalHeartRate;

//variable displaying time
int startStressTime;
int startMentalTime;
int remainingMentalTime;
int remainingStressTime;

// Declare a List to hold readings
ArrayList<Float> heartRates = new ArrayList<Float>();
ArrayList<Float> mentalHeartRates = new ArrayList<Float>();


//keeping track of last heart rate
int lastReadingTime = 0;

void StressMode_Draw() {
  fill(255);
  rect(0, 0, 700, 700);
  fill(0);
  textSize(15);
  
  //background
  backgroundImage = loadImage("redgreengradiant.png"); // Load your background image
  backgroundImage.resize(width, height); // Resize the background image to match the canvas size
  background(backgroundImage);

  // Draw Circle in the middle of canvas
  int circleX = 350;
  int circleY = 250;
  int circleRadius = 300;

  if (!isCalculateMentalModeOn && !isCalculateMentalModeBefore) {
    fill(255, 255, 204); // Grey
  } else if (isCalculateMentalModeOn) {
    fill(255, 255, 204); // Grey
  } else if (!isCalculateMentalModeOn && isCalculateMentalModeBefore) {
    if (averageMentalHeartRate > restingStressHeartRate * 1.15) {
      fill(255, 0, 0); // Red for Stress
    } else {
      fill(0, 255, 0); // Green for Calm
    }
  }
  
  ellipse(circleX, circleY, circleRadius, circleRadius);

  // Draw the button
  fill(61, 187, 245); // Button color
  rect(buttonX, buttonY, buttonWidth, buttonHeight);
  fill(0); // Text color
  textSize(20);
  
  if (isStressBaselineCalcOn) {
    remainingStressTime = 30 - ((millis() - startStressTime) / 1000);
    
    // Collect heart rate data every second
    if (millis() - lastReadingTime >= 1000) {
      lastReadingTime = millis();
      float currentHeartRate = BPM;
      heartRates.add(currentHeartRate);
    }
  }
  
  if (isCalculateMentalModeOn) {
    remainingMentalTime = 15 - ((millis() - startMentalTime) / 1000);
    
    if (millis() - lastReadingTime >= 1000) {
      lastReadingTime = millis();
      if (BPM > 40) {
      float currentMentalHeartRate = BPM;
      mentalHeartRates.add(currentMentalHeartRate);
      }
    }
    
    if (remainingMentalTime <= 0) {
      endStressMentalMode();
    }
  }
    
  if (remainingStressTime <= 0) {
    endStressBaseline();
  } else {
    text("Calc... " + nf(remainingStressTime, 0) + " Sec", buttonX + 20, buttonY + 40);
  }
  
  if (!isStressBaselineCalcOn && !isStressBaselineCalBefore) {
    pushMatrix();
    textSize(20);
    text("Calculate Baseline", buttonX + 20, buttonY + 40);
    popMatrix();
  } else if (!isStressBaselineCalcOn && isStressBaselineCalBefore) {
    pushMatrix();
    textSize(20);
    text("Rest HR: " + nf(restingStressHeartRate, 0, 2) + " BPM", buttonX + 20, buttonY + 40);
    popMatrix();
  }

  //Draw second button
  fill(61, 187, 245);
  rect(button2x, button2y, button2Width, button2Height);
  fill(0);    
  textSize(20);
  
  if(!isCalculateMentalModeOn && !isCalculateMentalModeBefore){
    text("Calm Vs Stress", button2x + 30, button2y +40);
  } else if(isCalculateMentalModeOn) {
    text("Calc... " + nf(remainingMentalTime, 0) + " Sec", button2x + 30, button2y +40);
  } else if (!isCalculateMentalModeOn && isCalculateMentalModeBefore) {
    if (averageMentalHeartRate > restingStressHeartRate * 1.15) {
      text("Stress", button2x + 30, button2y + 40);
    } else {
      text("Calm", button2x + 30, button2y + 40);
    }
  }
  
  
  //Title
  fill(0);
  textSize(30);
  text("Stress Mode", 260, 30);
  
  myIconHome = loadImage("home.png");
  myIconHome.resize(60, 60);
  image(myIconHome, 5, 5);
}

void calculateStressBaseline() {
  // Your code to calculate the 30-second baseline average
  isStressBaselineCalcOn = true;
  isStressBaselineCalBefore = true;
  startStressTime = millis();
  println("Calculating baseline...");
}

void calculateMentalMode() {
  isCalculateMentalModeOn = true;
  isCalculateMentalModeBefore = true;
  startMentalTime = millis();
  println("Calculating mental state...");
}

void endStressMentalMode() {
  isCalculateMentalModeOn = false;
  
  // Calculate the average mental mode heart rate
  float sum = 0;
  for (float hr : mentalHeartRates) {
    sum += hr;
  }
  averageMentalHeartRate = sum / mentalHeartRates.size();
  mentalHeartRates.clear();
}

void endStressBaseline() {
  isStressBaselineCalcOn = false;           // Set baseline inactive
  
  // Calculate the Average
  float sum = 0;
  for (float hr : heartRates) {
    sum += hr;
  }
  restingStressHeartRate = sum / heartRates.size();
  
  // Reset the List for future calculations
  heartRates.clear();
}
