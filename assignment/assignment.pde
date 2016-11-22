//OOP-Assignment     --     DT - 228/2     --     Simon O'Leary ( C15413218 )

//Electronic dashboard for a car which displays speed, sate, time, etc and allows user to change the air conditioning, 
//see some details about the car and change a number of settings

//https://github.com/spiritedlemon/OOP-Assignnment-1

//See the 'README.txt' for more details on this assignment!



/*
  Features to add:
  Finish date()  --  mousePressed() stuff :(
  Read in 2/3 things (Class)
  Fix system() and have them light up
  
  Fill out the README.txt


*/



//***Global Variables***

int spacing = ( (height * width)/1920 );    //This is used to space out displays of time, date and temp primarily -- It = ~5 on the recommended size setting (800, 600)
//int spacing = ( (height * width)/96000 ); 

float randlvl = random(1, 4);       //Used to give a random level to the fuel meter, because no one ever has 100% fuel always
float tyreP = random(165, 200);      //Used to assign random value for tyre pressure
int tyrePi = int(tyreP);            //Converted to int to display in a text() statement

int day = day();         //Global variables used in home_screen() and date()
int month = month();
int year = year();

int tempEX = 0;    //Changes the color of the font based on temperature --  range of '-10' to '40' --  Read in from file
int tempINT = 20;     //Temperature used in ac() and system() -- Temperature of inside the car  --  range of '16' to '28'

int speed = 0; //Speed in km/h  --  Read in from file

int screen = 2; //Menu selection -- 0=home_screen(), 1=ac(), 2=system(), 3=date()

//Variables used to display whether the windows are defrosting or not
int front = 0;
int rear = 0;

int totalkm = 5000;      //Total KM travelled by the car          -- system()
float servicef = random(3000, 20000);      //Next service in this many kilometers  -- system()  -- Randomized for fun :)
int service = int(servicef);               //Converts to an int
int enginetemp = 0;      //system()  --  Used to display engine temp which will slowly rise to a normal temperature
float eleclvl = 25;    //Starts at 25 and increments every second  --  home_screen()



void setup()
{
  size(800, 600);    //I'd suggest a wider screen as it looks better -> size(800,600)
  background(50);    //'50' (gray) looks better than just black
  
  if(service <= 5000)
  {
    println("Service due in: ");
    println(service);
  }
}



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
  
  text("Settings", width * 0.825f, height * 0.975f);
  
  
  
  
  
  
  
  //Drawing first gauge (Fuel)
  rect( (width/9), (height/10), (width/9), (height - (height/4) ) );
  //Now the secong gauge (Electricity)
  rect( (width - (width/9 * 2) ), (height/10), width/9 , (height - (height/4) ) );
  
  //Labelling the gauges
  text("Fuel", (3*width/18), height/10 - 10 );
  text("Elec", (15*width/18), height/10 - 10 );
  fill(0); //Revert back to black for later shapes
  
  
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
   
   stroke(0);
  
  //Adding a random element to the fuel gauge:  --  randlvl is called initialised globally to prevent changing 60x a second
  rect( (width/9), (height/10), (width/9), (height - (height/randlvl) ) );
  
  
  
  
  //Gauge two
  c1 = color(255, 255, 0);  //yellow
  c2 = color(192, 192, 192); //silver
  
  x = (width - (width/9 * 2));  //Starts 7/9ths in
  y = height/10; 
  x2 = width/9;                 //Ends one nineth later
  y2 = ( height - height/4 );
  
  //Same for loop again with different location and colors above
  for (i = y; i <= y+y2; i++)
   {
     amt = map(i, y, y+y2, 0, 1);  //amt = point between the two colors (float - as its a decimal number)
     c = lerpColor(c1, c2, amt);   
     stroke(c);
     line(x, i, x+x2, i);
   }
  
   
   //The elec. bar/gauge fills slowly over time
  stroke(0);
  
  //increments eleclvl every second
  if(frameCount %60 == 0)
  {
    if(eleclvl < 100)
    {
      eleclvl++;
    } 
  }
  
  
  float eleclvlf =  map(eleclvl, 25, 100, 0, 0.5);     //Used to vary the size of the rectangle covering the elec meter to display that eleclvl is increasing
  
  rect((width - (width/9 * 2)), height*0.1f, width/9, height*(0.5f-eleclvlf));
  
  
  
  stroke(0, 255, 255);
  
  
  //'Center Line' - Divides up the home screen
  line(width*3/9, height/3, width*6/9, height/3);
  
  
  //Displaying text above the center line  --  All this was implemented above, i'm leaving it here for clarity
  
  //PFont f;
  //float fontSize = ( (height * width)/13333.33 );   //Font size scales with chosen display dimensions
  //f = createFont("Arial", 16, true); // true -> anti-aliasing on
  //textFont(f, fontSize);  //sets font size of 'PFont' f
  
  fill(255);
  
  //For the time
  
  int timeH = hour();      //Hour  
  int timeM = minute();    //Minute
  
  textAlign(RIGHT);
  if(timeH > 9)  //If time is < 10 it only displays one digit so this if statement should solve it
  {
    text(timeH, width/2 - (spacing*2), height * 0.1f);
  }
  else
  {
    text('0', width/2 - (spacing*2), height * 0.1f);
    text(timeH, width/2 - (spacing*6), height * 0.1f);    //Reminder spacing = ~5 on recommended size  --  Should scale to bigger and smaller screens
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
  text(day, width/2 - (spacing*9), height * 0.2f);    //Reminder spacing = ~5 on recommended size  --  Should scale to bigger and smaller screens
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
    fill(255);
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
  
  
  
  //Now create a display in middle of screen for the temperature  --  See mouseClicked() for the code to change the 'tempINT' variable using the arrows
  fill(0);
  rect( (2 * width/6), (3 * height/8), (2 * width/6), (3* height/8) );
  
  //Arrows to change the temp when clicked  --  first draw the boxes
  rect( (width/6), (3* height/8), (width/6), (3*height/8) );
  rect( (4 * width/6), (3* height/8), (width/6), (3*height/8) );
  
  //Now draw the arrows 
  fill(255, 0, 0);
  triangle( (8.5*width/12), (5.75*height/8), (8.5*width/12), (5*height/12), (9.5*width/12), (4.5*height/8) );
  fill(0, 100, 255);
  triangle( (3.5*width/12), (5.75*height/8), (3.5*width/12), (5*height/12), (2.5*width/12), (4.5*height/8) );
  
  
  //Print the temperature into the box in the middle of the screen  
  fontSize = ( (height * width)/3000 );
  textFont(f, fontSize);  //sets font size of 'PFont f'
  textAlign(CENTER);
  fill(255);
  text(tempINT, (width/2), (5.25f*height/8) );
  
  
  
  
  //Create two more buttons for defrosting front and rear windshield -- For on click actions see mouseClicked()
  fill(0);
  rect( (2*spacing), (height/10), (width/6), (2 * height/10) );                 //Reminder: spacing = ~5px on recommended size  --  Should scale to bigger and smaller screens
  rect( (5 * width/6) - (2*spacing), (height/10), (width/6), (2 * height/10) );
  
  
  //Label the two buttons created above ^^
  fill(255);
  fontSize = ( (height * width)/13333.33 );
  textFont(f, fontSize);  //sets font size of 'PFont f'
   textAlign(CENTER);
  
  text("Front",  width/12, 2*height/10);
  text("Rear",  11*width/12, 2*height/10);
  
  
  
  //Display the current status of the front and rear windshield (defrosting or not)  -- For on click actions see mouseClicked()
  
  if(front == 0)
  {
    text("Front Windshield Defrost: OFF", width/2, height/6);
  }
  else if(front == 1)
  {
    text("Front Windshield Defrost: ON", width/2, height/6);
  }
  
  if(rear == 0)
  {
     text("Rear Windshield Defrost: OFF", width/2, height/4);
  }
  else if(rear == 1)
  {
    text("Rear Windshield Defrost: ON", width/2, height/4);
  }
  
  
  
}





//Function for screen two  --  System analysis
void system()
{
   stroke(255, 69, 0);  //orange
   background(50);  //gray
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
  
  
  //Center line vertically down the screen
  line( width/2, height/4, width/2, 3*height/4 );
  
  
  //Print the range of temperatures along the gauge
  fontSize = ( (height * width)/15000 );
  textFont(f, fontSize);
  
  textAlign(CENTER);
  text("50'C", width/10, height/10 - spacing);  //Reminder: spacing is a global variable that scales based onheight and width and == ~5 on (800, 600)
  text("Engine Temperature", width/2, height/10 - 2*spacing);
  text("130'C", 9*width/10, height/10 - spacing);
  
  
  //Engine Temperature gauge    Engine temperature:    50 - 130  --  90 avg
  fill(0);
  rect( (width/10), height/10, (8 * width/10), height/10);
  
  //Similar to the two gauges from above:
  
  //Filling the gauge --  [(0, 0, 255) -> (255, 0, 0)] [Blue -> Red] 
  color c1, c2, c;
  int i, x, y, x2, y2;
  float amt;
  
  c1 = color(0, 0, 255);    //Blue
  c2 = color(255, 0, 0);    //red
  
  x = width/10;
  y = height/10; 
  x2 = (8*width/10); 
  y2 = height/10;
  
  //for loop to change the gradient in relation to the x-axis
   for (i = x; i <= x+x2; i++) 
   {
      amt = map(i, x, x+x2, 0, .7);    
      c = lerpColor(c1, c2, amt);
      stroke(c);
      line(i, y, i, y+y2);
   }//end for loop
  
  
  
  //increments engine temp every second
  if(frameCount %60 == 0)
  {
    
    if(enginetemp < 90)
    {
       enginetemp++;
    }
    
  }
  
  
  //Black rectangle to allow the engine gauge to slowly climb towards the center (90'C)
  if(enginetemp < 50)                    //Only displays heat starting at 50'C
  {
    rect( (width/10), (height/10), (8*width/10), (height/10) );
  }
  else if(enginetemp >= 50 && enginetemp <= 90)    //Engine temp starts at 50'C and shouldnt go over 90'C
  {
    stroke(0);
    float enginetemp1 = map(enginetemp, 50, 90, 0, 0.4);         //enginetemp1 scales with enginetemp and is mapped down to a range between 0 and .4
    float enginetemp2 = map(enginetemp, 50, 90, 1, 0.5);         //This is used to adjust the maximum size of the engine heat gauge (range of 1 -> 0.5)
    rect( (width*(0.1f+enginetemp1)), (height/10), (8*enginetemp2)*width/10 , (height/10) );    //this makes the engine temp. bar change in realtion to the engine temperature
  }
  else      //In case engine is too hot      //(8*width*(0.1+enginetempD))
  {
    println("Engine overheat!!");
  }
  
  fontSize = ( (height * width)/13333.33 );
  textFont(f, fontSize);
  fill(255);
  
  //Displays temp selected in ac()
  text("Car Interior: ", width/5, 2*height/5);
  text(tempINT, width*0.375, height*0.4);
  text("'C", width*.425, height*0.4);
  
  
  //Tyre pressure randomly generated between 165-200kPa
  text("Tyre Pressure:", width*.1675, 3*height/5);
  text(tyrePi, width*.37, height*0.6);
  text("kPa", width*.455, height*0.6);
  
  
  //Current km
  text("Current KM: ", 3.5*width/5, 2*height/5);
  text(totalkm, 4.5*width/5, 2*height/5);
  
  
  //Next service at
  text("Next service: ", 3.5*width/5, 3*height/5);
  text(service, 4.5*width/5, 3*height/5);
  
}
   
   
   
   

//Function for screen three  --  date(Settings on home screen)
void date()
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
  
  
  //Draw the buttons to display and change the date
  fill(0);
  //These first three 'rects' are for the 'day' field and the arrows which both raise and lower the variable when clicked
  rect(width*.1f, height/10, width*.2f, height/10);
  rect(width*.1f, 2*height/10, width*.2f, 3*height/10);
  rect(width*.1f, 5*height/10, width*.2f, height/10);
  
  
  //The next three 'rects' are for the 'month' field and the arrows which both raise and lower the variable when clicked
  rect(width*.4f, height/10, width*.2f, height/10);
  rect(width*.4f, 2*height/10, width*.2f, 3*height/10);
  rect(width*.4f, 5*height/10, width*.2f, height/10);
  
  
  //The next three 'rects' are for the 'year' field and the arrows which both raise and lower the variable when clicked
  rect(width*.7f, height/10, width*.2f, height/10);
  rect(width*.7f, 2*height/10, width*.2f, 3*height/10);
  rect(width*.7f, 5*height/10, width*.2f, height/10);
  
  
  
  //These are the two boxes at the bottom of the settings screen  --  These change the speed to mph and
  rect(width/10, 6.5f*height/10, 3.5f*width/10, 2*height/10);
  rect(5.5f*width/10, 6.5f*height/10, 3.5f*width/10, 2*height/10);
  
  
  
  
  fill(255);   //fill in white for the text below
  fontSize = ( (height * width)/8000 );   //Font size scales with chosen display dimensions
  textFont(f, fontSize);  //sets font size of 'PFont f'
  
  //text for the '+' boxes first
  text("+", width*0.2, height*.185);
  text("+", width*0.5, height*.185);
  text("+", width*0.8, height*.185);
  
  //Now for the '-' boxes
  text("-", width*0.2, height*.58);
  text("-", width*0.5, height*.58);
  text("-", width*0.8, height*.58);
  
  //Finally the text for the date boxes
  text(day, width*0.2, height*.385);
  text(month, width*0.5, height*.385);
  text(year, width*0.8, height*.385);
  
  
  
  fontSize = ( (height * width)/13500 );   //Font size scales with chosen display dimensions
  textFont(f, fontSize);  //sets font size of 'PFont f'
  
  //Text for toggling between moh and kmph
  text("Toggle", width*0.265, height*.725);
  text("MpH/KMpH", width*0.265, height*.8);
  
  
  //Text for reseting default temp
  text("Reset A/C", width*0.725, height*.725);
  text("Temperature", width*0.725, height*.8);
  
  
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
      date();
      break;
    
  }
  
}

void mousePressed()    //The first half of this function is used to navigate through all the different screens using the buttons at the bottom of the screen
                       //The second half refers to the date()(settings) function/tab and allows the user to change the date on click
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
          println("In date() now");
          screen = 3;
        }
        else
        {
          println("In home_screen() now");
          screen = 0;
        }
    }
  
}//End of mousePressed()



void mouseClicked()  //This function is used in the ac() function to alter variables using the mouse
{
    
    if( (mouseX < 2*width/6) && (mouseX > width/6) && (mouseY < 6*height/8) && (mouseY > 3*height/8) )
    {
      if(screen == 1)
      {
      
        if(tempINT > 16)    //if temp is 16 it will print "min temp rreached"
        {
          tempINT--;
        }
        else
        {
          println("Minimum temperature reached");
        }
        
      }
      
    }//end of min temp if
    
    if( (mouseX  < 5*width/6) && (mouseX > 4*width/6) && (mouseY < 6*height/8) && (mouseY > 3*height/8) )
    {
      
      if(screen == 1)
      {
        
        if(tempINT < 28)    //if temp is 28 it will print "max temp reached"
        {
          tempINT++;
        }
        else
        {
          println("Maximum temperature reached");
        }
        
      }
      
    }//end of max temp if
       
     
     
     
    //If statement to turn on/off the windshield defroster
    if( ( mouseX > (spacing*2) ) && (mouseX < width/6 + (2*spacing)) && (mouseY > height/10) && (mouseY < 3*height/10) )  //Front defroster
    {
      
      if(screen == 1)
      {
        
        if(front == 0)    //If off - turn on
        {
          front = 1;  
        }
        else      //otherwise (so if on) - turn off
        {
          front = 0;
        }
        
      }
      
    }
    
    
    if( ( mouseX > (5*width/6 - (2*spacing) ) ) && (mouseX < width) && (mouseY > height/10) && (mouseY < 3*height/10) )  //Rear defroster
    {
      
      if(screen == 1)
      {
        
        if(rear == 0)    //If off - turn on
        {
          rear = 1;  
        }
        else      //otherwise (so if on) - turn off
        {
          rear = 0;
        }
        
      }
      
    }
   
  
}//end of mouseClicked() fnc




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

//End of assignment! :)