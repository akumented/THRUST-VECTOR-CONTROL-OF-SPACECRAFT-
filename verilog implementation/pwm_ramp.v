module pwm_ramp
#(
    parameter STEP = 1,
    parameter RAMP_COUNT = 392000      // ~1 second ramp (100 MHz)
)
(
    input wire clk,
    input wire rst,

    input wire [7:0] target_pwm,

    output reg [7:0] current_pwm
);

    reg [31:0] counter;

    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            counter <= 0;
            current_pwm <= 0;
        end
        else
        begin

            if(counter == RAMP_COUNT-1)
            begin
                counter <= 0;

                if(current_pwm < target_pwm)
                begin
                    if(current_pwm + STEP > target_pwm)
                        current_pwm <= target_pwm;
                    else
                        current_pwm <= current_pwm + STEP;
                end

                else if(current_pwm > target_pwm)
                begin
                    if(current_pwm < STEP)
                        current_pwm <= 0;
                    else if(current_pwm - STEP < target_pwm)
                        current_pwm <= target_pwm;
                    else
                        current_pwm <= current_pwm - STEP;
                end

            end
            else
                counter <= counter + 1;

        end
    end

endmodule
