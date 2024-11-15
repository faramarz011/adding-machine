module Memory (
    input clock,
    input read,           // سیگنال خواندن
    input write,          // سیگنال نوشتن
    input [7:0] address,  // آدرس (فرض می‌کنیم 8 بیت)
    input [15:0] data_in, // داده ورودی (16 بیت)
    output reg [15:0] data_out // داده خروجی (16 بیت)
);

    // تعریف حافظه با سایز 256 کلمه 16 بیتی
    reg [15:0] mem [0:255];

    // بارگذاری داده‌ها از فایل در زمان شروع شبیه‌سازی
    initial begin
        $readmemh("mem.txt", mem); 
    end

    always @(posedge clock) begin
        if (write) begin
            // نوشتن در حافظه در آدرس مشخص شده
            mem[address] <= data_in;
            data_out <=mem[address];
        end
        if (read) begin
            // خواندن از حافظه در آدرس مشخص شده
            data_out <= mem[address];
            $writememh("mem.txt", mem);

        end
    end
endmodule
