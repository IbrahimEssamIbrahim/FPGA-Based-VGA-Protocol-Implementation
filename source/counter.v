`timescale 1ns / 1ps

module counter
    #(parameter final_value = 255, bits = 8)(
    input clk_25m,
    input reset_n,
    input enable,
    output [bits - 1:0] count, 
    output counter_tick
    );
        
    reg [bits - 1:0] Q_reg, Q_next;
    
    always @(posedge clk_25m, negedge reset_n)
    begin
        if (~reset_n)
            Q_reg <= 'b0;
        else if(enable)
            Q_reg <= Q_next;
        else
            Q_reg <= Q_reg;
    end
    
    // Next state logic
    assign counter_tick = Q_reg == final_value;
    
    assign count = Q_reg;
    
    always @(*)
        Q_next = (counter_tick && enable)? 'b0: Q_reg + 1;
    
    
endmodule