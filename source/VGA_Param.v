
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

