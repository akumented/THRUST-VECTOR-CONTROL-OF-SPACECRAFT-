module commutation_logic (
    input pwm,           // PWM input
    input Hab, Hbc, Hca, // Hall effect sensor inputs
    input dir,           // Direction: 0 = Forward, 1 = Reverse
    output reg A_high, A_low,
    output reg B_high, B_low,
    output reg C_high, C_low
);

always @(*) begin
    // Default all outputs OFF
    A_high = 0; A_low = 0;
    B_high = 0; B_low = 0;
    C_high = 0; C_low = 0;

    case ({Hab, Hbc, Hca})
        // ---------------- FORWARD direction ----------------
        3'b001: if (!dir) begin A_high = pwm; B_low = 1; end
                else begin B_high = pwm; A_low = 1; end

        3'b101: if (!dir) begin A_high = pwm; C_low = 1; end
                else begin C_high = pwm; A_low = 1; end

        3'b100: if (!dir) begin B_high = pwm; C_low = 1; end
                else begin C_high = pwm; B_low = 1; end

        3'b110: if (!dir) begin B_high = pwm; A_low = 1; end
                else begin A_high = pwm; B_low = 1; end

        3'b010: if (!dir) begin C_high = pwm; A_low = 1; end
                else begin A_high = pwm; C_low = 1; end

        3'b011: if (!dir) begin C_high = pwm; B_low = 1; end
                else begin B_high = pwm; C_low = 1; end

        default: begin
            // Invalid state: all outputs OFF
        end
    endcase
end

endmodule
