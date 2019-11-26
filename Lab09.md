# Lab 09

## 실습 내용
### **NEC 적외선 통신 규약 (NEC Infrared Transmission Protocol) 을 이용하여 리모컨 송신 신호 받기**

####** Leader Code**   : 프레임의 모드 선택
####** Custom Code**  : 특정 회사를 나타냄
####** Data Code**      : 송신 데이터 (데이터 확인 위해 보수 신호도 보냄)
: 우선 리모컨에 사용자가 주는 신호를 Leader Code를 받는다. Custom Code는 각 회사마다 고유의 코드를 받아주는 것을 의미하고 16비트로 이루어져있다. 마지막을 Data Code는 8비트/8비트 (총 16비트)로 이루어진 코드로 수신부로 코드를 보내는 역할을 한다. 총 16비트+16비트로 32비트를 받아준다.

#### **Top Module** 
: 각 모듈을 하나로 합치는 모듈 작성

 ```verilog 
module	top(
		o_seg_enb,
		o_seg_dp,
		o_seg,
		i_ir_rxb,
		clk,
		rst_n);

output	[5:0]	o_seg_enb	;
output		o_seg_dp	;
output	[6:0]	o_seg		;

input		i_ir_rxb	;
input		clk		;
input		rst_n		;


wire  	[31:0]  	o_data;
ir_rx   u_ir(
              .clk(clk),
              .i_ir_rxb(i_ir_rxb),
              .rst_n(rst_n),
              .o_data(o_data));
              
              
wire  [6:0] o_seg0;

//fnd_dec를 통해서 o_data의 값을 받음. 총 32비트 중에서 시계는 총 6자리이므로 4비트씩 6자리 24비트로 받아준다.
//o_seg를 0부터 5까지 6개로 구분해서 받아준다. (각 자리의 수 구분)
              
fnd_dec  u_fnd_dec_0(
                      		.i_num(o_data[3:0]), 
                      		.o_seg(o_seg0));    

wire  	[6:0] 	o_seg1;                              
fnd_dec  u_fnd_dec_1(
                     		 .i_num(o_data[7:4]),
                      		 .o_seg(o_seg1));    

wire 	[6:0] 	o_seg2;                    
fnd_dec  u_fnd_dec_2(
                     		.i_num(o_data[11:8]),
                      		.o_seg(o_seg2));

wire  	[6:0]	o_seg3;                    
fnd_dec  u_fnd_dec_3(
                     		 .i_num( o_data[15:12]),
                     		 .o_seg(o_seg3));                        

wire  	[6:0] 	o_seg4;                    
fnd_dec  u_fnd_dec_4(
                      		.i_num( o_data[19:16]),
                     		 .o_seg(o_seg4));   

wire  	[6:0] 	o_seg5;                                           
fnd_dec  u_fnd_dec_5(
                     		 .i_num( o_data[23:20]),
                      		.o_seg(o_seg5));
                      
wire  	[6:0] 	o_seg;
wire        	o_seg_dp;
wire  	[5:0] 	o_seg_enb; 
wire  	[41:0]	 i_six_digit_seg; //42비트로 받아서 led_disp로 연결해준다.

assign i_six_digit_seg = {o_seg5, o_seg4, o_seg3, o_seg2, o_seg1, o_seg0 }; //aasign문을 이용해서 시계에 들어갈 수 설정
							          //이 때, 순서는 거꾸로 넣어줌에 주의해야함.
                     
led_disp  u_led_disp(
                         .clk(clk),
                     	 .i_six_digit_seg(i_six_digit_seg),
                      	 .i_six_dp(6'h0),
                     	 .rst_n(rst_n),
                      	 .o_seg(o_seg),
                     	 .o_seg_dp(o_seg_dp),
                     	 .o_seg_enb(o_seg_enb));                                            
                                           
endmodule
 ```
###Wavefunction 분석
![](https://github.com/tjrwldnjs/LogicDesign/blob/master/practice09/%EC%BA%A1%EC%B2%98.PNG)

: wavefunction은 Leader Code, Custom Code, Data Code로 나뉜다. ir_rxb와 ir_rx는 코드에 따라 반전임을 볼 수 있는데, ir_rxb는 리모컨의 신호이, ir_rx는 코드로 받아주는 신호이다.
 또한 state가 1씩 증가할 때 마다 cnt32가 각 state 당 32비트로 표현되는 것을 볼 수 있다.



###FPGA실습
![](https://github.com/tjrwldnjs/LogicDesign/blob/master/practice09/KakaoTalk_20191126_194824026.jpg)
![](https://github.com/tjrwldnjs/LogicDesign/blob/master/practice09/KakaoTalk_20191126_194823189.jpg)



<!--stackedit_data:
eyJoaXN0b3J5IjpbLTk0NDkzNzUzMV19
-->