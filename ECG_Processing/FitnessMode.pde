void FitnessMode_Draw(){
  
  fill(255);
  rect(0, 0, 700, 700);
  fill(0);
  
  rect(500, 200, 0, 0);
  fill(0);
  textSize(30);
  text("Fitness Mode", 260, 30);
  
   myIconHome = loadImage("home.png");
   myIconHome.resize(60, 60);
   image(myIconHome, 5, 5);

}
