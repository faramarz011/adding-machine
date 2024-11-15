module IR (clock,reset,instruction_data_in,
load_IR,out_IR);
    input clock;
    input reset;
    input [7:0] instruction_data_in;
    input load_IR;
    output reg [7:0] out_IR;
    always @ (posedge clock) begin
    if (load_IR) 
        out_IR <= instruction_data_in;
    end
endmodule