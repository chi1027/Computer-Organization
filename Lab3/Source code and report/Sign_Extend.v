module Sign_Extend( data_i, data_o );

//I/O ports
input	[16-1:0] data_i;
output	[32-1:0] data_o;

//Internal Signals
wire	[32-1:0] data_o;
//reg	[32-1:0] data;

//Sign extended
/*your code here*/

assign data_o = { {16{data_i[15]}} , data_i[15:0] };

/*always @ ( * ) begin
    if (data_i[15] == 1) begin
        data <= { 16'hffff, data_i[15:0] };
    end else begin
        data <= { 16'h0000, data_i[15:0] };
    end
end

assign data_o = data;
*/
endmodule      
