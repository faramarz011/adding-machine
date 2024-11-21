module ALU (
    input [7:0] a_side, b_side,    // ورودی‌ها
    input pass_add,                // سیگنال جمع
    input div_pass,                // سیگنال تقسیم
    output [7:0] alu_out           // خروجی
);
    wire [7:0] addresult;           // نتیجه جمع
    wire [7:0] divresult;           // نتیجه تقسیم
    wire div_zero;                  // بررسی تقسیم بر صفر

    // عملیات جمع
    assign addresult = a_side + b_side;
    
    // عملیات تقسیم (تقسیم صحیح)
    // در اینجا برای جلوگیری از تقسیم بر صفر، ابتدا بررسی می‌کنیم که مقسوم‌علیه صفر نباشد
    assign div_zero = (b_side == 0) ? 1'b1 : 1'b0;  // اگر مقسوم‌علیه صفر باشد
    assign divresult = (div_zero) ? 8'b00000000 : (a_side / b_side); // نتیجه تقسیم

    // انتخاب خروجی بر اساس سیگنال‌های pass_add و div_pass
    assign alu_out = (div_pass) ? divresult : (pass_add ? addresult : a_side);
    
endmodule
