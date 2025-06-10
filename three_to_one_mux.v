
module three_to_one_mux(in0, in1, in2, sel, out);
    input [31:0] in0, in1, in2;      // registers to choose from
    input [1:0] sel;                // ForwardA or ForwardB
    output reg [31:0] out;           // chosen register
    
    always@(*) begin
        if(sel == 2'b00)
            out = in0;
        else if(sel == 2'b01)
            out = in1;
        else if(sel == 2'b10)
            out = in2;
    end
endmodule
