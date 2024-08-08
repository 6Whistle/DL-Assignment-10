`timescale 1ns/100ps

module tb_arbiter();
	reg m0_req, m1_req, m1_grant_before;
	wire m0_grant, m1_grant;
	
	arbiter U0_arbiter(m1_grant, m0_req, m1_req, m1_grant_before);
	
	assign m0_grant = ~m1_grant;
	
	initial begin
		m0_req = 1'b0; m1_req = 1'b0; m1_grant_before = 1'b0; #10;
		
		m0_req = 1'b1; m1_req = 1'b1; m1_grant_before = 1'b0; #10;
		
		m0_req = 1'b0; m1_req = 1'b1; m1_grant_before = 1'b0; #10;
		
		m0_req = 1'b1; m1_req = 1'b1; m1_grant_before = 1'b1; #10;
		
		m0_req = 1'b0; m1_req = 1'b0; m1_grant_before = 1'b1; #10;
		
		$stop;
	end
endmodule
