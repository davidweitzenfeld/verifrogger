//============================================================================//
//                                                                            //
//      Parameterize Counter                                                  //
//                                                                            //
//      Module name: counter                                                  //
//      Desc: parameterized counter, counts up/down in any increment          //
//      Date: Oct 2011                                                        //
//      Developer: Rurik Primiani & Wesley New                                //
//      Licence: GNU General Public License ver 3                             //
//      Notes:                                                                //
//                                                                            //
//============================================================================//

module counter #(
      //==============================
      // Top level block parameters
      //==============================
      parameter DATA_WIDTH   = 20,               // number of bits in counter
      parameter COUNT_FROM   = 0,                // start with this number   
      parameter COUNT_TO     = 2^(DATA_WIDTH-1), // value to count to in CL case
      parameter STEP         = 1                 // negative or positive, sets direction
   ) (
      //===============
      // Input Ports
      //===============
      input clk,
      input en,
      input rst,
      
      //===============
      // Output Ports
      //===============
      output reg [DATA_WIDTH-1:0] out
   );
   wire [DATA_WIDTH-1:0] count;
   reg count;
   // Synchronous logic
   always @(posedge clk)
   begin
      // if ACTIVE_LOW_RST is defined then reset on a low
      // this should be defined on a system-wide basis
      if ((`ifdef ACTIVE_LOW_RST rst `else !rst `endif) && out < COUNT_TO)
      begin
         if (en == 1)
         begin
            count <= count + STEP;
            if(count == COUNT_TO)
            begin
               out <= 1;
            end
         end
      end
      else
      begin
         count <= COUNT_FROM;
         out <= 0;
      end // else: if(rst != 0)
   end
endmodule