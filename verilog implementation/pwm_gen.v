module pwm_gen( output pwm,input [7:0] duty,input clk);
reg [7:0] count=0;
always @(posedge clk)
begin 
if(count==99)
count<=0;
else
count<=count+1;
end

assign pwm=(count<=duty)?1:0;

endmodule
