//OOP-Assignment     --     DT 228/2     --     Simon O'Leary ( C15413218 )



void setup()
{
  size(500, 500);
  background(0);
  
}


void home_screen()
{
  stroke(0, 255, 255);
  fill(0);
  
  //Drawing boxes at the base of the screen to navigate to other menus
  rect( 0, (height - (height/10) ), ( width - 1 ), height );
  line( ( width/3), (height - (height/10) ), ( width/3), height);
  line( ( width - (width/3) ), (height - (height/10) ), ( width - (width/3) ), height);
  
  
}




void draw()
{
  home_screen();
  
}