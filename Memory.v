module Memory (
    input reset,          // سیگنال بازنشانی
    input read,           // سیگنال خواندن
    input write,          // سیگنال نوشتن
    input [4:0] address,  // آدرس (5 بیت برای 32 آدرس)
    input [7:0] data_in,  // داده ورودی (8 بیت)
    output reg [7:0] data_out // داده خروجی (8 بیت)
);

    // تعریف حافظه با سایز 32 کلمه 8 بیتی
    reg [7:0] mem [0:31];

    // تعریف متغیر شمارنده
    integer i;

    // بارگذاری داده‌ها از فایل در زمان شروع شبیه‌سازی
    initial begin
        $readmemh("mem.txt", mem); 
    end

    // بازنشانی حافظه به صورت آسنکرون
    always @(reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                mem[i] = 8'h00; // مقداردهی صفر
            end
            data_out = 8'h00;
        end
    end

    // عملیات نوشتن به صورت آسنکرون
    always @(write, address, data_in) begin
        if (write) begin
            mem[address] = data_in; // ذخیره مقدار در حافظه
            $writememh("mem.txt", mem); // ذخیره تغییرات در فایل
        end
    end

    // عملیات خواندن به صورت آسنکرون
    always @(read, address) begin
        if (read) begin
            data_out = mem[address]; // خواندن مقدار از حافظه
        end
    end

endmodule
