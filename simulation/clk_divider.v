`timescale 1ns / 1ps

module clk_divider
    #(parameter div_by = 4)(
    input clk,
    input reset_n,
    output clk_tick
    );
        
    reg [$clog2(div_by) - 1:0] Q_reg, Q_next;
    
    always @(posedge clk, negedge reset_n)
    begin
        if (~reset_n)
            Q_reg <= 'b0;
        else
            Q_reg <= Q_next;
    end
    
    // Next state logic
    assign clk_tick = Q_reg == (div_by-1);

    always @(*)
        Q_next = clk_tick? 'b0: Q_reg + 1;
    
    
endmodule