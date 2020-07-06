module testbench();
    // creating a regular clock
    reg clk;
    initial clk = 0;
    always #5 clk = !clk;
    cpu c(clk);

    initial
    begin
        $display("Running tinyCPU testbench...");
        $monitor("Time: %t, Clock: %c", $time, clk);
    end
endmodule