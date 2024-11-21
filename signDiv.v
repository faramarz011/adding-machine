module DivSigned (
    input clock,           // کلاک
    input reset,           // ریست
    input start,           // سیگنال شروع عملیات
    input [7:0] dividend,  // مقسوم (8 بیت)
    input [7:0] divisor,   // مقسوم‌علیه (8 بیت)
    output reg [7:0] quotient,  // خارج‌قسمت (8 بیت)
    output reg [7:0] remainder, // باقی‌مانده (8 بیت)
    output reg ready           // سیگنال آماده بودن نتیجه
);

    // رجیسترهای داخلی برای ذخیره مقادیر
    reg [7:0] dividend_reg;
    reg [7:0] divisor_reg;
    reg [7:0] abs_dividend;
    reg [7:0] abs_divisor;
    reg sign; // بیت علامت خارج‌قسمت

    // حالت‌های ماشین حالت
    typedef enum logic [1:0] {
        IDLE = 2'b00,    // حالت آماده
        CALC = 2'b01,    // حالت محاسبه
        DONE = 2'b10     // حالت تکمیل
    } state_t;
    state_t current_state, next_state;

    // کنترل وضعیت
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // ماشین حالت
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (start) begin
                    next_state = CALC;
                end else begin
                    next_state = IDLE;
                end
            end
            CALC: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // انجام عملیات تقسیم
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // مقداردهی اولیه
            quotient <= 8'b0;
            remainder <= 8'b0;
            ready <= 1'b0;
        end else begin
            case (current_state)
                IDLE: begin
                    // بارگذاری مقادیر ورودی
                    dividend_reg <= dividend;
                    divisor_reg <= divisor;
                    abs_dividend <= (dividend[7] == 1'b1) ? -dividend : dividend; // مقدار بدون علامت مقسوم
                    abs_divisor <= (divisor[7] == 1'b1) ? -divisor : divisor;     // مقدار بدون علامت مقسوم‌علیه
                    sign <= dividend[7] ^ divisor[7]; // تعیین علامت خارج‌قسمت
                    ready <= 1'b0;
                end
                CALC: begin
                    // محاسبه خارج‌قسمت و باقی‌مانده
                    if (abs_divisor != 0) begin
                        quotient <= sign ? -(abs_dividend / abs_divisor) : (abs_dividend / abs_divisor);
                        remainder <= abs_dividend % abs_divisor;
                    end else begin
                        quotient <= 8'b0; // در صورت تقسیم بر صفر
                        remainder <= abs_dividend;
                    end
                end
                DONE: begin
                    ready <= 1'b1; // سیگنال آماده بودن نتیجه
                end
            endcase
        end
    end

endmodule
