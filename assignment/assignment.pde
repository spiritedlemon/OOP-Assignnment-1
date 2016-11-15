//OOP-Assignment     --     DT 228/2     --     Simon O'Leary ( C15413218 )
//Electronic dashboard for a car which displays speed, fuel level, allows user to change the air conditioning and more
//https://github.com/spiritedlemon/OOP-Assignnment-1


void setup()
{
  size(800, 600);    //I'd suggest a wider screen as it looks better
  background(50);    //'50' chosen as it looks better
  
}

//int time;  //Global variable used in home_screen() and clock()

//Function for screen zero
void home_screen()
{
  stroke(0, 255, 255);
  fill(0);
  
  //Drawing boxes at the base of the screen to navigate to other menus
  rect( 0, (height - (height/10) ), ( width - 1 ), height );
  line( ( width/3), (height - (height/10) ), ( width/3), height);
  line( ( width - (width/3) ), (height - (height/10) ), ( width - (width/3) ), height);
  
  //Filling in the boxes
  
  
  
  //Drawing first gauge (Fuel)
  rect( (width/9), (height/10), (width/9), (height - (height/4) ) );
  //Now the secong gauge (Electricity)
  rect( (width - (width/9 * 2) ), (height/10), width/9 , (height - (height/4) ) );
  
  
  //Filling the gauges --  [(255, 255, 0) -> (255, 0, 0)] [yellow -> Red]
  
  
  
  //Placing the clock on screen
  
  
  //Displaying speed under the line and time/Date/Temp over it
  
  //Initial dividing line
  line(width*3/9, height/3, width*6/9, height/3);
  
  //Speed displayed below the line (currently just '00')
  
  
}

//Function for screen one -- Air conditioning
void ac()
{
  
}

//Function for screen two
void system()
{
  
  
}


//Function for screen three
void clock()
{
  
  
}


void draw()
{
  home_screen();
  
}


/*
//Function to change screens with keys
void keyPressed()
{
  if (key >= '0' && key <='9')
  {
    mode = key - '0';
  }
}

*/