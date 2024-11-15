module ProgramCounter (clock,reset,data_in_pc,
inc_pc,clear,load_pc,out_pc);
    input clock;
    input reset;
    input [5:0] data_in_pc;
    input load_pc;
    input clear;
    input inc_pc;
    output reg [5:0] out_pc;
    

    always @ (posedge clock, reset)
        if (reset) begin
            out_pc <= 0;
        end else begin
            if (clear) begin
                out_pc <= 0;
            end else if (load_pc) begin
                out_pc <= data_in_pc;
            end else if (inc_pc) begin
                out_pc <= out_pc + 1;
            end
        end

endmodule