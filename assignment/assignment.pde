//OOP-Assignment     --     DT 228/2     --     Simon O'Leary ( C15413218 )



void setup()
{
  size(700, 500);    //I'd suggest a wider screen as it looks better
  background(0);
  
}

//Function for screen zero
void home_screen()
{
  stroke(0, 255, 255);
  fill(0);
  
  //Drawing boxes at the base of the screen to navigate to other menus
  rect( 0, (height - (height/10) ), ( width - 1 ), height );
  line( ( width/3), (height - (height/10) ), ( width/3), height);
  line( ( width - (width/3) ), (height - (height/10) ), ( width - (width/3) ), height);
  
  //Drawing first gauge (Fuel)
  rect( (width/9), (height/10), (width/9), (height - (height/4) ) );
  //Now the secong gauge (Electricity)
  rect( (width/9), (height/10), (width - width/9), (height - height/4)   );
  //rect( (width - (width/9 * 2) ), (height/10), (width - width/2), (height - (height/4) ) );
}

//Function for screen one
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