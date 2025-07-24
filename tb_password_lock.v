`timescale 1ns/1ps
module testbench;

    reg clk, reset;
    reg [3:0] entered_pass;
    wire unlock, locked;
    wire [1:0] attempts;
    wire [6:0] seg0, seg1, seg2, seg3;

    password_lock_system uut (
        .clk(clk),
        .reset(reset),
        .entered_pass(entered_pass),
        .unlock(unlock),
        .locked(locked),
        .attempts(attempts),
        .seg0(seg0),
        .seg1(seg1),
        .seg2(seg2),
        .seg3(seg3)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
      $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        $display("Time\tPass\tUnlock\tLocked\tAttempts\tSegs");
        $monitor("%0t\t%b\t%b\t%b\t%d\t%h %h %h %h", $time, entered_pass, unlock, locked, attempts, seg0, seg1, seg2, seg3);

        reset = 1; #10;
        reset = 0;

        entered_pass = 4'b0000; #10;
        entered_pass = 4'b1111; #10;
        entered_pass = 4'b0011; #10;  
        entered_pass = 4'b1010; #10;  

        #20
        reset = 1; #10;              
        reset = 0;
        entered_pass = 4'b1010; #10;  

        $finish;
    end
endmodule
