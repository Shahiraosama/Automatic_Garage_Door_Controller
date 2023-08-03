`timescale 1ns/1ps
module Automatic_Garage_Door_Controller_TB ();
reg clk_tb;
reg rst_tb;
reg UP_Max_tb;
reg DN_Max_tb;
reg Activate_tb;
wire UP_M_tb;
wire DN_M_tb;

localparam T=20;

always
begin
#(T/2) clk_tb=~clk_tb;
end

Automatic_Garage_Door_Controller DUT(
.clk(clk_tb),
.rst(rst_tb),
.UP_Max(UP_Max_tb),
.DN_Max(DN_Max_tb),
.Activate(Activate_tb),
.UP_M(UP_M_tb),
.DN_M(DN_M_tb)
);

initial 
begin
$dumpfile ("Garage_DOOr_Controller_dump.vcd");
$dumpvars;

initialize();

reset();

Activate();

UP_MAX();

Activate();

DN_MAX();

#100 $finish;

end

task initialize;
begin
clk_tb=1'b0;
Activate_tb=1'b0;
UP_Max_tb=1'b0;
DN_Max_tb=1'b1;
end
endtask


task reset;
begin
 rst_tb =  1'b1;
 #1
 rst_tb  = 1'b0;
 #1
 rst_tb  = 1'b1;
 
end
endtask


task UP_MAX;
begin
#(5*T) UP_Max_tb=1'b1; DN_Max_tb=1'b0;
end
endtask

task Activate;
begin
Activate_tb=1'b0;
#(3*T) 
Activate_tb=1'b1;
end
endtask


task DN_MAX;
begin
#(5*T) UP_Max_tb=1'b0; DN_Max_tb=1'b1;
end

endtask


endmodule
