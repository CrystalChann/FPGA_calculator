# FPGA_calculator
 A course final project for ELEC4320 implementing scientific calculator with FPGA basys3
 Features include Addition, Subtraction, Multiplication, Division, Square root, Logarithm, Cosine, Sine, Tangent, and Exponential.

# Input
 USB-connected keyboard is used for inputting data, the key pin is as follows:

numbers
1 - > 16
2 -> 1E 
3 -> 26
4 -> 25
5 -> 2E
6 -> 36
7 -> 3D
8 -> 3E
9 -> 46
0 -> 45

addition -> 1C (a)
subtraction -> 4E (-)
multiplication -> sA (m)
division -> 4A (/)
square root -> 2D (r)
cosine -> 21 (c)
sine -> 1B (s)
tangent -> 2C (t)
logarithm -> 4B (l)
exponential -> 24 (e)

equal to -> 55 (=)
enter -> 5A (enter)

# Output
Shows on the 7-segment LEDs on Basys3 FPGA-board, with moving digit using the control buttons left and right
Include 7 decimal places
