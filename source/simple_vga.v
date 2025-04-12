`timescale 1ns/1ps



module vga_top #(parameter counter_bits = 10, bit_depth = 4)(
    input clk, reset_n, 
    output horizonal_sync, vertical_sync, 
    output [bit_depth-1:0] red, green, blue, 
    output [counter_bits-1:0] v_count, h_count
);
    
    wire clk_25m;
    wire enable_v_counter, enable_h_counter;
    
    
    // Horizontal Parameter ( Pixel )
    localparam H_SYNC_CYC   = 96;
    localparam H_SYNC_BACK  = 48;
    localparam H_SYNC_ACT   = 640; // 640 pixels of content
    localparam H_SYNC_FRONT = 16;   // Transferred to back porch to
                                // center screen
    localparam H_SYNC_MAX   = 800; // 800 effective pixels (cycles)

    // Virtical Parameter ( Line )
    localparam V_SYNC_CYC   = 2;
    localparam V_SYNC_BACK  = 33;
    localparam V_SYNC_ACT   = 480; // 480 lines of content
    localparam V_SYNC_FRONT = 10;  // Transferred to back porch to
                                // center screen
    localparam V_SYNC_MAX   = 525; // 525 effective lines

    // Start Offset
    localparam X_START      = H_SYNC_CYC + H_SYNC_BACK;
    localparam Y_START      = V_SYNC_CYC + V_SYNC_BACK;



    clk_divider #(.div_by(4)) clk_divided ( // the main clk is 100MHz
    .clk(clk),
    .reset_n(reset_n),
    .clk_tick(clk_25m)
    );

    counter #(.final_value(H_SYNC_MAX-1), .bits(counter_bits)) horizontla_counter
            (
                .clk_25m(clk_25m),
                .reset_n(reset_n),
                .enable(1'b1),
                .count(h_count), 
                .counter_tick(enable_h_counter)
            );

    counter #(.final_value(V_SYNC_MAX-1), .bits(counter_bits)) vertical_counter
            (
                .clk_25m(clk_25m),
                .reset_n(reset_n),
                .enable(enable_h_counter), // only increment (count) when horizonal finish the row 
                .count(v_count), 
                .counter_tick(enable_v_counter)
            );

    assign vertical_sync = (v_count < V_SYNC_CYC) ? 1'b1 : 1'b0;
    assign horizonal_sync = (h_count < H_SYNC_CYC) ? 1'b1 : 1'b0;

    assign red =   (((h_count < (H_SYNC_ACT + H_SYNC_CYC + H_SYNC_BACK)) &&  // insure that we are in avtive h_region 
                     (h_count > (H_SYNC_CYC + H_SYNC_BACK - 1))) &&

                    ((v_count > (V_SYNC_CYC + V_SYNC_BACK - 1)) &&           // insure that we are in avtive h_region
                    (v_count < (V_SYNC_ACT + V_SYNC_CYC + V_SYNC_BACK)))                  
                    ) ? 'hFF:'h00;
            
            
    assign green =   (((h_count < (H_SYNC_ACT + H_SYNC_CYC + H_SYNC_BACK)) &&  // insure that we are in avtive h_region 
                     (h_count > (H_SYNC_CYC + H_SYNC_BACK - 1))) &&

                    ((v_count > (V_SYNC_CYC + V_SYNC_BACK - 1)) &&           // insure that we are in avtive h_region
                    (v_count < (V_SYNC_ACT + V_SYNC_CYC + V_SYNC_BACK)))                  
                    ) ? 'hFF:'h00;
            
            
    assign blue =   (((h_count < (H_SYNC_ACT + H_SYNC_CYC + H_SYNC_BACK)) &&  // insure that we are in avtive h_region 
                     (h_count > (H_SYNC_CYC + H_SYNC_BACK - 1))) &&

                    ((v_count > (V_SYNC_CYC + V_SYNC_BACK - 1)) &&           // insure that we are in avtive h_region
                    (v_count < (V_SYNC_ACT + V_SYNC_CYC + V_SYNC_BACK)))                  
                    ) ? 'hFF:'h00;
            
            
endmodule