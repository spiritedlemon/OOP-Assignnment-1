//OOP-Assignment     --     DT 228/2     --     Simon O'Leary ( C15413218 )
//Electronic dashboard for a car which displays speed, fuel level, allows user to change the air conditioning and more
//https://github.com/spiritedlemon/OOP-Assignnment-1



void setup()
{
  size(800, 600);    //I'd suggest a wider screen as it looks better -> size(800,600)
  background(50);    //'50' chosen as it looks better
  home_screen();
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
  
  //Filling in the boxes at base of screen
  PFont f;
  float fontSize = ( (height * width)/13333.33 );   //Font size scales with chosen display dimensions
  f = createFont("Arial", 16, true); // true -> anti-aliasing on
  textFont(f, fontSize);  //sets font size of 'PFont' f
  fill(255);
  
  text("Air Con", width * 0.08f, height * 0.975f);
  text("System", width * 0.425f, height * 0.975f);
  text("Clock", width * 0.785f, height * 0.975f);
  
  fill(0); //Revert fill to black for later shapes
  
  
  //Drawing first gauge (Fuel)
  rect( (width/9), (height/10), (width/9), (height - (height/4) ) );
  //Now the secong gauge (Electricity)
  rect( (width - (width/9 * 2) ), (height/10), width/9 , (height - (height/4) ) );
  
  
  //Filling the gauges --  [(255, 255, 0) -> (255, 0, 0)] [yellow -> Red] 
  color c1, c2, c;
  int i, x, y, x2, y2;
  float amt;
  
  //Gauge one
  c1 = color(255, 255, 0);  //yellow
  c2 = color(255, 0, 0);    //red
  
  x = width/9;
  y = height/10; 
  x2 = width/9; 
  y2 = ( height - height/4 );
  
  //for loop to change the gradient in relation to the y-axis
  for (i = y; i <= y+y2; i++)
   {
     amt = map(i, y, y+y2, 0, 1);  //amt = point between the two colors (float - as its a decimal number)
     c = lerpColor(c1, c2, amt);   
     stroke(c);
     line(x, i, x+x2, i);
   }
  
  
  //Gauge two
  c1 = color(255, 255, 0);  //yellow
  c2 = color(192, 192, 192); //silver
  
  x = (width - (width/9 * 2));
  y = height/10; 
  x2 = width/9; 
  y2 = ( height - height/4 );
  
  //Same for loop again with different location and colors above
  for (i = y; i <= y+y2; i++)
   {
     amt = map(i, y, y+y2, 0, 1);  //amt = point between the two colors (float - as its a decimal number)
     c = lerpColor(c1, c2, amt);   
     stroke(c);
     line(x, i, x+x2, i);
   }
  
  stroke(0, 255, 255);
  fill(0);
  
  
  
  
  //Placing the clock on screen
  
  
  //Displaying speed under the line and time/Date/Temp over it
  //Initial dividing line
  line(width*3/9, height/3, width*6/9, height/3);
  
  //Speed displayed below the line (currently just '00')
  //First number:
  rect(15 + width/3, height/2, width * .135f, height *0.35f );
  
  //Second number:
  rect(width/2 + 15 , height/2, width  * .135f, height *0.35f );
 
  
}//End of home_screen() 




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