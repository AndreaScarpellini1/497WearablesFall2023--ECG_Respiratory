int medHRStartTime;                       // start time of baseline heart rate calculation
int medBreathStartTime;                   // start time of baseline breath rate calculation
boolean isMedHRBaselineActive = false;    // to know if heart rate baseline is active or not
boolean isMedBreathBaselineActive = false; // to know if breathing rate baseline is active or not
float medRestingHeartRate = 0; // Resting heart rate for meditation mode
float medRestingRespiratoryRate = 0; // Resting respiratory rate for meditation mode

float circleRadius = 100; // Initial radius of the circle
float growthSpeed = 0.5;   // Rate at which the circle expands
float shrinkSpeed = 0.165; // Rate at which the circle shrinks
boolean growing = true;  // Flag to track if the circle is expanding or shrinking

PImage backgroundImage;

void MeditationMode_Draw(){
  fill(255);
  rect(0, 0, 700, 700);
  fill(0);
  textSize(15);
  
  // Adds background image to meditation mode
  backgroundImage = loadImage("blue-purple.jpeg"); // Load your background image
  backgroundImage.resize(width, height); // Resize the background image to match the canvas size
  background(backgroundImage);
  
  rect(500, 200, 0, 0);
  fill(0);
  textSize(30);
  text("Meditation Mode", 250, 30);
  
  // Displays meditation alert 
  if(meditationModeAlert) {
    pushStyle();
    textSize(25);
    fill(255,0,0);
    text("You are not Meditating", 235, 125);
    popStyle();
  } else {
    pushStyle();
    textSize(25);
    fill(255, 255, 51);
    text("You are Meditating", 255, 125);
    popStyle();
  }
  
  // Adds the home button icon
  myIconHome = loadImage("home.png");
  myIconHome.resize(60, 60);
  image(myIconHome, 5, 5);
  
  // Create rectangle around buttons and around meditation alert
  pushStyle();
  noFill(); // Set the fill to transparent (no color)
  stroke(0); // Set the border color to black
  //rect(50, 550, 600, 125); // rectangle around the buttons
  //rect(227, 87, 250, 60); // rectangle around the meditation alert
  popStyle();
  
  // Call the functions to create the resting heart and breath rate button
  createHeartRateButton();
  createBreathRateButton();
  
  // Calls function to draw the circle
  createCircle();
}

// Create the button for the calculation/resting heart rate display
void createHeartRateButton() {
  fill(61, 187, 245);
  rect(75, 575, 230, 75);
  fill(0);
  // Checks if the heart rate baseline is calculating
  if (isMedHRBaselineActive) {
    textSize(30);
    int remainingTime = 10 - ((millis() - medHRStartTime) / 1000);
    if (remainingTime <= 0) {
      medEndHRBaseline();
    } else {
      text("Calc... " + nf(remainingTime, 0) + " Sec", 115, 625);
    }
  } else {
    pushMatrix();
    textSize(25);
    text("Rest Heart Rate: ", 105, 610);
    text(nf(medRestingHeartRate, 0, 2) + " BPM", 142, 640);
    popMatrix();
  }
}

// Create the button for the calculation/resting respiratory rate display
void createBreathRateButton() {
  fill(61, 187, 245);
  rect(375, 575, 245, 75);
  fill(0);
  // Checks if the respiratory baseline is calculating
  if (isMedBreathBaselineActive) {
    textSize(30);
    int remainingTime = 10 - ((millis() - medBreathStartTime) / 1000);
    if (remainingTime <= 0) {
      medEndBreathBaseline();
    } else {
      text("Calc... " + nf(remainingTime, 0) + " Sec", 420, 625);
    }
  } else {
    pushMatrix();
    textSize(25);
    text("Rest Respiratory Rate: ", 385, 610);
    text(nf(medRestingRespiratoryRate, 0, 2) + " BPM", 450, 640);
    popMatrix();
  }
}

// Functions to draw the inhale/exhale circle
void createCircle() {
  fill(51, 255, 197);
  
  // Draw the circle
  ellipse(width / 2, height / 2, circleRadius * 2, circleRadius * 2);
  
  // Update the circle's radius
  if (growing) {
    circleRadius += growthSpeed;
    if (circleRadius >= 150) {
      growing = false; // Stop growing and start shrinking when it reaches a certain size
    }
  } else {
    circleRadius -= shrinkSpeed;
    if (circleRadius <= 75) {
      growing = true; // Stop shrinking and start growing when it reaches the original size
    }
  }
  
  // Add text
  pushStyle();
  textSize(24); // Set the text size
  fill(0);      // Set the text color to black
  textAlign(CENTER, CENTER); // Center the text
  if (growing) {  
    text("Inhale", width / 2, height - 350); // Display the text
  } else {
    text("Exhale", width / 2, height - 350); // Display the text
  }
  popStyle();
}

// Function to start the meditation heartrate baseline calculation
void medStartHRBaseline() {
  if (!isMedHRBaselineActive) {
    isMedHRBaselineActive = true;          // Set baseline active
    medHRStartTime = millis();             // Store the current time as the starting time
    medRestingHeartRate = 0;             // Reset resting heart rate
  }
}

// Function to end the meditation heartrate baseline calculation
void medEndHRBaseline() {
  isMedHRBaselineActive = false;           // Set baseline inactive
  calculateBPM();                        // TODO: Fix this to work with meditation
  medRestingHeartRate= BPM;
}

// Function to start the meditation respiratory baseline calculation
void medStartBreathBaseline() {
  if (!isMedBreathBaselineActive) {
    isMedBreathBaselineActive = true;          // Set baseline active
    medBreathStartTime = millis();             // Store the current time as the starting time
    medRestingRespiratoryRate = 0;             // Reset resting heart rate
    respiratoryRateList.clear();
  }
}

// Function to end the meditation respiratory baseline calculation
void medEndBreathBaseline() {
  isMedBreathBaselineActive = false;           // Set baseline inactive
  medRestingRespiratoryRate= calculateRestingRespiratoryRate(); // Calls function to calculate resting respiratory rate
}
