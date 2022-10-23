`include "defines.v"

module branch_check (registerval1, registerval2, cuBranchComm, branch_condition_check);
  input [`MAX_LENGTH-1: 0] registerval1, registerval2;
  input [1:0] cuBranchComm;
  output reg branch_condition_check;

  always @ ( * ) begin
    case (cuBranchComm)
      `JUMP_CONDITION: branch_condition_check <= 1;
      `BEZ_CONDITION: branch_condition_check <= (registerval1 == 0) ? 1 : 0;
      `BNE_CONDITION: branch_condition_check <= (registerval1 != registerval2) ? 1 : 0;
      default: branch_condition_check <= 0;
    endcase
  end
endmodule 
