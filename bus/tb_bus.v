`timescale 1ns/100ps

module tb_bus();		//testbench of bus
	reg clk, reset_n, m0_req, m0_wr, m1_req, m1_wr;
	reg [7:0] m0_address, m1_address;
	reg [31:0] m0_dout, m1_dout, s0_dout, s1_dout;
	wire m0_grant, m1_grant, s0_sel, s1_sel, s_wr;
	wire [7:0] s_address;
	wire [31:0] m_din, s_din;
	
	bus U0_bus(m0_grant, m1_grant, m_din, s0_sel, s1_sel, s_address, s_wr, s_din,
				clk, reset_n, m0_req, m0_wr, m0_address, m0_dout,
				m1_req, m1_wr, m1_address, m1_dout, s0_dout, s1_dout);
				
	always begin clk = 0; #5; clk = 1; #5; end

	initial begin
		reset_n = 1; s0_dout = 32'h1111_1111; s1_dout = 32'h2222_2222;			//initialize
		
		//master = m0, slave = s0, readmode, master input = s0
		m0_req = 1'b0; m0_wr = 1'b0; m0_address = 8'b0001_1111; m0_dout = 32'h1234_5678;
		m1_req = 1'b0; m1_wr = 1'b0; m1_address = 8'b0011_1111; m1_dout = 32'hfedc_da98; #10;
		
		//master = m0, slave = s0, writemode, master input = s0
		m0_req = 1'b0; m0_wr = 1'b1; m0_address = 8'b0001_1111; m0_dout = 32'h1234_5678;
		m1_req = 1'b0; m1_wr = 1'b0; m1_address = 8'b0011_1111; m1_dout = 32'hfedc_da98; #10;	
		
		//same
		m0_req = 1'b1; m0_wr = 1'b1; m0_address = 8'b0001_1111; m0_dout = 32'h1234_5678;
		m1_req = 1'b0; m1_wr = 1'b0; m1_address = 8'b0011_1111; m1_dout = 32'hfedc_da98; #10;
		
		//same
		m0_req = 1'b1; m0_wr = 1'b1; m0_address = 8'b0001_1111; m0_dout = 32'h1234_5678;
		m1_req = 1'b1; m1_wr = 1'b0; m1_address = 8'b0011_1111; m1_dout = 32'hfedc_da98; #10;
		
		//master = m1, slave = s1, readmode, master input = s1
		m0_req = 1'b0; m0_wr = 1'b1; m0_address = 8'b0001_1111; m0_dout = 32'h1234_5678;
		m1_req = 1'b1; m1_wr = 1'b0; m1_address = 8'b0011_1111; m1_dout = 32'hfedc_da98; #10;
		
		//same
		m0_req = 1'b1; m0_wr = 1'b1; m0_address = 8'b0001_1111; m0_dout = 32'h1234_5678;
		m1_req = 1'b1; m1_wr = 1'b0; m1_address = 8'b0011_1111; m1_dout = 32'hfedc_da98; #10;
		
		//master = m0, slave = s0, writemode, master input = s0
		m0_req = 1'b1; m0_wr = 1'b1; m0_address = 8'b0001_1111; m0_dout = 32'h1234_5678;
		m1_req = 1'b0; m1_wr = 1'b0; m1_address = 8'b0011_1111; m1_dout = 32'hfedc_da98; #10;
		
		//master = m0, slave = none, writemode, master input = 0
		m0_req = 1'b1; m0_wr = 1'b1; m0_address = 8'b0101_1111; m0_dout = 32'h1234_5678;
		m1_req = 1'b0; m1_wr = 1'b0; m1_address = 8'b0011_1111; m1_dout = 32'hfedc_da98; #20;
		
		
		$stop;
	end
endmodule

		
		