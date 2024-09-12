module Mealy(reset , ACK , START , A0,A1,A2,A3,A4,A5,A6,A7,A8,A9 ,location,clk,Done2,counter2);
input  [6:0] A0,A1,A2,A3,A4,A5,A6,A7,A8,A9 ;
input reset , ACK , START , clk;
output [3:0] location;
output Done2;
output [6:0] counter2;
reg [3:0] location,i;
reg [1:0] state;
reg [6:0] Ain [9:0];
reg [6:0] counter2;

  
  
  parameter INITIAL  =3'b00;
  parameter  hold    =3'b01;
  parameter compute  =3'b10;
  parameter Done     =3'b11;
  
  always @(posedge clk or  posedge reset) 

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
                i<=3'b1;
                location<=4'b0;
                counter2<=7'b0;
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
                if(START)
                  state<= hold;
              end
 			hold:
                begin 
                  counter2<=counter2+1;
                  state <= compute;
               end

                    compute:
                    begin //compute
                    counter2<=counter2+1;
                      if(i>=0 && i<=9)
                        begin //loop
                         state<=hold;
                       if(location==0)
                          begin //loc==0
                           if(Ain[location]<Ain[i])
                             i<=i+1;
                           else
                             begin//else for loc==0
                             location<=location+1;
                             i<=i+1;
                             end //else for loc==0
                          end //loc==0


                       else if(location>0 && location<9)
                       begin //in between
                          if(i==9)
                          begin //i==9
                             if(Ain[location]<Ain[9])
                                i<=location-1;
                             else 
                                location<=location+1;
                          end//i==9
                          else
                          begin//i!=9
                             if(location<i)
                                begin //loc<i
                                   if(Ain[location]<Ain[i])
                                       i<=i+1;
                                   else
                                   begin //a[loc]>a[i]
                                      //location<=location+1;
                                      //i<=i+1;
                                      location<=location+1;
                                      i<=location+2;
                                   end // a[loc]>a[i]
                             end //loc<i                             
                             else
                             begin //loc>i
                               if(Ain[location]>Ain[i])
                                 i<=i-1;
                               else
                                begin//a[loc]<a[i]
                                  if(location<8)
                                   begin//loc<8
                                     i<=location+2;
                                     location<=location+1;
                                   end //loc<8
                                   else
                                   begin //loc>=8
                                    i<=location;
                                    location<=location+1;
                                   end //loc>=8
                                end //a[loc]<a[i]
                             end //loc>i
                               // end //loc<i
                          end //i!=9
                       end // in between
                       else
                         begin //loc==9
                           if(Ain[location]>Ain[i])
                             i<=i-1;
                           else
                           begin//last one (15)
                              location<=15;
                              i<=i+2;
                           end// last one 15
                         end //loc==9


                         end //loop 
                    else
                      state<=Done;                                                                            
                    
                    end//compute
                   
                   Done:
                begin
                  if(ACK)
                    state<=INITIAL;
                end
               endcase     
      end
   end
              assign Done2 = (state==Done);
endmodule


