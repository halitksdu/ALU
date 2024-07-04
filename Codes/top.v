module top(
    input [31:0] A,
    input [31:0] B,
    input [5:0] op,
    output reg [31:0] out);
    
    // Function control:
    wire arith_op;
    wire [1:0] logic_op;
    wire [1:0] shifter_op;
    wire [2:0] cmp_op;
    wire [1:0] unit_sel;

    FunctionControl Control(op, arith_op, logic_op,shifter_op,cmp_op,unit_sel);


    // Modüller:
    wire [31:0] out_arith;
    ArithmeticUnit  Arith(A, B, arith_op, out_arith);

    wire [31:0] out_logic;
    LogicUnit       Logic( A, B, logic_op, out_logic);

    wire [31:0] out_shifter;
    ShifterUnit     Shift(A, B, shifter_op, out_shifter);

    wire [31:0] out_comp;
    ComparisonUnit  Comparision( A, B, cmp_op, out_comp);


    // Seçici:
    always @(*) begin
        case(unit_sel) 
            2'b00: begin
                out = out_arith;
            end
            2'b01: begin
                out = out_logic;
            end
            2'b10: begin
                out = out_shifter;
            end
            2'b11: begin
                out = out_comp;
            end
        endcase
    end
    
    
endmodule