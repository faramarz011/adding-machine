module Memory (
    input clock,
    input reset,          // سیگنال بازنشانی
    input read,           // سیگنال خواندن
    input write,          // سیگنال نوشتن
    input [7:0] address,  // آدرس (فرض می‌کنیم 8 بیت)
    input [15:0] data_in, // داده ورودی (16 بیت)
    output reg [15:0] data_out // داده خروجی (16 بیت)
);

    // تعریف حافظه با سایز 256 کلمه 16 بیتی
    reg [15:0] mem [0:255];

    // تعریف متغیر شمارنده
    integer i;

    // بارگذاری داده‌ها از فایل در زمان شروع شبیه‌سازی
    initial begin
        $readmemh("mem.txt", mem); 
    end

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // بازنشانی حافظه (مقداردهی اولیه به صفر)
            for (i = 0; i < 256; i = i + 1) begin
                mem[i] <= 16'h0000;
            end
            data_out <= 16'h0000;
        end else begin
            if (write) begin
                mem[address] <= data_in;
                data_out <= data_in; // داده خروجی مستقیماً از ورودی مقدار می‌گیرد
                $writememh("mem.txt", mem); // ذخیره تغییرات در فایل
            end else if (read) begin
                data_out <= mem[address];
            end
        end
    end
endmodule
