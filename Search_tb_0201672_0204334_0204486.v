/*students name :  1-Hamad Maghirah
                   2- Dana Siyam
                   3-Noor Albaw  

  */

module test;
 reg reset , ACK, START ,clk;
 reg [6:0] A0,A1,A2,A3,A4,A5,A6,A7,A8,A9;
 wire [3:0] location_moore,location_mealy ;
 wire Done1;
 wire Done2;
 wire[6:0] counter2,counter1;
 

 Mealy mimim(reset , ACK , START , A0,A1,A2,A3,A4,A5,A6,A7,A8,A9 ,location_mealy,clk,Done2,counter2);
 Moore mmmmm(reset , ACK , START , A0,A1,A2,A3,A4,A5,A6,A7,A8,A9 ,location_moore,clk,Done1,counter1);

/////////////////////////////////////
initial begin  : CLK_GENERATOR
  
    clk = 0;
    forever
       begin
	  # 20 clk = ~clk;
       end 
  end

initial begin  : RESET_GENERATOR
    reset = 1;
    #40 reset = 0;
  end
//////////////////////////////////
task TEST;
 input [6:0]Ain0,Ain1,Ain2,Ain3,Ain4,Ain5,Ain6,Ain7,Ain8,Ain9 ;
   begin    
	@(posedge clk);
	 #2;  
	   A0 <= Ain0;
	   A1 <= Ain1;
	   A2 <= Ain2;
          A3 <= Ain3;
          A4 <= Ain4;
          A5 <= Ain5;
          A6 <= Ain6;
          A7 <= Ain7;
          A8 <= Ain8;
          A9 <= Ain9;
          START<=1;
        
    @(posedge clk);
	 #5;
	   START = 0;	
        wait(Done1);
            $display("Location Moore : %h",location_moore);
            $display("# of Cycles Moore : %h",counter1); 
        wait(Done2);
        $display ("Location Mealy: %h",location_mealy);
        $display ("# of Cycles Mealy : %h",counter2);

     #4;
    ACK<=1;             
  
 @(posedge clk);
	 #1;
	   ACK=0;
  
end
endtask


////////////////////////////////////
initial begin  

	   A0 = 7'b0;
	   A1 = 7'b0;
	   A2 = 7'b0;
          A3 = 7'b0;
          A4 = 7'b0;
          A5 = 7'b0;
          A6 = 7'b0;
          A7 = 7'b0;
          A8 = 7'b0;
          A9 = 7'b0;

	   START= 0;		
	   ACK = 0; 
          
         

	wait (reset);    
	@(posedge clk);
      
    TEST(7'd14,7'd 9,7'd 23,7'd 18,7'd 10,7'd 49,7'd 3,7'd 60,7'd 40,7'd 110);//9

    TEST(7'd 3,7'd 9,7'd 23,7'd 18,7'd 43,7'd 49,7'd 45,7'd 60,7'd 100,7'd 43);//0

    TEST(7'd 14,7'd 9,7'd 23,7'd 18,7'd 43,7'd 42,7'd 45,7'd 60,7'd 100,7'd 90);//6
   
    TEST(7'd14,7'd 9,7'd 23,7'd 18,7'd 43,7'd 49,7'd 45,7'd 60,7'd 100,7'd 43);//f

   

     
   $finish;
end


endmodule
