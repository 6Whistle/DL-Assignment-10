module ram(dout, clk, cen, wen, addr, din);			//ram module
	input clk;
	input cen, wen;
	input [4:0] addr;
	input [31:0] din;
	output reg [31:0] dout;
	
	reg [31:0] mem [0:31];
	integer i;

	initial begin												//Reset
	for(i = 0; i < 32; i = i + 1)	
		mem[i] <= 32'h0000_0000;
	end

	always @(posedge clk)
	begin
		if(cen == 1'b1) begin
			if(wen == 1'b1) begin mem[addr] <= din; dout <= 32'h0; end		//if cen and wen is 1, write
			else dout <= mem[addr];							//if only cen is 1, read
		end
		else dout <= 32'h0;									//if cen is 0, no execute
	end
endmodule
