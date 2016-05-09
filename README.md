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
Clone the current github repository.  Launch OpenVibe Designer and open the InputTest.xml.  Ensure that the Matlab 
Scripting executable path is set properly and define the Matlab working directory to the Source file in the github
folder, apply all changes.  Put on EmotivEpoc headset and get as many nodes connected as possible, as displayed by the Emotiv Command Center software. Open the OpenVibe Aquistion Client and select the Emotiv Epoc headset from the drop down menu. Press connect, and then play. Execute the current scenario by pressing play on the OpenVibe Designer client.  Begin training the set by pressing a keyboard command while performing the motor activity to map to that command.  Training longer will produce better results. To stop training, press the stop button located at the top of the OpenVibe Designer window. Wait until training completes to close the OpenVibe Designer window.

To use a trained neural net, open OutputTest.xml. Again, the MatLab path and files must be specified before use. The files are OutputTest_Initialize.m, OutputTest.m, and OutputTest_Unititialize.m. Once the headset is connect as per the instructions above, the scenario can be run. The scenario will then attempt to match brain pattern to keyboard output specified in the program.

Troubleshooting
-----------------------------------------
The user may run into several common problems in the course of setting up the software to use. Listed here are a few common problems which may arrise.

1) OpenVibe Designer cannot connect to MatLab (MatLab engine failed to start)

This is caused by the MatLab engine code failing to start correctly. This is most likely due to an incorrect version of MatLab. It is imperitive that the user uses a 32-bit installation of MatLab, as OpenVibe will ONLY work with 32-bit installs of MatLab. We recommend the r2015b version.

The other problem associated with this issue is incorrect specification of MatLab working directories. The MatLab working directory must be changed to the user's working directory in order to run the program. This can be done by double clicking the "MatLab Scripting" box in the OpenVibe Designer scenario. A full path must be specified to both the installation of MatLab and the working directory.

2)Trainer is not training properly (too much noise in output)

This is most likely due to incorrect training procedure. First, make sure the headset is properly connected, and that the Acquistion Client is running. Next, make sure that the "Keyboard Stimulation" window is the currently selected window while entering key presses. Finally, try to only perform a mapped action when the associated key is pressed, to reduce noise.
