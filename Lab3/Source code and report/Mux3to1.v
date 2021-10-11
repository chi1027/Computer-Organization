module Mux3to1( data0_i, data1_i, data2_i, select_i, data_o );

parameter size = 0;			   
			
//I/O ports               
input wire	[size-1:0] data0_i;          
input wire	[size-1:0] data1_i;
input wire	[size-1:0] data2_i;
input wire	[2-1:0] select_i;
output wire	[size-1:0] data_o; 

//reg 		[size-1:0] data; 

//Main function
/*your code here*/

assign data_o = (select_i == 2'b00) ? data0_i : 
	        (select_i == 2'b01) ? data1_i : data2_i;

/*always @ ( * ) begin
    if (select_i == 2'b00) begin
        data <= data0_i;
    end else if(select_i == 2'b01) begin
        data <= data1_i;
    end else begin
        data <= data2_i;
    end
end
assign data_o = data; 

*/
endmodule      
