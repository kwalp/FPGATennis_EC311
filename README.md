# FPGATennis

Tennis on the FPGA

By K. Walp and N. Vinay Kishan

This tennis game is written in verilog, and synthesized with XILLINX Vivado. It includes states for two players (tennis) and one player (squash). If a player hits early on three clock edges, the other player will gain a point, and will serve. If a player misses the ball, the other player will gain a point. Server after misses will alternate. At each hit, the clock speed will increase, and is reset at the next serve. 


WARNING: The clock divider makes it impossible to run testbenches on this code. If you want to use a testbench, change the clock input of the lights module from the divided clock to the system clock.


The constraints are set as follows in the bitstream:

  - The squash state can be triggered by flipping the leftmost switch on the FPGA to ON. 
  - The left button is for player 1 hits (player 0 in the code) and the right button is for player 2 hits (player 1 in the code). 
  - The bottom button is for RESET.

This project was done in association with the Boston University College of Engineering

