module Moore(reset , ACK , START , A0,A1,A2,A3,A4,A5,A6,A7,A8,A9 ,location,clk,Done1,counter1);
input  [6:0] A0,A1,A2,A3,A4,A5,A6,A7,A8,A9 ;
input reset , ACK , START , clk;
output [3:0] location;
output Done1;
output [6:0]counter1;
reg [3:0] location, state ;
reg [6:0] Ain [9:0];
reg[3:0] i ,j ,m;
reg [6:0]counter1;



 
parameter  INITIAL = 4'b0001;
 parameter Zero = 4'b0010;
 parameter right= 4'b0011;
 parameter inc_J= 4'b0100;
 parameter compare = 4'b0101;
 parameter go = 4'b0110;
 parameter left= 4'b0111;
 parameter dec_m = 4'b1000;
  parameter decide = 4'b1001;
  parameter loc = 4'b1010;
 parameter  lastindex= 4'b1100;
 parameter Done = 4'b1101;

 


always @(posedge clk or posedge reset) 
begin  : CU_DU
    if (reset)
       begin
        state<= INITIAL;
        end
        
    else
       begin
        
         case (state)
	        INITIAL: 
	          begin
                    i<= 4'b0;
                    counter1<=7'b0;
        location<= 4'b0;
        Ain[0]<=A0;
        Ain[1]<=A1;
        Ain[2]<=A2;
        Ain[3]<=A3;
        Ain[4]<=A4;
        Ain[5]<=A5;
        Ain[6]<=A6;
        Ain[7]<=A7;
        Ain[8]<=A8;
        Ain[9]<=A9;

		         if (START)
		           state <= Zero;
                          else
                          state<=INITIAL;
                end

                Zero:
                begin
                counter1<=counter1+1;
                j<=i;
                state<= right;
                end

                right:
                begin
                  counter1<=counter1+1;
                  if(Ain[j+1]<=Ain[i])
                      state<= compare;
                 else 
                    state<=inc_J;

                end

                inc_J:
                begin
                  counter1<=counter1+1;
                  j<=j+1;
                  if(j<9)
                    state<=right;
                  else
                    state<= loc;
                end
           
                compare:
                begin
                  counter1<=counter1+1;
                  i<=i+1;
                  if(i<9)
                    state<= go;
                    else
                    state<= lastindex;
                  
                end

                go:
                begin
                counter1<=counter1+1;
                m<=i;
                j<=i;
                state<=left;
                end

                left:
                begin
                  counter1<=counter1+1;
                  if(Ain[m-1]<Ain[i])
                    state<=dec_m;
                  else
                    state<= compare;
                end

                dec_m:
                begin
                counter1<=counter1+1;
                m<=m-1;
                if(m<=1)
                 state<=decide;
                 else
                 state<=left;
                end

                decide:
                begin
                 counter1<=counter1+1;
                if(i==9)
                  state<=loc;
                  else
                  state<= right;
                end


                lastindex:
                begin
                  counter1<=counter1+1;
                  i<=i+5;
                  state<=loc;
                end

                loc:
                begin
                counter1<=counter1+1;
                location<=i;
                state<=Done;
                end

                Done:
                begin
                  if(ACK)
                    state<=INITIAL;
                    else
                    state<=Done;
                end

                endcase
                end 
                end
         assign Done1 = (state==Done);
      endmodule

