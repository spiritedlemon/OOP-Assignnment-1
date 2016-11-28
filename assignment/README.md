OOP-Assignment     --     DT - 228/2     --     Simon O'Leary ( C15413218 )


Embeded Video:
<iframe width="560" height="315" src="https://www.youtube.com/embed/1WEZDGG-6vM" frameborder="0" allowfullscreen></iframe>

Youtube link:
https://www.youtube.com/watch?v=1WEZDGG-6vM



Layout:
The functions used are in the following order(Should help with navigating through the code):

Global Variables		Line 14
Setup				Line 47
home_screen			Line 79
ac				Line 306
system				Line 416
date				Line 541
draw				Line 632	
mousePressed			Line 657
mouseClicked			Line 781
keyPressed			Line 871


How to Use(Everything is random, read in from a file, or the user can interact with it):

Screen 0 - This is the home screen

-The fuel gauge on the left is randomised when the program is run.
-The elec bar on the right slowly ticks up until full.
-The time and date are read in from the system it's run on.
-The temperature is read in from the .csv file and changes color based on temperature
-The speed is read in from the .csv file


Screen 1 - This is the 'Air Con' screen

-The two buttons at the top change color and change the text in the center of the screen on click
( see mouseClicked() )
-The arrows change the temperature displayed - This affects the next screen as well


Screen 2 - This is the 'System' screen

-The gauge up the top slowly ticks up as the program runs(Like a real engine)
It starts at Thirty and ticks up 1 unit per second
At 50 it appears on the bar and counts towards 90
If you want to speed this up just change the 'enginetemp' variable to start at 50

-The 'tyre pressure' and 'next service' tags are both random and if next service is under 5000
it prints when the next service is due to the console
-The current temperature refers to the number from the aircon screen which the user can alter
-The Current KM travelled is read in from the .csv file


Screen 3 - This is the 'Settings' screen

-The date can be altered and the alterations made will appear on the home screen
If month hits 12 it's reset to 1, same goes for the day when it hits 31
-Clicking toggle MpH/KMpH will alter the speed on the home screen and print which is 
now being presented in the console (Note:The speed is being read in from a file as kilometers, then converted)
-Clicking reset temperature resets the tempINT variable to 20, this means the air con tab will revert to 20 


