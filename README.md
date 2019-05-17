# Systolic Array Based LeNet-CNN-Accelerator-for-FPGA
An open source Verilog Based LeNet-1 CNNs Accelerator for FPGAs.
Trained weights of the model are in "W.mem" file in "Other-files" directory.

## How to run 
### Requirement:
Vivado 2017.1 or above (as I have used)
### Procedure
1. Make a new project in vivado
2. Add files (Conv3D.v, FC.v, LeNet.v, MACC.v, Multiplication.v, PE.v, PE_Array.v, max2.v, softmax.v) from folder (Verilog-Source-Files) to your project as 'design sources'.
3. Add file (tb_LeNet.v) from folder (Other-Files) to your project as 'simulation sources'.
4. Add files (I0.mem, I1.mem, I2.mem, I3.mem, I4.mem, I5.mem, I6.mem, I7.mem, I8.mem, I9.mem, W.mem) from folder (Other-Files) to your project as 'design sources'.
5. Change inputs from line 56 of LeNet.v in folder (Verilog-Source-Files). [like I4.mem instead of I3.mem]
6. Before simulation confirm simulation time should be more than 10000ns to do it go to:
Project Manager -> Settings -> Project Setting -> Simulation -> Find Simulation tab -> change xsim.simulate.runtime from 1000ns to 1000us
![Alt text](images/Capture2.PNG?raw=true "Simulation Time")
#### Alternatevly: You can directly run this command in 'tcl console'
**_set_property -name {xsim.simulate.runtime} -value {1000us} -objects [get_filesets sim_1]_**
#### 7. Simulate and get the desired result
# Details of work
## LeNet-1 Network
LeNet-1 Architecture for handwritten digit recognition is given by
![Alt text](images/Slide2.JPG?raw=true "LeNet-1 Architecture")
## LeNet-1 Model Summary
![Alt text](images/Capture.PNG?raw=true "Model")
## Systolic Array Based Hardware Architechture Design
![Alt text](images/Slide3.JPG?raw=true "Systolic Architecture")
### Controller
![Alt text](images/Slide8.JPG?raw=true "cont")
![Alt text](images/Slide9.JPG?raw=true "coay")
![Alt text](images/Slide10.JPG?raw=true "cc")
### Convolution Layer PE Array (5X6) Micro-Architecture
![Alt text](images/Slide4.JPG?raw=true "5X6 PE Array")
#### Processing Element (PE) and MACC Units
![Alt text](images/Slide5.JPG?raw=true "5X6 PE Array")
### Fully Connected Layer Micro-Architecture
![Alt text](images/Slide6.JPG?raw=true "fc")
### Fast Softmax Micro-Architecture
![Alt text](images/Slide7.JPG?raw=true "Softmax")
## Results Before Softmax Layer (Keras Vs Vivado)
![Alt text](images/Slide19.JPG?raw=true "0 Keras vs 0 Vivado")
![Alt text](images/Slide20.JPG?raw=true "1 Keras vs 1 Vivado")
![Alt text](images/Slide21.JPG?raw=true "2 Keras vs 2 Vivado")
![Alt text](images/Slide22.JPG?raw=true "3 Keras vs 3 Vivado")
![Alt text](images/Slide23.JPG?raw=true "4 Keras vs 4 Vivado")
![Alt text](images/Slide24.JPG?raw=true "5 Keras vs 5 Vivado")
![Alt text](images/Slide25.JPG?raw=true "6 Keras vs 6 Vivado")
![Alt text](images/Slide26.JPG?raw=true "7 Keras vs 7 Vivado")
![Alt text](images/Slide27.JPG?raw=true "8 Keras vs 8 Vivado")
![Alt text](images/Slide28.JPG?raw=true "9 Keras vs 9 Vivado")
