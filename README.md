# FPGA_calculator
 A course final project for ELEC4320 implementing scientific calculator with FPGA basys3
 
 Features include Addition, Subtraction, Multiplication, Division, Square root, Logarithm, Cosine, Sine, Tangent, and Exponential.
 
 Link to the report document: https://hkustconnect-my.sharepoint.com/:w:/g/personal/cchanba_connect_ust_hk/Ea6c7fnoBQFJqpNXuGxWmXcBbAvtttZgFOlbQvDE6mMj7Q?e=NQeITn

# Input
 Reference to applying keyboard: https://github.com/Digilent/Basys-3-Keyboard
 The USB-connected keyboard is used for inputting data, the key pin is as follows:
numbers from 0-9 that can input to the data, shown with a form of *meaning number -> code represents keyboards with basys3 FPGA board*
1 - > 16 ;

2 -> 1E ;

3 -> 26 ;

4 -> 25 ;

5 -> 2E ;

6 -> 36 ;

7 -> 3D ;

8 -> 3E ;

9 -> 46 ;

0 -> 45 ;

All operations that can be used, shown with a form of *meaning operation -> code represents keyboards with basys3 FPGA board (keyboard key)*

addition -> 1C (a)

subtraction -> 4E (-)

multiplication -> 3A (m)

division -> 4A (/)

square root -> 2D (r)

cosine -> 21 (c)

sine -> 1B (s)

tangent -> 2C (t)

logarithm -> 4B (l)

exponential -> 24 (e)

enter key that can change the state of input state of FPGA, shown with a form of *meaning enter -> code represents keyboards with basys3 FPGA board (keyboard key)*

enter -> 5A (enter)

Logic: users will input num1, operation, and num2. There will be five stages, s1 is to check if num1 is positive or negative by pressing enter (5A) for positive or - (4E) for negative. Then it will jump to the next stage, s2 is to input num1, switch case: assign keydata -> num1 with pin code of only number 0-9 is valid, if there are more than one key pressed, num1 * 10 + key data, and the maximum is entering 3 number, which means the maximum is 999. Pressing 3 keys or pressing enter will end s2. Then s3 is to choose the operators, with only the pin code of the operation being valid, s3 will end when one valid key is pressed. Then it is s4, s4 will be for num2, same as what we did in num1, check positive or negative of num2, and s5 will be the pin code of only number 0-9 is valid entered, can be ended by pressing 3 keys or pressing enter.

# Addition and Subtraction
As basic as it should be, implement directly with + and - sign.

# Output
Shows on the 7-segment LEDs on Basys3 FPGA-board, with moving digits using the control buttons left and right
Include 7 decimal places
