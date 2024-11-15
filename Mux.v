module Mux #(parameter WIDTH = 8) (
    in1, in2, sel1, sel2, out);
    input [WIDTH-1:0] in1;
    input [WIDTH-1:0] in2;
    input sel1;
    input sel2;
    
    output reg [WIDTH-1:0] out;

    always@(in1, in2, sel1, sel2) begin
        if (sel1 == 1) begin
            out = in1;
        end else if (sel2 == 1) begin
            out = in2;
        end
    end
endmodule
