module DataPath (clock,reset,Data_bus_in,load_IR,load_acc,sel_alu,
    ir_on_adr,pc_on_adr,sel_bus,ld_pc,clr_pc,inc_pc,pass_add,
    outt_IR,outt_ALU,outt_PC,outt_AC);
    input clock;
    input reset;
    input load_IR;
    input load_acc;
    input ld_pc;
    input clr_pc;
    input [7:0]Data_bus_in;
    input sel_alu;
    input sel_bus;
    input pass_add;
    input inc_pc;
    input ir_on_adr;
    input pc_on_adr;
    

    wire [7:0]a_side;
    wire [7:0]ALU_out;
    wire [5:0]out_pc;

    wire [7:0]mux1_out;
    wire [5:0]mux2_out;
    wire [7:0]IR_out;
    output [0:7]outt_IR;
    output [0:7]outt_PC;
    output [0:7]outt_AC;
    output [0:7]outt_ALU;


    Mux #(.WIDTH(8)) mux1(ALU_out,Data_bus_in,sel_alu,sel_bus,mux1_out);
    Acc acc(clock,reset,mux1_out,load_acc,a_side);
    assign outt_AC = a_side[7:0];  // Correctly assigning IR_out to outt
    IR ir(clock,reset,Data_bus_in,load_IR,IR_out[7:0]);
    assign outt_IR = IR_out[7:0];  // Correctly assigning IR_out to outt

    ALU alu(a_side,{2'b00,IR_out[5:0]},pass_add,ALU_out);

    assign outt_ALU = ALU_out[7:0];  // Correctly assigning IR_out to outt

    ProgramCounter PC(clock,reset,IR_out[5:0],inc_pc,clr_pc,ld_pc,out_pc);
    assign outt_PC = out_pc[5:0];  // Correctly assigning IR_out to outt


    Mux #(.WIDTH(6)) mux2(IR_out[5:0], out_pc[5:0], ir_on_adr,pc_on_adr, mux2_out);
    

endmodule