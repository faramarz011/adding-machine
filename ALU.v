module ALU (input [7:0] a_side, b_side, input pass_add,output[7:0] alu_out);
    wire [7:0] addresult;
    assign addresult = a_side + b_side;
    assign alu_out = pass_add? addresult : a_side;
endmodule
    
   