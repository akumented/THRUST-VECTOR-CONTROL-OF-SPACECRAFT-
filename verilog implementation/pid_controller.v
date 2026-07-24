module pid_controller #(
    parameter WIDTH = 32,
    parameter KP = 16'sd5,   // Proportional gain
    parameter KD = 16'sd1    // Derivative gain
)(
    input  clk,
    input  rst,
    input  signed [WIDTH-1:0] error,   // can be + or -
    output reg [7:0] duty          // 0–255
                        // 0=forward, 1=reverse
);
 reg dir;
reg signed [WIDTH-1:0] prev_error;
reg signed [WIDTH*2-1:0] control;

always @(posedge clk) begin
    if (rst) begin
        prev_error <= 0;
        duty       <= 0;
        dir        <= 0;
    end
    else begin
        // PD equation
        control <= (KP * error) +
                   (KD * (error - prev_error));

        prev_error <= error;

        // Direction handling
        if (control < 0) begin
            dir <= 1;
            control <= -control;
        end else begin
            dir <= 0;
        end

        // Saturation to 8-bit PWM range
        if (control > 255)
            duty <= 8'd255;
        else
            duty <= control[7:0];
    end
end

endmodule
