/**********************************

Project Name: IC_CDesign
NameP: 4/8/16/32位加减交替定点原码除法器
Project For: IC_CurriculumDesign
Project Version: v1.01.181005801
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
module IC_CDesign(output [1:0]sign,	//两个1位符号位
						output reg [8:0]remainder,	//8是最高位
						output reg [8:0]result,
						input [8:0]dividend,
						input [8:0]divisor,
						input clk);

wire [9:0]dividendtmp;
wire [9:0]divisortmp[8:0];
wire [9:0]remaindertmp[9:0];
wire [9:0]remaindershitmp[7:0];
wire [8:0]resulttmp[9:0];
assign resulttmp[0]=9'b0_0000_0000;
wire resone[9:0];
assign resone[0]=1'b1;	//首次操作为减除数

ireg irA0(sign,dividendtmp,dividend,clk);
chose choB1(divisortmp[0],divisor,resone[0],clk);
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
assign resulttmp[9]=resulttmp[8]+resone[9];
remrec rr(remaindertmp[9],remaindertmp[8],divisortmp[8],resone[9],clk);

always @(posedge clk)
begin
	result=resulttmp[9];
	if(resone[9])			//如果最后一位商为1，则不恢复余数，否则恢复余数
		remainder=remaindertmp[8];
	else if(!resone[9])
		remainder=remaindertmp[9];
end
endmodule


/*输入寄存器（8+1位输入，8+2位输出）
*/
module ireg(output reg [1:0]sign,
				output reg [9:0]iregout,
				input [8:0]iregin,
				input clk);

always @(posedge clk)
begin
	iregout[8:0]<=iregin;
	iregout[9]<=iregin[8];
	sign[0]<=iregin[8];
	sign[1]<=iregin[8];
end
endmodule					


/*商寄存器（8+1位输入，8+1位输出）
（输出商只需要1位符号位，即一共9位）
*/
module oreg(output reg [8:0]oregout,
				input [8:0]oregin,
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
module adder(output reg [9:0]addout,
				output reg resone,
				input [9:0]adda,
				input [9:0]addb,
				input clk);

always @(posedge clk)
begin
	addout=adda+addb;
	resone=~addout[9];
end
endmodule


/*相反数求补器
//只有0000的补码会溢出，所以不用考虑溢出问题
*/
module complement(output reg [8:0]comout,
						input [8:0]comin,
						input clk);

reg [7:0]comtmp;

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
	comtmp=comtmp+8'b0000_0001;
	comout=comtmp;
	comout[8]=~comin[8];
end
endmodule


/*移位器
*/
module shift(output reg [9:0]remout,
				output reg [8:0]resout,
				input [9:0]remin,
				input [8:0]resin,
				input resone,
				input clk);
				
reg [18:0]shitmp;	//19=9+10=(8+1)+(8+2)

always @(posedge clk)
begin
	shitmp[0]=resone;
	shitmp[8:1]=resin[8:1];
	shitmp[18:9]=remin[9:0];
	shitmp=shitmp<<1;
	resout=shitmp[8:0];
	remout[9:0]=shitmp[18:9];
end
endmodule


/*选择器
*/
module chose(output reg [9:0]choout,
				input [8:0]choin,
				input resreg,
				input clk);

reg [7:0]chotmp;

always @(posedge clk)
begin
	if(!resreg)
	begin
		choout[8:0]=choin;
		choout[9]=choin[8];
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
		chotmp=chotmp+8'b0000_0001;
		choout[7:0]=chotmp;
		choout[8]=~choin[8];
		choout[9]=~choin[8];
	end
end
endmodule


/*余数恢复器
*/
module remrec(output reg [9:0]rrout,
				input [9:0]rrina,
				input [9:0]rrinb,
				input rrreg,
				input clk);

always @(posedge clk)
if(!rrreg)
	rrout=rrina+rrinb;

endmodule





/*激励
*/
`timescale 1ns/1ps
module IC;
wire [1:0]sign;
wire [8:0]remainder;
wire [8:0]result;
reg [8:0]divisor;
reg [8:0]dividend;
reg clk;

initial
begin
	clk=1'b0;
	forever #10 clk=~clk;
end


initial
begin
	/*dividend=9'b1_1011_0000;
	divisor=9'b0_0000_1101;*/
	dividend=9'b0_1011_0000;
	divisor=9'b0_0001_0101;
	#500 $stop;
end


IC_CDesign icw(sign,remainder,result,dividend,divisor,clk);
endmodule







