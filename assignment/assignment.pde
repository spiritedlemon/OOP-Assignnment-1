//OOP-Assignment     --     DT 228/2     --     Simon O'Leary ( C15413218 )

//Electronic dashboard for a car which displays speed, fuel level, allows user to change the air conditioning and more

//https://github.com/spiritedlemon/OOP-Assignnment-1



void setup()
{
  size(800, 600);    //I'd suggest a wider screen as it looks better -> size(800,600)
  background(50);    //'50' (gray) looks better than just black
  
}

//Global Variables

int timeH = hour();      //Hour  --  Global variables used in home_screen() and clock()
int timeM = minute();    //Minute

int day = day();                 //Global variables used in home_screen() and clock()
int month = month();
int year = year();

int tempEX= -10;    //Changes the color of the font based on temperature --  range of '-10' to '40' --  Read in from file
int tempINT= 0;     //Temperature used in ac() and system() -- Temperature of inside the car

int spacing = 5; //( (height * width)/96000 );    //This is used to space out displays of time, date and temp primarily -- It = ~5 on the recommended size setting (800, 600)

int speed = 0; //Speed in km/h  --  Read in from file

int screen = 1; //Menu selection -- 0=home, 1=ac(), 2=system(), 3=clock()



//Function for screen zero
void home_screen()
{
  background(50);
  stroke(0, 255, 255);  //cyan
  fill(0);
  
  
  //Drawing boxes at the base of the screen to navigate to other menus
  rect( 0, (height - (height/10) ), ( width - 1 ), height/10 );
  line( ( width/3), (height - (height/10) ), ( width/3), height);
  line( ( width - (width/3) ), (height - (height/10) ), ( width - (width/3) ), height);
  
  //Filling in the boxes at base of screen
  PFont f;
  float fontSize = ( (height * width)/13333.33 );   //Font size scales with chosen display dimensions
  f = createFont("Arial", 16, true); // true -> anti-aliasing on
  textFont(f, fontSize);  //sets font size of 'PFont' f
  fill(255);
  
  text("Air Con", width * 0.15f, height * 0.975f);
  
  text("System", width * 0.5f, height * 0.975f);
  
  text("Clock", width * 0.825f, height * 0.975f);
  
  
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
  
  /*
  'Tool Tips' for two gauges  --  Scrapped temporarily
  Fuel first:
  if( (mouseX > width/9) && (mouseX < 2*width/9) && (mouseY < height * 0.85f) && (mouseY > height * 0.1f) ) {}
  */
  
  
  
  
  
  //'Center Line' - Divides up the home screen
  line(width*3/9, height/3, width*6/9, height/3);
  
  
  //Displaying text above the center line  --  All this was implemented above, i'm leaving it here for clarity
  
  //PFont f;
  //float fontSize = ( (height * width)/13333.33 );   //Font size scales with chosen display dimensions
  //f = createFont("Arial", 16, true); // true -> anti-aliasing on
  //textFont(f, fontSize);  //sets font size of 'PFont' f
  
  fill(255);
  
  //For the time
  textAlign(RIGHT);
  if(timeH > 9)  //If time is < 10 it only displays one digit so this if statement should solve it
  {
    text(timeH, width/2 - (spacing*2), height * 0.1f);
  }
  else
  {
    text('0', width/2 - (spacing*2), height * 0.1f);
    text(timeH, width/2 - (spacing*6), height * 0.1f);
  }
  
  textAlign(LEFT);
  if(timeM > 9)    //If time is < 10 it only displays one digit so this if statement should solve it
  {
    text(timeM, width/2 + (spacing*2), height * 0.1f);
  }
  else
  {
    text('0', width/2 + (spacing*2), height * 0.1f);
    text(timeM, width/2 + (spacing*6), height * 0.1f);
  }
  
  textAlign(CENTER);
  text(" : ", width/2, height * 0.1f);
  
  
  //Displaying the Date
  textAlign(RIGHT);
  text(day, width/2 - (spacing*9), height * 0.2f);
  textAlign(CENTER);
  text("/", width/2 - (spacing*7), height * 0.2f);
  textAlign(CENTER);
  text(month, width/2 - (spacing*2), height * 0.2f);
  textAlign(CENTER);
  text("/", width/2 + (spacing*3), height * 0.2f);
  textAlign(LEFT);
  text(year, width/2 + (spacing*5), height * 0.2f);
  
  
  //Displaying temp 
  textAlign(LEFT);
  text("'C", width/2 + (spacing), height * 0.3f);
  
  
  int scaleT1 = 0;
  int scaleT2 = 0;    //Variables used to change the color of the text based on current temperature
  
  scaleT1 = (tempEX + 10) * 5;  //Current temp +10 (to avoid negatives) and then *5 (used for changing the color)
  scaleT2 = 250 - scaleT1;
  
  textAlign(RIGHT);
  if(tempEX>= -10 && tempEX<= 40)
  {
    fill(scaleT1, 0, scaleT2);
    text(tempEX, width/2 - (spacing), height * 0.3f);
  }
  else
  {
    text("--", width/2 - (spacing), height * 0.3f);
  }
  
  
  
  
  
  
  fill(0, 255, 255);
  //Speed displayed below the line using the text() function
  
  fontSize = 256;   //Font size scales with chosen display dimensions
  textFont(f, fontSize);  //sets font size of 'PFont' f
  
  textAlign(CENTER);
  if(speed > -1 && speed < 221)
  {
    text(speed, width/2, height * .75f);
  }
  else
  {
    text("ERR", width/2, height * .75f);
  }
  
  
}//End of home_screen() 




//Function for screen one -- Air conditioning
void ac()
{
   stroke(65, 105, 255);
   background(50);
   fill(0);
   
   //Button at bottom to return to the home screen
   rect( 0, (height - (height/10) ), ( width - 1 ), (height/10) );
   
   //Setting font size and style for the home button
  PFont f;
  float fontSize = ( (height * width)/13333.33 );   //Font size scales with chosen display dimensions
  f = createFont("Arial", 48, true); // true -> anti-aliasing on
  textFont(f, fontSize);  //sets font size of 'PFont f'
  fill(255);  //Color of word (white)
  
  //Center and print the word
  textAlign(CENTER);
  text("Home", width/2, height * 0.97f);
  
  
  
  //Now create a display in middle of screen for the temperature
  fill(0);
  rect( (2 * width/6), (3 * height/8), (2 * width/6), (3* height/8) );
  
  rect( (width/6), (3* height/8), (width/6), (3*height/8) );
  rect( (4 * width/6), (3* height/8), (width/6), (3*height/8) );
  
  //Print the temperature into the box in the middle of the screen
  fontSize = ( (height * width)/3000 );
  textFont(f, fontSize);  //sets font size of 'PFont f'
  fill(255);
  textAlign(CENTER);
  text(tempINT, (width/2), (5.25f*height/8) );
  
  
  
  
  
  //Create two more buttons for defrosting front and rear windshield
  fill(0);
  rect( (width/6), (height/10), (width/6), (2 * height/10) );
  rect( (4 * width/6), (height/10), (width/6), (2 * height/10) );
}





//Function for screen two  --  System analysis
void system()
{
    stroke(255, 69, 0);
   background(50);
   fill(0);
   
   //Button at bottom to return to the home screen
   rect( 0, (height - (height/10) ), ( width - 1 ), (height/10) );
   
   //Setting font size and style for the home button
  PFont f;
  float fontSize = ( (height * width)/13333.33 );   //Font size scales with chosen display dimensions
  f = createFont("Arial", 48, true); // true -> anti-aliasing on
  textFont(f, fontSize);  //sets font size of 'PFont f'
  fill(255);  //Color of word (white)
  
  //Center and print the word
  textAlign(CENTER);
  text("Home", width/2, height * 0.97f);
}
   
   
   
   

//Function for screen three  --  Settings
void clock()
{
    stroke(200, 0, 200);
   background(50);
   fill(0);
   
   //Button at bottom to return to the home screen
   rect( 0, (height - (height/10) ), ( width - 1 ), (height/10) );
   
   //Setting font size and style for the home button
  PFont f;
  float fontSize = ( (height * width)/13333.33 );   //Font size scales with chosen display dimensions
  f = createFont("Arial", 48, true); // true -> anti-aliasing on
  textFont(f, fontSize);  //sets font size of 'PFont f'
  fill(255);  //Color of word (white)
  
  //Center and print the word
  textAlign(CENTER);
  text("Home", width/2, height * 0.97f);
}


void draw()
{
  
  switch(screen)
  {
    case 0:
      home_screen();
      break;
      
    case 1:
      ac();
      break;
      
    case 2:
      system();
      break;
      
    case 3:
      clock();
      break;
    
  }
  
}

void mousePressed()    //This function is used to navigate through all the different screens using the buttons at the bottom of the screen
{
  
   if( (mouseX < (width/3) ) && (mouseY > (height * 0.9f) ) )
    {
        if(screen == 0)
        {
          println("In ac() now");     //Alerting user which function currently is in use  --  Mainly for eror checking
          screen = 1;
        }
        else
        {
          println("In home_screen() now");
          screen = 0;
        }
    }
    else if( (mouseX > (width/3) ) && (mouseX < (2 * width/3) ) && (mouseY > (height * 0.9f) ) )
    {
        if(screen == 0)
        {
          println("In system() now");
          screen = 2;
        }
        else
        {
          println("In home_screen() now");
          screen = 0;
        }
    }
    else if( (mouseX > (2 * width/3) ) && (mouseY > (height * 0.9f) ) )
    {
        if(screen == 0)
        {
          println("In clock() now");
          screen = 3;
        }
        else
        {
          println("In home_screen() now");
          screen = 0;
        }
    }
  
}

void mouseClicked()  //This function is used in the ac() function to alter variables using the mouse
{
  
}


//Function to change screens with keys
void keyPressed()
{
  if (key >= '0' && key <='3')
  {
    screen = key - '0';
    println(screen);
  }
  else
  {
    println("Not Available");
  }
  
}