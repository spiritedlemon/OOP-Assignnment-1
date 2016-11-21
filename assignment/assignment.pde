//OOP-Assignment     --     DT - 228/2     --     Simon O'Leary ( C15413218 )

//Electronic dashboard for a car which displays speed, sate, time, etc and allows user to change the air conditioning, 
//see some details about the car and change a number of settings

//https://github.com/spiritedlemon/OOP-Assignnment-1



void setup()
{
  size(800, 600);    //I'd suggest a wider screen as it looks better -> size(800,600)
  background(50);    //'50' (gray) looks better than just black

}

//Global Variables

int spacing = ( (height * width)/1920 );    //This is used to space out displays of time, date and temp primarily -- It = ~5 on the recommended size setting (800, 600)
//int spacing = ( (height * width)/96000 ); 

float randlvl = random(2, 4);       //Used to give a random level to the fuel meter, because no one ever has 100% fuel always

int timeH = hour();      //Hour  --  Global variables used in home_screen() and clock()
int timeM = minute();    //Minute

int day = day();         //Global variables used in home_screen() and clock()
int month = month();
int year = year();

int tempEX = 0;    //Changes the color of the font based on temperature --  range of '-10' to '40' --  Read in from file
int tempINT = 20;     //Temperature used in ac() and system() -- Temperature of inside the car  --  range of '16' to '28'

int speed = 0; //Speed in km/h  --  Read in from file

int screen = 0; //Menu selection -- 0=home_screen(), 1=ac(), 2=system(), 3=clock()

//Variables used to display whether the windows are defrosting or not
int front = 0;
int rear = 0;



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
  
  stroke(0);
  
  //Adding a random element to the fuel gauge:  --  randlvl is called initialised globally to prevent changing 60x a second
  rect( (width/9), (height/10), (width/9), (height - (height/randlvl) ) );
  
  
  
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