#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <dispatch/dispatch.h>


int main(int argc, char **argv) {
	printf(">>> Starting test\n");

	dispatch_queue_t main = dispatch_get_main_queue();

	/*
	 * Dispatch 3 seconds from now. This will be queued serially after the
	 * block below this which sleeps the entire thread, GCD main queue included
	 */
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (3 * NSEC_PER_SEC)), main, ^{ printf("dispatch_after\n"); });

	dispatch_async(main, ^{
			printf("burp\n");
			sleep(5);
			printf("ahem\n");
			});

	dispatch_async(main, ^{
			printf("second block\n");
			});

	dispatch_main();


	printf("#### DONE ####\n\n");

	return 0;
}
