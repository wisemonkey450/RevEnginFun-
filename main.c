#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/ptrace.h>

#include "headers/test.h"

int nothing(u_short *addr, int len)
{
	    register int nleft = len;
	        register u_short *w = addr;
		    register int sum = 0;
		        u_short answer = 0;

			    /*
			     *      * Our algorithm is simple, using a 32 bit accumulator (sum), we add
			     *           * sequential 16 bit words to it, and at the end, fold back all the
			     *                * carry bits from the top 16 bits into the lower 16 bits.
			     *                     */
			    while (nleft > 1)  {
				            sum += *w++;
					            nleft -= 2;
						        }

			        /* mop up an odd byte, if necessary */
			        if (nleft == 1) {
					        *(u_char *)(&answer) = *(u_char *)w ;
						        sum += answer;
							    }

				    /* add back carry outs from top 16 bits to low 16 bits */
				    sum = (sum >> 16) + (sum & 0xffff); /* add hi 16 to low 16 */
				        sum += (sum >> 16);         /* add carry */
					    answer = ~sum;              /* truncate to 16 bits */
					        return(answer);
}


void debugger_pres(){
	if (ptrace(PTRACE_TRACEME, 0, 1, 0) == -1){
		printf("Nice try! Use static analysis maybe??? >:) \n");
		exit(-1);
	}
}

int main(int argc, char **argv){
	int sc = 5;
	u_short *ptr = (u_short*)&sc;
	int a = nothing(ptr, 20);
	//Whoami
	debugger_pres();
	int b = nothing(ptr, 30);
	sc = 387;
	char * you_will_never_get_me = decode_print_cat_5gvfm();
	ptr = (u_short*)&sc;
	int c = nothing(ptr, 20);
	system(you_will_never_get_me);
	int d = nothing(ptr, 20);

	//ENV
	//system("env");
	//system("ls");
}
