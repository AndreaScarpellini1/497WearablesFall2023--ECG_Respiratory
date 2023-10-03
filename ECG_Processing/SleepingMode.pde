void SleepingMode_Draw(){
  
  fill(255);
  rect(0, 0, 700, 700);
  fill(0);
  textSize(15);
  
  rect(500, 200, 0, 0);
  fill(0);
  textSize(30);
  text("Apnea Mode", 260, 30);
  
   myIconApnea=loadImage("apnea.jpeg");
   myIconHome=loadImage("home.png");
   
   myIconHome.resize(60, 60);
   myIconApnea.resize(200,200);
   
  image(myIconHome, 5, 5);
  image(myIconApnea, 240, 50);
}
  
  
  void Count_time_Square() {
  // Display a submit button
  fill(255);
  pushStyle();
  stroke(20);
  rect(30, 270, 640, 160);
  
  popStyle();
  fill(0);
  textSize(20);
  text("Time of Apnea: ",90,300);
  pushStyle();
  textSize(40);
  text(TOA,147,350);
  popStyle();
  text("Number of apnea: ", 410, 300);
  pushStyle();
  textSize(40);
  text(NoA,450,350);
  popStyle();
}


float [] data = new float[100];                        
int currentIndex = 0;      // Keep track of the current index in the array
int zeroCount = 0;         // Initialize the zero count
boolean apnea = false;
float TOA;
float NoA;

void measureApnea(float pressureValue) {
  if (pressureValue == 0) {
    // Increment the consecutive zero count
    int consecutiveZeroes = 1;
    
    // Check for at least 3 consecutive zeroes
    for (int i = 1; i <= 4; i++) {
      int prevIndex = (currentIndex - i + data.length) % data.length;
      if (data[prevIndex] == 0) {
        consecutiveZeroes++;
      } else {
        break;
      }
    }
    
    if (consecutiveZeroes >= 3) {
      apnea = true;
    }
  } else {
    apnea = false;
  }
  
  // Update data array with the new pressure value
  data[currentIndex] = pressureValue;
  
  // Increment the index and wrap around if necessary
  currentIndex = (currentIndex + 1) % data.length;
  
  if (apnea) {
    // Apnea event ended, calculate and update statistics
    TOA += 50;  // Assuming Arduino sends data every 10 ms and 5 consecutive zeroes
    NoA++;
  }
}
