// YM/TPT
// Wishbone bus modelized via an "interface"
// 4 modports are defined:
// master : master interface (for hardware synthesis)
// slave  : slave  interface (for hardware synthesis)
// tb_master : master inteface for testbenches
// tb_slave  : slave  inteface for testbenches
//  Interface definition defines 2 parameters :
//    TB_MASTER : the master modport is for a virtual VM model
//    TB_SLAVE  : the slave  modport is for a virtual VM model
// The 4 modports (master, slave, tb_master, tb_slave) cannot be defined alltogether. Even
// if only a couple of them (master, tb_slave) or (master, slave) , or (tb_master, slave)...
// are used during simulation. During elaboration phase, Modelsim complains about conflicts
// beetween "continuous assignments" (in the modules) and "procedural" (testbench).
// We use parameters, in order to restrict the interface to the following cases :
//  (master, slave)
//  (master, slave,tb_master)
//  (master, slave,tb_slave)
//  Is there a better way ?
//
//  The default parameters are for a purely RTL interface definition
//  The interface is a 4 bytes data / 32 bits addresses interface

`timescale 1ns/10ps


interface wshb_if #(parameter DATA_BYTES=4) (input logic clk, input logic rst) ;
  // WISHBONE  signals
  logic                      cyc;
  logic                      stb;
  logic  [31:0]              adr ;
  logic                      we;
  logic  [8*DATA_BYTES-1:0]  dat_ms;
  logic  [DATA_BYTES-1:0]    sel;
  logic [2:0]                cti;
  logic [1:0]                bte;
  logic                      ack;
  logic  [8*DATA_BYTES-1:0]  dat_sm;
  logic                      err;
  logic                      rty;

  //////////////// RTL Masters and slaves modports ///////////////////

  // Modport for master rtl
  modport master (
    output cyc ,
    output stb ,
    output adr ,
    output we  ,
    output dat_ms,
    output sel ,
    output cti ,
    output bte ,

    input  ack ,
    input  dat_sm,
    input  err ,
    input  rty ,

    input  clk,
    input  rst
  ) ;

  // Modport for slave rtl
  modport slave (
    input  cyc ,
    input  stb ,
    input  adr ,
    input  we,
    input  dat_ms,
    input  sel ,
    input  cti,
    input  bte,

    output ack ,
    output dat_sm,
    output err ,
    output rty ,

    input  clk,
    input  rst
  ) ;

/*
  //////////////// End of RTL Masters and slaves modports ////////////

  //////////////// TESTBENCH Masters and slaves modports /////////////
  // synthesis translate_off

   // Modport for master testbench
    modport tb_master(
      clocking cbm,
      task clockAlign()
    );

   // Clocking block for master testbench
   clocking cbm @(posedge clk);
     // WISHBONE Master signals
     output dat_ms ;
     output adr ;
     output cyc ;
     output sel ;
     output stb ;
     output we ;
     output cti;
     output bte;
     input  ack;
     input  err;
     input  rty;
     input  dat_sm;
   endclocking


    // Modport for slave testbench
   modport tb_slave(
     clocking cbs,
     clocking cbs_n,
     task clockAlign()
   );

   // Clocking block 0 positive edge
   clocking cbs @(posedge clk);
     // WISHBONE Slave signals
     output dat_sm;
     output ack;
     output err;
     output rty;
     input  adr;
     input  sel;
     input  stb;
     input  we;
     input  cyc;
     input  dat_ms;
     input  cti   ;
     input  bte   ;
   endclocking

   // Clocking block 1 negative edge
   clocking cbs_n @(negedge clk);
     // WISHBONE Slave signals
     output dat_sm;
     output ack ;
     output err ;
     output rty ;
     input  adr;
     input  sel;
     input  stb;
     input  we ;
     input  cyc;
     input  dat_ms;
     input  cti   ;
     input  bte   ;
   endclocking

 // Clock edge alignment
    task clockAlign();
       wait(sync_posedge.triggered);
    endtask

    sequence sync_posedge;
      @(posedge clk) 1;
    endsequence

// synthesis translate_on
//////////////// End of TESTBENCH Masters and slaves modports /////////////
*/
endinterface

