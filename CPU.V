module CPU (
    input clock,
    input reset,
    input [2:0] opcode,
    input [7:0] Data_bus_in,
    output [7:0] out_acc
);

    // سیگنال‌های کنترلی بین Controller و DataPath
    wire load_IR, load_acc, ld_pc, clr_pc, inc_pc, sel_alu, ir_on_adr, pc_on_adr;
    wire mem_read, mem_write;

    // نمونه‌سازی ماژول Controller
    Controller ctrl (
        .clock(clock),
        .reset(reset),
        .opcode(opcode),
        .load_IR(load_IR),
        .load_acc(load_acc),
        .ld_pc(ld_pc),
        .clr_pc(clr_pc),
        .inc_pc(inc_pc),
        .sel_alu(sel_alu),
        .ir_on_adr(ir_on_adr),
        .pc_on_adr(pc_on_adr),
        .mem_read(mem_read),
        .mem_write(mem_write)
    );

    // نمونه‌سازی ماژول DataPath
    DataPath datapath (
        .clock(clock),
        .reset(reset),
        .Data_bus_in(Data_bus_in),
        .load_IR(load_IR),
        .load_acc(load_acc),
        .ld_pc(ld_pc),
        .clr_pc(clr_pc),
        .inc_pc(inc_pc),
        .sel_alu(sel_alu),
        .ir_on_adr(ir_on_adr),
        .pc_on_adr(pc_on_adr),
        .sel_bus(1'b0), // برای ساده‌سازی فرض شده 0 باشد
        .pass_add(1'b0) // فرض شده 0 باشد

    



    );

endmodule
