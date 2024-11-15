module Controller (
    input clock,
    input reset,
    input [2:0] opcode, // فیلد opcode برای تشخیص نوع عملیات
    output reg load_IR,
    output reg load_acc,
    output reg ld_pc,
    output reg clr_pc,
    output reg inc_pc,
    output reg sel_alu,
    output reg ir_on_adr,
    output reg pc_on_adr,
    output reg mem_read,  // برای عملیات Load
    output reg mem_write  // برای عملیات Store
);

    // تعریف حالت‌ها
    parameter RESET = 3'b000;
    parameter FETCH = 3'b001;
    parameter DECODE = 3'b010;
    parameter EXECUTE = 3'b011;

    reg [2:0] current_state, next_state;

    // انتقال حالت‌ها
    always @(posedge clock or posedge reset) begin
        if (reset)
            current_state <= RESET;
        else
            current_state <= next_state;
    end

    // منطق انتقال بین حالت‌ها
    always @(current_state) begin
        case (current_state)
            RESET: next_state = FETCH;
            FETCH: next_state = DECODE;
            DECODE: next_state = EXECUTE;
            EXECUTE: next_state = FETCH; // بازگشت به Fetch پس از اجرا
            default: next_state = RESET;
        endcase
    end

    // تولید سیگنال‌های کنترلی
    always @(*) begin
        // پیش‌فرض
        load_IR = 0;
        load_acc = 0;
        ld_pc = 0;
        clr_pc = 0;
        inc_pc = 0;
        sel_alu = 0;
        ir_on_adr = 0;
        pc_on_adr = 0;
        mem_read = 0;   // پیش‌فرض برای Load
        mem_write = 0;  // پیش‌فرض برای Store

        case (current_state)
            RESET: begin
                clr_pc = 1; // پاک کردن شمارنده برنامه
            end
            FETCH: begin
                ld_pc = 1;
                pc_on_adr = 1;
                clr_pc=0;
                inc_pc = 1; // شمارنده برنامه را افزایش می‌دهد
            end
            DECODE: begin
                load_IR = 1;
                ir_on_adr = 1;
            end
            EXECUTE: begin
                case (opcode)
                    3'b000: begin // عملیات ADD
                        sel_alu = 1;
                        load_acc = 1;
                    end
                    3'b001: begin // عملیات LOAD
                        mem_read = 1;
                        load_acc = 1;
                    end
                    3'b010: begin // عملیات STORE
                        mem_write = 1;
                    end
                    default: begin
                        // پیش‌فرض، هیچ عملیاتی انجام نشود
                    end
                endcase
            end
        endcase
    end
endmodule
