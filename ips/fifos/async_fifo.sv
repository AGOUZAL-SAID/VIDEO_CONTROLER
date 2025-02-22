/****************************************************************
 * 
 * Module      : asynchronous fifo
 * Author      : Alexis Polti <polti@enst.fr>
 * Date        : 12/11/2005
 * Description : this module is an asynchronous fifo, based on the 
 *               paper of Cummings. It is not fully optimized to
 *               avoid painfull Static Timing Analysis.
 * Adaptation YM/2012  ELEC222
 * 
 ***************************************************************/

 // rst : reset de la fifo asynchrone
 // rclk : horloge de lecture
 // read : requête de lecture (en fait la lecture est permanente, read fait incrémenter l'adresse)
 // rdata : donnée lue
 // rempty : indicateur de fifo vide (dans le domaine rclk)
 // wclk : horloge d'écriture
 // wdata : donnée à écrire
 // write : ordre d'écriture
 // wfull : indicateur de fifo pleine (dans le domaine wclk)
 // walmost_full : indicateur de fifo presque pleine (dans le domaine wclk)


module async_fifo
  #(
      parameter DATA_WIDTH  = 8, 
      parameter DEPTH_WIDTH = 8,
      parameter ALMOST_FULL_THRESHOLD = 255
  )
  (
      input  wire   rst, 
      input  wire   rclk, 
      input  wire   read, 
      output logic  [DATA_WIDTH-1:0] rdata, 
      output logic  rempty, 
      input  wire   wclk, 
      input  wire   [DATA_WIDTH-1:0] wdata, 
      input  wire   write, 
      output logic  wfull,
      output logic  walmost_full
   );

   localparam  ADDR_WIDTH = DEPTH_WIDTH;
   localparam  [DEPTH_WIDTH:0]  DEPTH = (DEPTH_WIDTH+1)'(1 << DEPTH_WIDTH);
   
   function [ADDR_WIDTH:0] bin2gray;
      input [ADDR_WIDTH:0]   bin;
      begin
         bin2gray = (bin>>1) ^ bin;
      end
   endfunction
   
   function [ADDR_WIDTH:0] gray2bin;
      input [ADDR_WIDTH:0] gray;
      integer              i;
      begin
         for (i=0; i<(ADDR_WIDTH+1); i=i+1)
           gray2bin[i] = ^(gray>>i);
      end
   endfunction
        
   /* Signals */
   wire [ADDR_WIDTH-1:0]    raddr, waddr;
   logic [ADDR_WIDTH:0]     rptr_gray, wptr_gray;
   wire                     write_ena;
   wire                     read_ena;

// La mémoire  de la FIFO
// Attention les mémoires double port inférées ont un comportement non
// prévisible lorsqu'il y a une lecture et une écriture à la même adresse.
// Les outils de synthèse ne savent pas détecter si ce cas peut arriver ou 
// non. Ils peuvent ajouter une logique de "bypass" inutile autour de la mémoire
// Attention, par construction nous garantissons que la lecture et l'ecriture ne 
// sont pas à la même adresse. Nous utilisons des attributs spécifiques aux outils
// pour guider la synthèse
// The 2 attributes are equivalent; the first targets Precision RTL synthesis
// and the second QuartusII
//(* synthesis, ignore_ram_rw_collision =  "true" *)
(* altera_attribute = "-name  add_pass_through_logic_to_inferred_rams off" *)
   logic [DATA_WIDTH-1:0]     mem [DEPTH-1:0];
 
   always @(posedge wclk) 
   begin
      if (write_ena) 
           mem[waddr] <= wdata;
   end
   always @(posedge rclk) 
           rdata <= mem[raddr];
   
   
   /* A write is accepted if it is requested and the fifo is not full */
   assign  write_ena = write & ~wfull;

   
   /* A read is accepted if it is requested and the fifo is not empty */
   assign  read_ena = read & ~rempty;

   
   /* Synchronize read-pointer to write domain */
   logic [ADDR_WIDTH:0]       w_rptr_gray, w_rptr_gray_temp;
   always @(posedge wclk , posedge rst)
     if(rst)
       begin
          w_rptr_gray_temp <= {(ADDR_WIDTH+1){1'b0}};
          w_rptr_gray <= {(ADDR_WIDTH+1){1'b0}};
       end
     else
       begin
          w_rptr_gray_temp <= rptr_gray;
          w_rptr_gray <= w_rptr_gray_temp;
       end

   
   /* Synchronize write-pointer to read domain */
   logic [ADDR_WIDTH:0]       r_wptr_gray, r_wptr_gray_temp;
   always @(posedge rclk, posedge rst)
     if(rst)
       begin
          r_wptr_gray_temp <= {(ADDR_WIDTH+1){1'b0}};
          r_wptr_gray <= {(ADDR_WIDTH+1){1'b0}};
       end
     else
       begin
          r_wptr_gray_temp <= wptr_gray;
          r_wptr_gray <= r_wptr_gray_temp;
       end
   

   /* Handling of write pointer and waddr */
   logic [ADDR_WIDTH:0]   wptr_bin;
   wire [ADDR_WIDTH:0]  wptr_bin_next, wptr_gray_next;
   
   
   always @ (posedge wclk, posedge rst)
     if (rst) 
       {wptr_bin, wptr_gray}  <= {2*ADDR_WIDTH+2{1'b0}};
     else if(write_ena)
       {wptr_bin, wptr_gray}  <= {wptr_bin_next, wptr_gray_next};

   
   assign               waddr = wptr_bin[ADDR_WIDTH-1:0];
   assign               wptr_bin_next = wptr_bin + 1'b1;
   assign               wptr_gray_next = bin2gray(wptr_bin_next);

   // handling of full condition : get rptr_bin (through its gray version), and compare pointers
   wire [ADDR_WIDTH:0]  w_rptr_bin;
   assign               w_rptr_bin = gray2bin(w_rptr_gray);

   wire [DEPTH_WIDTH:0] wdiff_ptr = (write_ena ? wptr_bin_next : wptr_bin) - w_rptr_bin;
   always @(posedge wclk, posedge rst)
     if(rst)   
     begin
       wfull <= 1'b0;
       walmost_full <= 1'b0;
     end
     else
     begin
       wfull <= wdiff_ptr > (DEPTH-1);
       walmost_full <= wdiff_ptr > ALMOST_FULL_THRESHOLD;
     end

   /* Handling of read pointer and raddr */
   logic [ADDR_WIDTH:0]   rptr_bin;
   wire [ADDR_WIDTH:0]  rptr_bin_next, rptr_gray_next;
   
   always @ (posedge rclk, posedge rst)
     if (rst) 
       {rptr_bin, rptr_gray}  <= {(2*ADDR_WIDTH+2){1'b0}};
     else if(read_ena)
       {rptr_bin, rptr_gray}  <= {rptr_bin_next, rptr_gray_next};

   assign               raddr = read_ena ? rptr_bin_next[ADDR_WIDTH-1:0] : rptr_bin[ADDR_WIDTH-1:0];
   assign               rptr_bin_next = rptr_bin + 1'b1;
   assign               rptr_gray_next = bin2gray(rptr_bin_next);

   // handling of empty condition : get wptr_bin (through its gray version), and compare pointers
   wire [ADDR_WIDTH:0]  r_wptr_bin;
   assign               r_wptr_bin = gray2bin(r_wptr_gray);

   always @(posedge rclk, posedge rst)
     if(rst)   
       rempty <= 1'b1;
     else
       rempty <= (r_wptr_bin - (read_ena ? rptr_bin_next : rptr_bin)) == 0;

   
endmodule


