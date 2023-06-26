reg [15:0] a, b; // 16-bit regs
reg [15:0] sumA; // 16-bit reg
reg [16:0] sumB; // 17-bit reg
//ex
sumA = a + b; // expression evaluates using 16 bits
sumB = a + b; // expression evaluates using 17 bits


/*	i op j, where op is:
	+ - * / % & | ^ ^~ ~^
	max(L(i),L(j))		*/

/*	i op j, where op is:
	=== !== == != > >= < <=
	1 bit				*/

/*	i op j, where op is:
	&& ||
	1 bit				*/

/*	i op j, where op is:
	&	~& | ~| ^ ~^ ^~ !
	1 bit				*/

/*	i op j, where op is:
	>> << ** >>> <<<
	L(i)				*/



