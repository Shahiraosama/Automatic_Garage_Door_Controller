module Automatic_Garage_Door_Controller(
input UP_Max,DN_Max,Activate,
input clk,rst,
output reg UP_M,DN_M
);

reg [1:0] state_reg,state_next;
localparam IDLE=2'b00;
localparam Mv_Dn=2'b01;
localparam Mv_Up=2'b10;


always@(posedge clk or negedge rst)

begin

      if(!rst)
begin
      state_reg<=IDLE;
end
       else
begin
      state_reg<=state_next;
end

end

always@(*)
begin
       case(state_reg)
IDLE:
begin

       if (Activate && UP_Max && !DN_Max)
begin

       state_next=Mv_Dn;

end


       else if (Activate && !UP_Max && DN_Max )
begin

      state_next=Mv_Up;
end



       else

begin

      state_next=IDLE;

end


end


Mv_Dn:

begin

       if (DN_Max)
begin

      state_next=IDLE;

end

       else
begin

       state_next=Mv_Dn;
end

end

Mv_Up:

begin
         if(UP_Max)
begin
       state_next=IDLE;
end
           else
begin
      state_next=Mv_Up;
end

end

        default:state_next=IDLE;
endcase

end

always@(*)
begin
        case(state_reg)
IDLE:

begin
   
UP_M=1'b0;
DN_M=1'b0;

end

Mv_Dn:

begin

UP_M=1'b0;
DN_M=1'b1;

end

Mv_Up:

begin

UP_M=1'b1;
DN_M=1'b0;

end

default:

begin

UP_M  = 1'b0 ;
DN_M  = 1'b0 ;

end

endcase

end




endmodule
