`timescale 1ns/1ps

module DataPath_tb;

    // ورودی‌ها
    reg clock;
    reg reset;
    reg [7:0] Data_bus_in;
    reg load_IR;
    reg load_acc;
    reg sel_alu;
    reg sel_bus;
    reg pass_add;
    reg ld_pc;
    reg clr_pc;
    reg inc_pc;
    reg ir_on_adr;
    reg pc_on_adr;

    // خروجی‌ها
    wire [7:0] out_acc;
    wire [7:0] out_IR;
    wire [5:0] out_PC;
    wire [7:0] out_ALU;

    // نمونه‌سازی از ماژول DataPath
    DataPath uut (
        .clock(clock),
        .reset(reset),
        .Data_bus_in(Data_bus_in),
        .load_IR(load_IR),
        .load_acc(load_acc),
        .sel_alu(sel_alu),
        .sel_bus(sel_bus),
        .pass_add(pass_add),
        .ld_pc(ld_pc),
        .clr_pc(clr_pc),
        .inc_pc(inc_pc),
        .ir_on_adr(ir_on_adr),
        .pc_on_adr(pc_on_adr),
        .out_acc(out_acc),
        .out_IR(out_IR),
        .out_PC(out_PC),
        .out_ALU(out_ALU)
    );

    // تولید سیگنال clock
    always #5 clock = ~clock;

    // فرآیند تست
    initial begin
        // نمایش سیگنال‌ها
        $monitor("Time: %0d | Data_bus_in: %h | out_acc: %h | out_IR: %h | out_PC: %h | out_ALU: %h",
                 $time, Data_bus_in, out_acc, out_IR, out_PC, out_ALU);

        // مقداردهی اولیه
        clock = 0;
        reset = 1;
        Data_bus_in = 8'h00;
        load_IR = 0;
        load_acc = 0;
        sel_alu = 0;
        sel_bus = 0;
        pass_add = 0;
        ld_pc = 0;
        clr_pc = 0;
        inc_pc = 0;
        ir_on_adr = 0;
        pc_on_adr = 0;

        // فعال کردن reset
        #10 reset = 0;

        // تست load_IR
        #10 Data_bus_in = 8'hA5; // داده ورودی
        load_IR = 1;
        #10 load_IR = 0;

        // تست load_acc
        #10 Data_bus_in = 8'h3C;
        load_acc = 1;
        #10 load_acc = 0;

        // تست ALU با انتخاب sel_alu
        #10 sel_alu = 1;
        pass_add = 1;
        #10 pass_add = 0;
        sel_alu = 0;

        // تست Program Counter (PC)
        #10 ld_pc = 1;
        clr_pc = 0;
        inc_pc = 1;
        #10 inc_pc = 0;
        ld_pc = 0;

        // تست ir_on_adr و pc_on_adr
        #10 ir_on_adr = 1;
        pc_on_adr = 0;
        #10 ir_on_adr = 0;
        pc_on_adr = 1;

        // پایان تست
        #50 $finish;
    end

endmodule
