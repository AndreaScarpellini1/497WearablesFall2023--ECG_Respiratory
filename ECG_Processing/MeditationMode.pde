void MeditationMode_Draw(){
  fill(255);
  rect(0, 0, 700, 700);
  fill(0);
  textSize(15);
  
  rect(500, 200, 0, 0);
  fill(0);
  textSize(30);
  text("Meditation Mode", 260, 30);
  
  if(meditationModeAlert) {
    text("Not Meditating", 260, 200);
  } else {
    text("You are Meditating", 260, 200);
  }
  
   myIconHome = loadImage("home.png");
   myIconHome.resize(60, 60);
  image(myIconHome, 5, 5);

}
