module CPU_tb;

    // تعریف ورودی‌ها به صورت reg
    reg clock;
    reg reset;
    reg [2:0] opcode;
    reg [7:0] Data_bus_in;

    // تعریف خروجی‌ها به صورت wire
    wire [7:0] out_acc;

    // نمونه‌سازی ماژول CPU
    CPU uut (
        .clock(clock),
        .reset(reset),
        .opcode(opcode),
        .Data_bus_in(Data_bus_in),
        .out_acc(out_acc)
    );

    // تولید سیگنال کلاک
    always #5 clock = ~clock; // دوره تناوب کلاک برابر 10 واحد زمانی

    // شبیه‌سازی
    initial begin
        // مقداردهی اولیه
        clock = 0;
        reset = 0;
        opcode = 3'b000;
        Data_bus_in = 8'b00000000;

        // فعال کردن reset
        $display("Starting reset...");
        reset = 1;
        #10;
        reset = 0;
        $display("Reset completed.");

        // تست عملیات ADD
        $display("Testing ADD operation...");
        opcode = 3'b000; // فرض کنید 3'b000 مربوط به ADD باشد
        Data_bus_in = 8'b00001010; // ورودی داده به ALU
        #10;
        $display("Accumulator after ADD: %b", out_acc);

        // تست عملیات LOAD
        $display("Testing LOAD operation...");
        opcode = 3'b001; // فرض کنید 3'b001 مربوط به LOAD باشد
        Data_bus_in = 8'b00001111; // داده جدید برای LOAD
        #10;
        $display("Accumulator after LOAD: %b", out_acc);

        // تست عملیات STORE (تاثیری بر Accumulator ندارد)
        $display("Testing STORE operation...");
        opcode = 3'b010; // فرض کنید 3'b010 مربوط به STORE باشد
        Data_bus_in = 8'b00000000;
        #10;
        $display("Accumulator after STORE: %b", out_acc);

        // اتمام شبیه‌سازی
        $display("Testbench completed.");
        $stop;
    end

endmodule
