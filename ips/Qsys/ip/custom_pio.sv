module custom_pio
(
    input logic clk,
    input logic reset,

    // memory mapped R/W slave interface
    input  logic        avs_s0_address,
    input  logic        avs_s0_read,
    input  logic        avs_s0_write,
    output logic [31:0] avs_s0_readdata,
    input  logic [31:0] avs_s0_writedata,

    // The PIO outputs
    output logic pio
);

always_comb 
begin
    if(avs_s0_read) 
    begin
        avs_s0_readdata = {31'b0, pio};
    end 
    else 
    begin
        avs_s0_readdata = 'x;
    end
end

logic [7:0] counter;
always_ff @(posedge clk) 
begin
    if(reset) 
    begin
        pio     <= 1'b0;
        counter <= '0;
    end 
    else if(avs_s0_write)
        begin
            pio     <= 1'b1;
            counter <= 8'hff;
        end
        else if(pio == 1'b1)
        begin
            if(counter > '0)
            begin
                counter <= counter - 1'b1;
            end
            else
            begin
                pio     <= 1'b0;
                counter <= '0;
            end
        end
end

endmodule
