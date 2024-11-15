  

module Acc (clock,reset,mux1_out,ld_acc,a_side);
    input clock;
    input reset;
    input [7:0]mux1_out;
    input ld_acc;
    output  reg [7:0]a_side;
    always @ (posedge clock) begin
    if (ld_acc) 
        a_side <= mux1_out;
    end
endmodule
