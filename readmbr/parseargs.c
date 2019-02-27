#include "parseargs.h"
#include "hexdump.h"
#include "main.h"

void parseargs(char ** args, int num){
    int c;
       int digit_optind = 0;

       while (1) {
           int this_option_optind = optind ? optind : 1;
           int option_index = 0;
           static struct option long_options[] = {
               {"help",    no_argument,       0,  0 },
               {"all",     no_argument,       0,  0 },
               {"color",   no_argument,       0,  0 },
           };

           c = getopt_long(num, args, "hac",
                    long_options, &option_index);
           if (c == -1)
               break;
           switch (c) {
           case 0:
               printf("option %s", long_options[option_index].name);
               if (optarg)
                   printf(" with arg %s", optarg);
               printf("\n");
               break;

           case '0':
           case '1':
           case '2':
               if (digit_optind != 0 && digit_optind != this_option_optind)
                    printf("digits occur in two different argv-ele‐ments.\n");
               digit_optind = this_option_optind;
               printf("option %c\n", c);
               break;

           case 'h':
               usage();
               break;

           case 'a':
               printf("ALL\n");
               break;

           case 'c':
               printf("YOU WANT COLOR\n");
               COLOR_MBR = 1;
               break;

           case 'd':
               printf("option d with value '%s'\n", optarg);
               break;

           case '?':
               break;

           default:
               printf("?? getopt returned character code 0%o ??\n", c);
           }
       }

       if (optind < num) {
           printf("non-option ARGV-elements: ");
           while (optind < num)
               printf("%s ", args[optind++]);
           printf("\n");
       }

}
