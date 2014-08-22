//--------------------------------------------------------------
// Testbench using Fuse Z80 emulator test vectors
//--------------------------------------------------------------
`timescale 100 ps/ 100 ps
`define CLR 1
`define SET 0

`include "z80.svh"

module test_bench_fuse(z80_if.tb z);

assign clk = z.CLK;

integer f;

initial begin : init
    z.nWAIT <= `CLR;
    z.nINT <= `CLR;
    z.nNMI <= `CLR;
    z.nBUSRQ <= `CLR;
    z.nRESET <= `SET;
#1  z.nRESET <= `CLR;

    // Run all the tests and write the result to a file
    f = $fopen("fuse.result.txt");
    `include "test_fuse.i"
    $fclose(f);

end : init

endmodule

module test_fuse();

bit clk = 1;
initial repeat (`TOTAL_CLKS) #1 clk = ~clk;

z80_if z80(clk);            // Instantiate the Z80 bus interface
z80_top dut(z80);           // Create an instance of our Z80 design
test_bench_fuse tb(z80);    // Create an instance of the test bench

ram ram( .Address(z80.A), .Data(z80.D), .CS(z80.nMREQ), .WE(z80.nWR), .OE(z80.nRD) );

endmodule