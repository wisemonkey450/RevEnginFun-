#include "hexdump.h"

void hexdump (char *desc, void *addr, int len) {
    int i;
    unsigned char buff[17];
    unsigned char *pc = (unsigned char*)addr;

    // Output description if given.
    if (desc != NULL)
        printf ("%s:\n", desc);

    if (len == 0) {
        printf("  ZERO LENGTH\n");
        return;
    }
    if (len < 0) {
        printf("  NEGATIVE LENGTH: %i\n",len);
        return;
    }
    if(COLOR_MBR){
        printf(UL_COLOR_BOLD_GREEN);
    }
    // Process every byte in the data.
    for (i = 0; i < len; i++) {
        // Multiple of 16 means new line (with line offset).
        if(COLOR_MBR){
            if(i == 446){
                printf(UL_COLOR_WHITE);
            }
            if(i == (446+16)){
                printf(UL_COLOR_BOLD_BLUE);
            }
            if(i == (446+16+16)){
                printf(UL_COLOR_BOLD_MAGENTA);
            }
            if(i == (446+16+16+16)){
                printf(UL_COLOR_DARK_GRAY);
            }
            if(i == (446+16+16+16+16)){
                printf(UL_COLOR_BOLD_CYAN);
            }
        }
        if ((i % 16) == 0) {
            // Just don't print ASCII for the zeroth line.
            if (i != 0){
                printf ("  %s\n", buff);
            }
            // Output the offset.
            printf ("  %08x ", i);
        }
        
        // Now the hex code for the specific character.
        printf (" %02x", pc[i]);

        // And store a printable ASCII character for later.
        if ((pc[i] < 0x20) || (pc[i] > 0x7e))
            buff[i % 16] = '.';
        else
            buff[i % 16] = pc[i];
        buff[(i % 16) + 1] = '\0';
    }

    // Pad out last line if not exactly 16 characters.
    while ((i % 16) != 0) {
        printf ("   ");
        i++;
    }
    // And print the final ASCII bit.
    printf ("  %s\n"UL_COLOR_RESET, buff);
    
}
