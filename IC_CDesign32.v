/**********************************

Project Name: IC_CDesign
NameP: 4/8/16/32位加减交替定点原码除法器
Project For: IC_CurriculumDesign
Project Version: v1.01.1810053201
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
						output reg [32:0]remainder,	//32是最高位
						output reg [32:0]result,
						input [32:0]dividend,
						input [32:0]divisor,
						input clk);

wire [33:0]dividendtmp;
wire [33:0]divisortmp[32:0];
wire [33:0]remaindertmp[33:0];
wire [33:0]remaindershitmp[31:0];
wire [32:0]resulttmp[33:0];
assign resulttmp[0]=33'b0_0000_0000_0000_0000;
wire resone[33:0];
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
shift shiA17(remaindershitmp[16],resulttmp[17],remaindertmp[16],resulttmp[16],resone[17],clk);

chose choB18(divisortmp[17],divisor,resone[17],clk);
adder addA18(remaindertmp[17],resone[18],remaindershitmp[16],divisortmp[17],clk);
shift shiA18(remaindershitmp[17],resulttmp[18],remaindertmp[17],resulttmp[17],resone[18],clk);

chose choB19(divisortmp[18],divisor,resone[18],clk);
adder addA19(remaindertmp[18],resone[19],remaindershitmp[17],divisortmp[18],clk);
shift shiA19(remaindershitmp[18],resulttmp[19],remaindertmp[18],resulttmp[18],resone[19],clk);

chose choB20(divisortmp[19],divisor,resone[19],clk);
adder addA20(remaindertmp[19],resone[20],remaindershitmp[18],divisortmp[19],clk);
shift shiA20(remaindershitmp[19],resulttmp[20],remaindertmp[19],resulttmp[19],resone[20],clk);

chose choB21(divisortmp[20],divisor,resone[20],clk);
adder addA21(remaindertmp[20],resone[21],remaindershitmp[19],divisortmp[20],clk);
shift shiA21(remaindershitmp[20],resulttmp[21],remaindertmp[20],resulttmp[20],resone[21],clk);

chose choB22(divisortmp[21],divisor,resone[21],clk);
adder addA22(remaindertmp[21],resone[22],remaindershitmp[20],divisortmp[21],clk);
shift shiA22(remaindershitmp[21],resulttmp[22],remaindertmp[21],resulttmp[21],resone[22],clk);

chose choB23(divisortmp[22],divisor,resone[22],clk);
adder addA23(remaindertmp[22],resone[23],remaindershitmp[21],divisortmp[22],clk);
shift shiA23(remaindershitmp[22],resulttmp[23],remaindertmp[22],resulttmp[22],resone[23],clk);

chose choB24(divisortmp[23],divisor,resone[23],clk);
adder addA24(remaindertmp[23],resone[24],remaindershitmp[22],divisortmp[23],clk);
shift shiA24(remaindershitmp[23],resulttmp[24],remaindertmp[23],resulttmp[23],resone[24],clk);

chose choB25(divisortmp[24],divisor,resone[24],clk);
adder addA25(remaindertmp[24],resone[25],remaindershitmp[23],divisortmp[24],clk);
shift shiA25(remaindershitmp[24],resulttmp[25],remaindertmp[24],resulttmp[24],resone[25],clk);

chose choB26(divisortmp[25],divisor,resone[25],clk);
adder addA26(remaindertmp[25],resone[26],remaindershitmp[24],divisortmp[25],clk);
shift shiA26(remaindershitmp[25],resulttmp[26],remaindertmp[25],resulttmp[25],resone[26],clk);

chose choB27(divisortmp[26],divisor,resone[26],clk);
adder addA27(remaindertmp[26],resone[27],remaindershitmp[25],divisortmp[26],clk);
shift shiA27(remaindershitmp[26],resulttmp[27],remaindertmp[26],resulttmp[26],resone[27],clk);

chose choB28(divisortmp[27],divisor,resone[27],clk);
adder addA28(remaindertmp[27],resone[28],remaindershitmp[26],divisortmp[27],clk);
shift shiA28(remaindershitmp[27],resulttmp[28],remaindertmp[27],resulttmp[27],resone[28],clk);

chose choB29(divisortmp[28],divisor,resone[28],clk);
adder addA29(remaindertmp[28],resone[29],remaindershitmp[27],divisortmp[28],clk);
shift shiA29(remaindershitmp[28],resulttmp[29],remaindertmp[28],resulttmp[28],resone[29],clk);

chose choB30(divisortmp[29],divisor,resone[29],clk);
adder addA30(remaindertmp[29],resone[30],remaindershitmp[28],divisortmp[29],clk);
shift shiA30(remaindershitmp[29],resulttmp[30],remaindertmp[29],resulttmp[29],resone[30],clk);

chose choB31(divisortmp[30],divisor,resone[30],clk);
adder addA31(remaindertmp[30],resone[31],remaindershitmp[29],divisortmp[30],clk);
shift shiA31(remaindershitmp[30],resulttmp[31],remaindertmp[30],resulttmp[30],resone[31],clk);

chose choB32(divisortmp[31],divisor,resone[31],clk);
adder addA32(remaindertmp[31],resone[32],remaindershitmp[30],divisortmp[31],clk);
shift shiA32(remaindershitmp[31],resulttmp[32],remaindertmp[31],resulttmp[31],resone[32],clk);


chose choB33(divisortmp[32],divisor,resone[32],clk);
adder addA33(remaindertmp[32],resone[33],remaindershitmp[31],divisortmp[32],clk);
assign resulttmp[33]=resulttmp[32]+resone[33];
remrec rr(remaindertmp[33],remaindertmp[32],divisortmp[32],resone[33],clk);

always @(posedge clk)
begin
	result=resulttmp[33];
	if(resone[33])			//如果最后一位商为1，则不恢复余数，否则恢复余数
		remainder=remaindertmp[32];
	else if(!resone[33])
		remainder=remaindertmp[33];
end
endmodule


/*输入寄存器（32+1位输入，32+2位输出）
*/
module ireg(output reg [1:0]sign,
				output reg [33:0]iregout,
				input [32:0]iregin,
				input clk);

always @(posedge clk)
begin
	iregout[32:0]<=iregin;
	iregout[33]<=iregin[32];
	sign[0]<=iregin[32];
	sign[1]<=iregin[32];
end
endmodule					


/*商寄存器（32+1位输入，32+1位输出）
（输出商只需要1位符号位，即一共33位）
*/
module oreg(output reg [32:0]oregout,
				input [32:0]oregin,
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
module adder(output reg [33:0]addout,
				output reg resone,
				input [33:0]adda,
				input [33:0]addb,
				input clk);

always @(posedge clk)
begin
	addout=adda+addb;
	resone=~addout[33];
end
endmodule


/*相反数求补器
//只有0000的补码会溢出，所以不用考虑溢出问题
*/
module complement(output reg [32:0]comout,
						input [32:0]comin,
						input clk);

reg [31:0]comtmp;

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
	comtmp[16]=~comin[16];
	comtmp[17]=~comin[17];
	comtmp[18]=~comin[18];
	comtmp[19]=~comin[19];
	comtmp[20]=~comin[20];
	comtmp[21]=~comin[21];
	comtmp[22]=~comin[22];
	comtmp[23]=~comin[23];
	comtmp[24]=~comin[24];
	comtmp[25]=~comin[25];
	comtmp[26]=~comin[26];
	comtmp[27]=~comin[27];
	comtmp[28]=~comin[28];
	comtmp[29]=~comin[29];
	comtmp[30]=~comin[9];
	comtmp[31]=~comin[9];
	comtmp=comtmp+32'b0000_0000_0000_0000_0000_0000_0000_0001;
	comout=comtmp;
	comout[32]=~comin[32];
end
endmodule


/*移位器
*/
module shift(output reg [33:0]remout,
				output reg [32:0]resout,
				input [33:0]remin,
				input [32:0]resin,
				input resone,
				input clk);
				
reg [66:0]shitmp;	//67=33+34=(32+1)+(32+2)

always @(posedge clk)
begin
	shitmp[0]=resone;
	shitmp[32:1]=resin[32:1];
	shitmp[66:33]=remin[33:0];
	shitmp=shitmp<<1;
	resout=shitmp[32:0];
	remout[33:0]=shitmp[66:33];
end
endmodule


/*选择器
*/
module chose(output reg [33:0]choout,
				input [32:0]choin,
				input resreg,
				input clk);

reg [31:0]chotmp;

always @(posedge clk)
begin
	if(!resreg)
	begin
		choout[32:0]=choin;
		choout[33]=choin[32];
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
		chotmp[16]=~choin[16];
		chotmp[17]=~choin[17];
		chotmp[18]=~choin[18];
		chotmp[19]=~choin[19];
		chotmp[20]=~choin[20];
		chotmp[21]=~choin[21];
		chotmp[22]=~choin[22];
		chotmp[23]=~choin[23];
		chotmp[24]=~choin[24];
		chotmp[25]=~choin[25];
		chotmp[26]=~choin[26];
		chotmp[27]=~choin[27];
		chotmp[28]=~choin[28];
		chotmp[29]=~choin[29];
		chotmp[30]=~choin[30];
		chotmp[31]=~choin[31];
		chotmp=chotmp+32'b0000_0000_0000_0000_0000_0000_0000_0001;
		choout[31:0]=chotmp;
		choout[32]=~choin[32];
		choout[33]=~choin[32];
	end
end
endmodule


/*余数恢复器
*/
module remrec(output reg [33:0]rrout,
				input [33:0]rrina,
				input [33:0]rrinb,
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
wire [32:0]remainder;
wire [32:0]result;
reg [32:0]divisor;
reg [32:0]dividend;
reg clk;

initial
begin
	clk=1'b0;
	forever #10 clk=~clk;
end


initial
begin
	dividend=33'b0_1010_0000_1010_0000_1010_0000_1010_0000;
	divisor=33'b0_0001_1010_0001_1010_0001_1010_0001_1010;
	#2000 $stop;
end


IC_CDesign icw(sign,remainder,result,dividend,divisor,clk);
endmodule







