# FPGA_calculator
 A course final project for ELEC4320 implementing scientific calculator with FPGA basys3
 
 Features include Addition, Subtraction, Multiplication, Division, Square root, Logarithm, Cosine, Sine, Tangent, and Exponential.
 Basys 3 Reference Manual - https://digilent.com/reference/programmable-logic/basys-3/referencemanual?srsltid=AfmBOopLBJBhYpro2qktVNDCoE4AXpPGP3kT2nGlFATPrFGbriCEFHYK 

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

exponential -> 24 (e)

powering -> 4D (p)

enter key that can change the state of input state of FPGA, shown with a form of *meaning enter -> code represents keyboards with basys3 FPGA board (keyboard key)*

enter -> 5A (enter)

Logic: users will input num1, operation, and num2. There will be five stages, s1 is to check if num1 is positive or negative by pressing enter (5A) for positive or - (4E) for negative. Then it will jump to the next stage, s2 is to input num1, switch case: assign key data -> num1 with pin code of only number 0-9 is valid, if there are more than one key pressed, num1 * 10 + key data, and the maximum is entering 3 number, which means the maximum is 999. Pressing 3 keys or pressing enter will end s2. Then s3 is to choose the operators, with only the pin code of the operation being valid, s3 will end when one valid key is pressed. Then it is s4, s4 will be for num2, same as what we did in num1, check positive or negative of num2, and s5 will be the pin code of only number 0-9 is valid entered, can be ended by pressing 3 keys or pressing enter.

# Addition and Subtraction
As basic as it should be, implement directly with + and - sign.

# Multiplication and Division
The design of the multiplication checks each of the lower 4 bits of num2. If a bit is set, it adds the corresponding shifted value of num1. For each bit i of num2, if num2[i] is 1, compute num1 << i (this shifts num1 left by i bits), and add this shifted value to product. This is a shift-and-add method. 

On the other hand, the division module is implemented with the restoring division algorithm. It first checks if the divisor is 0 or not to prevent error, then starts with a loop to shift left the current remainder by one bit and the next bit of temp_num1 is brought down into the remainder. The temp_quotient is also shifted left by one bit to prepare for the next quotient bit. It then checks if the remainder is bigger or smaller and does a subtraction on it. Using bitwise shifting and comparison to finish the calculation. 

# Trigonometry
The trigonometry functions include sine, cosine and tangent, both sine and cosine are similar wave form. In this case we use Taylor series to calculate the sine function and the cosine function. At the same time, tan x = sin x / cos x.

# Powering and Exponential functions 
For powering functions, as it is a concept of multiplying the base itself for a certain time, it is a loop that runs for the assigned number of times. As it is too large to use multiplication module in a loop, we use nested loop with addition. In the following code, the logic first shows special situations like 𝑥0𝑜𝑟 0𝑥. Then start with a nested loop to add the base multiple times to simulate multiplication with itself, and then start the outer loop to simulate a multiplication of the required amount.  

Exponential function acts the same, yet we change the base to 𝑒 = 2.71828 

# Square Root
The algorithm is inspired by research article “An FPGA Implementation of a Fixed-Point Square Root Operation”.
If num1 is greater than 0, the input number is assigned to x, and both remainder and b are initialized to 0. The variable i is set to 9, which corresponds to the highest bit of a 10-bit number. 
The algorithm does Digit Recurrence Algorithm, with first shifting and adding in a loop and then checking the square to make sure the current approximation (b * b) is less than or equal to the remainder.  


# Output
Shows on the 7-segment LEDs on Basys3 FPGA-board, with moving digits using the control buttons left and right
the 7 seg displayer share the same anode while having individual cathodes, this means that to see all the digits at the same time, indefinitely must rewrite them altering the anode, we chose a rewrite period of 2.6 ms, This period is calculated with an internal timer. And this period cannot be noticed by human sight. 
Opened ports for BtnL, BtnR, seg[6:0], and an[3:0].
The lButton rButton controls the display and the patterns array, which describes the number of numbers our system can display (note that 84 is a multiple of 7, meaning in this configuration, it can display 12 characters). The anode register selects the anode that needs to be written, and the pattern is the pattern that needs to be written at this specific anode. 
