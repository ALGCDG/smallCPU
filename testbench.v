`timescale 1s/1s
module testbench();
    // creating a regular clock
    reg clk;
    initial clk = 0;
    always #1 clk = !clk;
    cpu c(clk);

    initial
    begin
        $display("Running tinyCPU testbench...");
        $monitor("Time: %t, Clock: %c", $time, clk);
    end

    // initial begin
    //     # 10 clk = 1;
    //     # 10 clk = 0;
    //     # 10 clk = 1;
    //     # 10 clk = 0;
    //     # 10 clk = 1;
    //     # 10 clk = 0;
    //     # 10 clk = 1;
    //     # 10 clk = 0;
    // end
endmodule