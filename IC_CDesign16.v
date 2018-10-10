/**********************************

Project Name: IC_CDesign
NameP: 4/8/16/32位加减交替定点原码除法器
Project For: IC_CurriculumDesign
Project Version: v1.01.1810051601
Project Begin Time: 2018.09.27
Last Save Time: 2018.10.05
Last Save User: ATY

***********************************

Last Err/Thought: ......
	1.sign设置两位判断溢出，两位符号位不
同为溢出。（组成P33）
	2.8位规格寄存器输入设置9位，1位符号
位,在寄存器中。
	3.先不考虑溢出问题。
	4.去掉使能端和复位端。
	5.感觉符号位没什么用啊。
	6.去掉sign多一个引脚.....就一个。

***********************************/


/*顶层模块
//divisor除数
//dividend被除数
//result商
//remainder余数
//sign符号
//clk时钟信号
32->16->8->4;33->17->9->5;
*/
module IC_CDesign(//output [1:0]sign,	//两个1位符号位
						output reg [16:0]remainder,	//16是最高位
						output reg [16:0]result,
						output [16:0]dividend,
						output [16:0]divisor,
						input clk);

wire [16:0]dividendori=17'b0_1010_0000_1010_0000;
wire [16:0]divisorori=17'b0_0001_1010_0001_1010;
assign dividend=dividendori;
assign divisor=divisorori;
wire [17:0]dividendtmp;
wire [17:0]divisortmp[16:0];
wire [17:0]remaindertmp[17:0];
wire [17:0]remaindershitmp[15:0];
wire [16:0]resulttmp[17:0];
assign resulttmp[0]=17'b0_0000_0000_0000_0000;
wire resone[17:0];
assign resone[0]=1'b1;	//首次操作为减除数

ireg irA0(dividendtmp,dividendori,clk);
chose choB1(divisortmp[0],divisorori,resone[0],clk);
adder addA1(remaindertmp[0],resone[1],dividendtmp,divisortmp[0],clk);
shift shiA1(remaindershitmp[0],resulttmp[1],remaindertmp[0],resulttmp[0],resone[1],clk);

chose choB2(divisortmp[1],divisor,resone[1],clk);
adder addA2(remaindertmp[1],resone[2],remaindershitmp[0],divisortmp[1],clk);
shift shiA2(remaindershitmp[1],resulttmp[2],remaindertmp[1],resulttmp[1],resone[2],clk);

chose choB3(divisortmp[2],divisor,resone[2],clk);
adder addA3(remaindertmp[2],resone[3],remaindershitmp[1],divisortmp[2],clk);
shift shiA3(remaindershitmp[2],resulttmp[3],remaindertmp[2],resulttmp[2],resone[3],clk);

chose choB4(divisortmp[3],divisor,resone[3],clk);
adder addA4(remaindertmp[3],resone[4],remaindershitmp[2],divisortmp[3],clk);
shift shiA4(remaindershitmp[3],resulttmp[4],remaindertmp[3],resulttmp[3],resone[4],clk);

chose choB5(divisortmp[4],divisor,resone[4],clk);
adder addA5(remaindertmp[4],resone[5],remaindershitmp[3],divisortmp[4],clk);
shift shiA5(remaindershitmp[4],resulttmp[5],remaindertmp[4],resulttmp[4],resone[5],clk);

chose choB6(divisortmp[5],divisor,resone[5],clk);
adder addA6(remaindertmp[5],resone[6],remaindershitmp[4],divisortmp[5],clk);
shift shiA6(remaindershitmp[5],resulttmp[6],remaindertmp[5],resulttmp[5],resone[6],clk);

chose choB7(divisortmp[6],divisor,resone[6],clk);
adder addA7(remaindertmp[6],resone[7],remaindershitmp[5],divisortmp[6],clk);
shift shiA7(remaindershitmp[6],resulttmp[7],remaindertmp[6],resulttmp[6],resone[7],clk);

chose choB8(divisortmp[7],divisor,resone[7],clk);
adder addA8(remaindertmp[7],resone[8],remaindershitmp[6],divisortmp[7],clk);
shift shiA8(remaindershitmp[7],resulttmp[8],remaindertmp[7],resulttmp[7],resone[8],clk);

chose choB9(divisortmp[8],divisor,resone[8],clk);
adder addA9(remaindertmp[8],resone[9],remaindershitmp[7],divisortmp[8],clk);
shift shiA9(remaindershitmp[8],resulttmp[9],remaindertmp[8],resulttmp[8],resone[9],clk);

chose choB10(divisortmp[9],divisor,resone[9],clk);
adder addA10(remaindertmp[9],resone[10],remaindershitmp[8],divisortmp[9],clk);
shift shiA10(remaindershitmp[9],resulttmp[10],remaindertmp[9],resulttmp[9],resone[10],clk);

chose choB11(divisortmp[10],divisor,resone[10],clk);
adder addA11(remaindertmp[10],resone[11],remaindershitmp[9],divisortmp[10],clk);
shift shiA11(remaindershitmp[10],resulttmp[11],remaindertmp[10],resulttmp[10],resone[11],clk);

chose choB12(divisortmp[11],divisor,resone[11],clk);
adder addA12(remaindertmp[11],resone[12],remaindershitmp[10],divisortmp[11],clk);
shift shiA12(remaindershitmp[11],resulttmp[12],remaindertmp[11],resulttmp[11],resone[12],clk);

chose choB13(divisortmp[12],divisor,resone[12],clk);
adder addA13(remaindertmp[12],resone[13],remaindershitmp[11],divisortmp[12],clk);
shift shiA13(remaindershitmp[12],resulttmp[13],remaindertmp[12],resulttmp[12],resone[13],clk);

chose choB14(divisortmp[13],divisor,resone[13],clk);
adder addA14(remaindertmp[13],resone[14],remaindershitmp[12],divisortmp[13],clk);
shift shiA14(remaindershitmp[13],resulttmp[14],remaindertmp[13],resulttmp[13],resone[14],clk);

chose choB15(divisortmp[14],divisor,resone[14],clk);
adder addA15(remaindertmp[14],resone[15],remaindershitmp[13],divisortmp[14],clk);
shift shiA15(remaindershitmp[14],resulttmp[15],remaindertmp[14],resulttmp[14],resone[15],clk);

chose choB16(divisortmp[15],divisor,resone[15],clk);
adder addA16(remaindertmp[15],resone[16],remaindershitmp[14],divisortmp[15],clk);
shift shiA16(remaindershitmp[15],resulttmp[16],remaindertmp[15],resulttmp[15],resone[16],clk);


chose choB17(divisortmp[16],divisor,resone[16],clk);
adder addA17(remaindertmp[16],resone[17],remaindershitmp[15],divisortmp[16],clk);
assign resulttmp[17]=resulttmp[16]+resone[17];
remrec rr(remaindertmp[17],remaindertmp[16],divisortmp[16],resone[17],clk);

always @(posedge clk)
begin
	result=resulttmp[17];
	if(resone[17])			//如果最后一位商为1，则不恢复余数，否则恢复余数
		remainder=remaindertmp[16];
	else if(!resone[17])
		remainder=remaindertmp[17];
end
endmodule


/*输入寄存器（16+1位输入，16+2位输出）
*/
module ireg(//output reg [1:0]sign,
				output reg [17:0]iregout,
				input [16:0]iregin,
				input clk);

always @(posedge clk)
begin
	iregout[16:0]<=iregin;
	iregout[17]<=iregin[16];
	//sign[0]<=iregin[16];
	//sign[1]<=iregin[16];
end
endmodule					


/*商寄存器（16+1位输入，16+1位输出）
（输出商只需要1位符号位，即一共17位）
*/
module oreg(output reg [16:0]oregout,
				input [16:0]oregin,
				input clk);

always @(posedge clk)
begin
	oregout<=oregin;
end
endmodule					


/*余数寄存器
*/
module remreg();
//用加法器替代
endmodule


/*加法器
*/
module adder(output reg [17:0]addout,
				output reg resone,
				input [17:0]adda,
				input [17:0]addb,
				input clk);

always @(posedge clk)
begin
	addout=adda+addb;
	resone=~addout[17];
end
endmodule


/*相反数求补器
//只有0000的补码会溢出，所以不用考虑溢出问题
*/
module complement(output reg [16:0]comout,
						input [16:0]comin,
						input clk);

reg [15:0]comtmp;

always @(posedge clk)
begin
	comtmp[0]=~comin[0];
	comtmp[1]=~comin[1];
	comtmp[2]=~comin[2];
	comtmp[3]=~comin[3];
	comtmp[4]=~comin[4];
	comtmp[5]=~comin[5];
	comtmp[6]=~comin[6];
	comtmp[7]=~comin[7];
	comtmp[8]=~comin[8];
	comtmp[9]=~comin[9];
	comtmp[10]=~comin[10];
	comtmp[11]=~comin[11];
	comtmp[12]=~comin[12];
	comtmp[13]=~comin[13];
	comtmp[14]=~comin[14];
	comtmp[15]=~comin[15];
	comtmp=comtmp+16'b0000_0000_0000_0001;
	comout=comtmp;
	comout[16]=~comin[16];
end
endmodule


/*移位器
*/
module shift(output reg [17:0]remout,
				output reg [16:0]resout,
				input [17:0]remin,
				input [16:0]resin,
				input resone,
				input clk);
				
reg [34:0]shitmp;	//35=17+18=(16+1)+(16+2)

always @(posedge clk)
begin
	shitmp[0]=resone;
	shitmp[16:1]=resin[16:1];
	shitmp[34:17]=remin[17:0];
	shitmp=shitmp<<1;
	resout=shitmp[16:0];
	remout[17:0]=shitmp[34:17];
end
endmodule


/*选择器
*/
module chose(output reg [17:0]choout,
				input [16:0]choin,
				input resreg,
				input clk);

reg [15:0]chotmp;

always @(posedge clk)
begin
	if(!resreg)
	begin
		choout[16:0]=choin;
		choout[17]=choin[16];
	end
	else if(resreg)
	begin
		chotmp[0]=~choin[0];
		chotmp[1]=~choin[1];
		chotmp[2]=~choin[2];
		chotmp[3]=~choin[3];
		chotmp[4]=~choin[4];
		chotmp[5]=~choin[5];
		chotmp[6]=~choin[6];
		chotmp[7]=~choin[7];
		chotmp[8]=~choin[8];
		chotmp[9]=~choin[9];
		chotmp[10]=~choin[10];
		chotmp[11]=~choin[11];
		chotmp[12]=~choin[12];
		chotmp[13]=~choin[13];
		chotmp[14]=~choin[14];
		chotmp[15]=~choin[15];
		chotmp=chotmp+16'b0000_0000_0000_0001;
		choout[15:0]=chotmp;
		choout[16]=~choin[16];
		choout[17]=~choin[16];
	end
end
endmodule


/*余数恢复器
*/
module remrec(output reg [17:0]rrout,
				input [17:0]rrina,
				input [17:0]rrinb,
				input rrreg,
				input clk);

always @(posedge clk)
if(!rrreg)
	rrout=rrina+rrinb;

endmodule


/*激励
`timescale 1 ns/ 1 ps
module IC;
reg clk;
wire [16:0]dividend;
wire [16:0]divisor;
wire [16:0]remainder;
wire [16:0]result;

IC_CDesign i1(
	.clk(clk),
	.dividend(dividend),
	.divisor(divisor),
	.remainder(remainder),
	.result(result));

always 
	#10 clk=~clk;

initial
begin
	clk=0;
	//dividend=17'b0_1010_0000_1010_0000;
	//divisor=17'b0_0001_1010_0001_1010;
	#1000 $stop;
end
endmodule
*/








