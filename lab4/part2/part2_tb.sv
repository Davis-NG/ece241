// Tester
//TESTCASES=8
`timescale 1 ns/10 ps
module part2_tb;
	//input
	reg [3:0] in;
	reg reset;
	reg clock;
	reg [2:0] select;
	//output
	wire [7:0] out;
	//golden
	reg [7:0] out_golden;

	reg passed;

	part2 DUT (.Clock(clock), .Reset_b(reset), .Data(in), .Function(select), .ALUout(out));

	task CHECK_OUT;
	begin
			if(out == out_golden)
					$display("Your output = %b, expected output = %b, PASSED", out, out_golden);
			else begin
					$display("Your output = %b, expected output = %b, FAILED", out, out_golden);
					$display("Golden output is assigned to your output to avoid propagated mistakes\n");
					out_golden = out;
			end
	end
	endtask

    initial begin
		clock = 1;
		reset = 1;
		select = 0;
		in = 0;
		out_golden = 0;
		#2.5;
		$display("At cycle %d, reset circuit", $time);
		reset = 0;
		#1;
		reset = 1;
		$display("At cycle %d, starts test cases", $time);
		$display("TEST 1: checking case 0");
		in = 9;
		select = 0;
		$display("At cycle %d, Signal B = %b, Signal A = %b, select = %d", $time, out_golden[3:0], in, select);
		out_golden = out_golden + in;
		#1;
		$display("At cycle %d, Check Result", $time);
		CHECK_OUT();
		$display("TEST 2: checking case 0");
		in = 8;
		select = 0;
		$display("At cycle %d, Signal B = %b, Signal A = %b, select = %d", $time, out_golden[3:0], in, select);
		out_golden = out_golden + in;
		#1;
		$display("At cycle %d, Check Result", $time);
		CHECK_OUT();
		out_golden[7:4] = 0;
		$display("TEST 3: checking case 1");
		in = 3;
		select = 1;
		$display("At cycle %d, Signal B = %b, Signal A = %b, select = %d", $time, out_golden[3:0], in, select);
		out_golden = out_golden + in;
		#1;
		$display("At cycle %d, Check Result", $time);
		CHECK_OUT();
		$display("TEST 4: checking case 1");
		in = 4;
		select = 1;
		$display("At cycle %d, Signal B = %b, Signal A = %b, select = %d", $time, out_golden[3:0], in, select);
		out_golden = out_golden + in;
		#1;
		$display("At cycle %d, Check Result", $time);
		CHECK_OUT();
		$display("TEST 5: checking case 2");
		in = 4;
		select = 2;
		$display("At cycle %d, Signal B = %b, Signal A = %b, select = %d", $time, out_golden[3:0], in, select);
		out_golden = {{4{out_golden[3]}}, out_golden[3:0]};
		#1;
		$display("At cycle %d, Check Result", $time);
		CHECK_OUT();
		$display("TEST 6: checking case 3");
		in = 15;
		select = 3;
		$display("At cycle %d, Signal B = %b, Signal A = %b, select = %d", $time, out_golden[3:0], in, select);
		out_golden = 1;
		#1;
		$display("At cycle %d, Check Result", $time);
		CHECK_OUT();
		$display("TEST 7: checking case 1");
		in = 15;
		select = 1;
		$display("At cycle %d, Signal B = %b, Signal A = %b, select = %d", $time, out_golden[3:0], in, select);
		out_golden = out_golden + in;
		#1;
		$display("At cycle %d, Check Result", $time);
		CHECK_OUT();
		$display("TEST 8: checking case 3");
		in = 0;
		select = 3;
		$display("At cycle %d, Signal B = %b, Signal A = %b, select = %d", $time, out_golden[3:0], in, select);
		out_golden = 0;
		#1;
		$display("At cycle %d, Check Result", $time);
		CHECK_OUT();
		$finish;
        end
        always
                #0.5 clock = !clock;

endmodule

