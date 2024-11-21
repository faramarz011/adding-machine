module DataPath (
    input clock,
    input reset,
    input [7:0] Data_bus_in,
    input load_IR,
    input load_acc,
    input sel_alu,
    input sel_bus,
    input pass_add,
    input ld_pc,
    input clr_pc,
    input inc_pc,
    input ir_on_adr,
    input pc_on_adr,
    output [7:0] out_acc,  // خروجی Accumulator
    output [7:0] out_IR,   // خروجی IR
    output [5:0] out_PC,   // خروجی PC
    output [7:0] out_ALU   // خروجی ALU
);

    // سیگنال‌های داخلی
    wire [7:0] a_side;
    wire [7:0] ALU_out;
    wire [5:0] out_pc;
    wire [7:0] mux1_out;
    wire [5:0] mux2_out;
    wire [7:0] IR_out;

    // Mux اول برای انتخاب بین ALU و Data_bus_in
    Mux #(.WIDTH(8)) mux1(
        .in0(ALU_out),
        .in1(Data_bus_in),
        .sel(sel_alu),
        .sel_bus(sel_bus),
        .out(mux1_out)
    );

    // Accumulator
    Acc acc(
        .clock(clock),
        .reset(reset),
        .data_in(mux1_out),
        .load(load_acc),
        .data_out(a_side)
    );
    assign out_acc = a_side; // اتصال خروجی Accumulator به پورت out_acc

    // Instruction Register (IR)
    IR ir(
        .clock(clock),
        .reset(reset),
        .data_in(Data_bus_in),
        .load(load_IR),
        .data_out(IR_out)
    );
    assign out_IR = IR_out; // اتصال خروجی IR به پورت out_IR

    // ALU
    ALU alu(
        .a(a_side),
        .b({2'b00, IR_out[5:0]}),
        .pass(pass_add),
        .result(ALU_out)
    );
    assign out_ALU = ALU_out; // اتصال خروجی ALU به پورت out_ALU

    // Program Counter (PC)
    ProgramCounter PC(
        .clock(clock),
        .reset(reset),
        .data_in(IR_out[5:0]),
        .inc(inc_pc),
        .clr(clr_pc),
        .ld(ld_pc),
        .data_out(out_pc)
    );
    assign out_PC = out_pc; // اتصال خروجی PC به پورت out_PC

    // Mux دوم برای انتخاب آدرس
    Mux #(.WIDTH(6)) mux2(
        .in0(IR_out[5:0]),
        .in1(out_pc),
        .sel(ir_on_adr),
        .sel_bus(pc_on_adr),
        .out(mux2_out)
    );

endmodule
