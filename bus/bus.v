module bus(m0_grant, m1_grant, m_din, s0_sel, s1_sel, s_address, s_wr, s_din,
				clk, reset_n, m0_req, m0_wr, m0_address, m0_dout,
				m1_req, m1_wr, m1_address, m1_dout, s0_dout, s1_dout);
	//2 master, 2 slave bus module
				
	input clk, reset_n, m0_req, m0_wr, m1_req, m1_wr;
	input [7:0] m0_address, m1_address;
	input [31:0] m0_dout, m1_dout, s0_dout, s1_dout;
	output m0_grant, m1_grant, s0_sel, s1_sel, s_wr;
	output [7:0] s_address;
	output [31:0] m_din, s_din;
	
	//arbiter
	assign m0_grant = ~m1_grant;
	register_r U0_register(m1_grant_next, clk, reset_n, m1_grant);
	arbiter U0_arbiter(m1_grant, m0_req, m1_req, m1_grant_next);
	
	//MUX with grant
	mx2 U1_mx2(s_wr, m0_wr, m1_wr, m1_grant);
	mx2_8bits U1_mx2_8bits(s_address, m0_address, m1_address, m1_grant);
	mx2_32bits U1_mx2_32bits(s_din, m0_dout, m1_dout, m1_grant);
	
	//address decoder
	address_decoder U2_address_decoder(s0_sel, s1_sel, s_address);
	
	//master din Mux
	register_r U3_0_register(s0_sel_next, clk, reset_n, s0_sel);
	register_r U3_1_register(s1_sel_next, clk, reset_n, s1_sel);
	mx3_32bits U3_mx3_32bits(m_din, 32'b0, s0_dout, s1_dout, {s0_sel_next, s1_sel_next});
endmodule
