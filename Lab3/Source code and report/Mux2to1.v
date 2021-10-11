module Mux2to1( data0_i, data1_i, select_i, data_o );

parameter size = 0;			   
			
//I/O ports               
input wire	[size-1:0] data0_i;          
input wire	[size-1:0] data1_i;
input wire	select_i;
output wire	[size-1:0] data_o; 

//reg [size-1:0] data;

//Main function
/*your code here*/

assign data_o = (select_i == 1) ? data1_i : data0_i;

/*always @ ( * ) begin
    if (select_i) begin
        data <= data1_i;
    end else begin
        data <= data0_i;
    end
end
assign data_o = data; 
*/
endmodule      
    