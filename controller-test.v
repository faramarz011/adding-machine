`timescale 1ns/1ps

module Controller_tb;

    // ورودی‌ها
    reg clock;
    reg reset;
    reg [2:0] opcode;

    // خروجی‌ها
    wire load_IR;
    wire load_acc;
    wire ld_pc;
    wire clr_pc;
    wire inc_pc;
    wire sel_alu;
    wire sel_bus;
    wire pass_add;
    wire ir_on_adr;
    wire pc_on_adr;
    wire mem_read;
    wire mem_write;

    // نمونه‌سازی از ماژول Controller
    Controller uut (
        .clock(clock),
        .reset(reset),
        .opcode(opcode),
        .load_IR(load_IR),
        .load_acc(load_acc),
        .ld_pc(ld_pc),
        .clr_pc(clr_pc),
        .inc_pc(inc_pc),
        .sel_alu(sel_alu),
        .sel_bus(sel_bus),
        .pass_add(pass_add),
        .ir_on_adr(ir_on_adr),
        .pc_on_adr(pc_on_adr),
        .mem_read(mem_read),
        .mem_write(mem_write)
    );

    // تولید کلاک
    always #5 clock = ~clock;

    // بخش تست
    initial begin
        // مقداردهی اولیه
        clock = 0;
        reset = 0;
        opcode = 3'b000;

        // نمایش سیگنال‌ها
        $monitor("Time = %0d, State = %b, opcode = %b, load_IR = %b, load_acc = %b, ld_pc = %b, clr_pc = %b, inc_pc = %b, sel_alu = %b, sel_bus = %b, pass_add = %b, mem_read = %b, mem_write = %b", 
                 $time, uut.current_state, opcode, load_IR, load_acc, ld_pc, clr_pc, inc_pc, sel_alu, sel_bus, pass_add, mem_read, mem_write);

        // تست حالت RESET
        reset = 1;
        #10;
        reset = 0;
        
        // تست حالت FETCH
        #10;
        
        // تست حالت DECODE
        #10;
        
        // تست حالت EXECUTE با opcode های مختلف

        // تست عملیات ADD
        opcode = 3'b000;
        #10;

        // تست عملیات LOAD
        opcode = 3'b001;
        #10;

        // تست عملیات STORE
        opcode = 3'b010;
        #10;

        // تست حالت پیش‌فرض
        opcode = 3'b111;
        #10;

        // پایان شبیه‌سازی
        $finish;
    end

endmodule
