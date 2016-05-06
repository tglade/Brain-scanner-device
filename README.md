Neural Interfacing 
==========================
  Thomas Glade
  
  Tyler Brutsman
  
  Adam Kacmarsky

Project
----------------------------------------
Machine Learning on Brainwaves

Description
-----------------------------------------
This project aims to read in brainwaves with an Arduino microcontroller. 
These brainwaves will then be processed by a machine learning algorithm to extract patterns within the brainwaves.
Given a certain pattern, the program should then output some sort of keyboard command to a separate program,
which, in turn, will be used to control a simple game (Pac-Man, etc.). Additionally, the program should be able
to create a new learned set off of a minimal amount of repetitions of a pattern (i.e. it should be able to be used
by a new user with minimal time learning the patterns). 

Important Files
-----------------------------------------
Files necessary to execute are located in the Source folder.  

Sofware
-----------------------------------------
Required software includes OpenVibe, Matlab 32-bit, and EmotivEpoc software.

Hardware
-----------------------------------------
EmotiveEpoc headset, machine to run software.

Instructions
-----------------------------------------
Clone the current github repository.  Launch OpenVibe and open the InputTest.xml.  Ensure that the Matlab 
Scripting executable path is set properly and define the Matlab working directory to the Source file in the github
folder, apply all changes.  Put on EmotivEpoc headset and get as many nodes connected as possible.  Execute the
current scenario by pressing play on the OpenVibe client.  Begin training the set by pressing a keyboard command
while performing the motor activity to map to that command.  Training longer will produce better results.