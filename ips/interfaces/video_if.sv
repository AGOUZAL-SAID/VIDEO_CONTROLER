`default_nettype none

interface video_if() ;

logic CLK;
logic HS;
logic VS;
logic BLANK;
logic [23:0] RGB;

modport master (
         output CLK,
         output HS,
         output VS,
         output BLANK,
         output RGB
) ;

modport slave (
         input CLK,
         input HS,
         input VS,
         input BLANK,
         input RGB
) ;

endinterface
`default_nettype wire
