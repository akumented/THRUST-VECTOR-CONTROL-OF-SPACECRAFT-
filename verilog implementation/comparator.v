module comparator(
    output reg dir, output reg [31:0] error,
    input  [31:0] setpoint,
    input  [31:0] current
);



always @(*) begin
if (setpoint>current)
begin
error=setpoint-current;
dir=1;
end
else if (setpoint<current)
begin
error= current-setpoint;
dir=0;
end
else if (setpoint== current)
error=0;
end

endmodule
