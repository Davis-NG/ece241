// Tester
//TESTCASES=64
`timescale 1 ns/10 ps 
module part3_tb;
    //input
    reg [7:0] in;
	reg reset;
	reg clock;
	reg ParallelLoadn;
	reg RotateRight;
	reg ASRight;

    //output
	wire [7:0] out;
	
    //golden
	reg [7:0] out_golden;
	reg passed;
	reg [2:0] select;

    part3 DUT (.clock(clock), .reset(reset), .ParallelLoadn(select[2]), .RotateRight(select[1]), .ASRight(select[0]), .Data_IN(in), .Q(out));

	task CHECK_OUT;
	begin
		if(select[2] == 0) begin
			out_golden = in;
		end else if (select[1] == 0) begin
			out_golden = {out_golden[6:0], out_golden[7]};
		end else if (select[0] == 0) begin
			out_golden = {out_golden[0], out_golden[7:1]};
		end else begin
			out_golden = {out_golden[7], out_golden[7:1]};
		end
		#1;
		$display("At cycle %d, check result", $time);
		if(out == out_golden) begin
            $display("your output = %b, golden_output = %b PASSED", out, out_golden); 
        end else begin
            $display("your output = %b, golden_output = %b FAILED", out, out_golden);
			$display("Golden output is assigned to your output to avoid propagated mistakes\n");
        end
		out_golden = out;
	end
	endtask             
		
    initial begin
		clock <= 1;
		reset <= 0;
		select <= 0;
		out_golden = 0;
		#0.5;
		$display("At cycle %d, reset circuit", $time);
		reset <= 1;
		#3;
		$display("At cycle %d, starts test cases", $time);
		reset <= 0;
		for (int i = 0; i < 8; i++) begin
			for (int j = 0; j < 8; j++) begin
				in = $urandom % 256;
				select = $urandom % 8;
				$display("At cycle %d, previous output = %b, input = %b, select = %b", $time, out, in, select);
				CHECK_OUT();
			end
		end
		$finish;
    end
	
	always
		#0.5 clock = !clock;
endmodule
