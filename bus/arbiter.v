module arbiter(m1_grant, m0_req, m1_req, m1_grant_before);			//arbiter module
	input m0_req, m1_req, m1_grant_before;
	output reg m1_grant;
 
	always@(m0_req, m1_req, m1_grant_before) begin
		if(m1_grant_before == 1'b0) begin			//if before state is M0_GRANT
			if(m0_req == 1'b0 && m1_req == 1'b1) m1_grant = 1'b1;		//if only m1_req is 1, State change
			else m1_grant = 1'b0;	
		end
		else begin											//if before state is M1_GRANT
			if(m1_req == 1'b0) m1_grant = 1'b0;		//if m1_req is 0, state change
			else m1_grant = 1'b1;
		end
	
	end
	
endmodule
 