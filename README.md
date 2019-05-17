# LeNet-CNN-Accelerator-for-FPGA
An open source Verilog Based LeNet-1 CNNs Accelerator for FPGAs
## LeNet-1 Network
LeNet-1 Architecture for handwritten digit recognition is given by
![Alt text](images/Slide2.JPG?raw=true "LeNet-1 Architecture")
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
![Alt text](images/Slide6.JPG?raw=true "FC)
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
