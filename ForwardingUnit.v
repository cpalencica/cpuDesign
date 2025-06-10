
module ForwardingUnit(EXMEM_Rd, MEMWB_Rd, IDEX_Rs, IDEX_Rt, EXMEM_RegWrite, MEMWB_RegWrite, ForwardA, ForwardB);
    
    input [4:0] EXMEM_Rd, MEMWB_Rd, IDEX_Rs, IDEX_Rt;      // take in the relevant registers for the logic to work
    input EXMEM_RegWrite, MEMWB_RegWrite;                                  // write back control signals
    output reg [1:0] ForwardA, ForwardB;                   // output signals to control used register
    
       
    always @ (*) begin 
        ForwardA = 2'b00;       // initialize ForwardA
        ForwardB = 2'b00;       // initialize ForwardB
        
//        if(EXMEM_Rd == IDEX_Rs) // one ahead support
//            ForwardA = 2'b10;
//        if(EXMEM_Rd == IDEX_Rt) // one ahead support
//            ForwardB = 2'b10;
//        if(EXMEM_Rd != IDEX_Rs && MEMWB_Rd == IDEX_Rs)  // two ahead support
//            ForwardA = 2'b01;
//        if(EXMEM_Rd != IDEX_Rt && MEMWB_Rd == IDEX_Rt)  // two ahead support
//            ForwardB = 2'b01;
            
        if(EXMEM_RegWrite && EXMEM_Rd != 5'b00000 && EXMEM_Rd == IDEX_Rs) // one ahead support
            ForwardA = 2'b10;
        if(EXMEM_RegWrite && EXMEM_Rd != 5'b00000 && EXMEM_Rd == IDEX_Rt) // one ahead support
            ForwardB = 2'b10;
        if(MEMWB_RegWrite && MEMWB_Rd != 5'b00000 && (EXMEM_Rd && EXMEM_RegWrite) != IDEX_Rs && MEMWB_Rd == IDEX_Rs)  // two ahead support
            ForwardA = 2'b01;
        if(MEMWB_RegWrite && MEMWB_Rd != 5'b00000 && EXMEM_Rd != IDEX_Rt && MEMWB_Rd == IDEX_Rt)  // two ahead support
            ForwardB = 2'b01;
  
            
    end

   
endmodule
