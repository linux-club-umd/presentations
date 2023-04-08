#include <stdio.h>

int
add(int x, int y)
{
    return x + y;
}

int
main(void)
{
    printf("%d\n", add(1, 2));

    // ...

    printf("%d\n", add(3, 4));

    // ...

    printf("%ld\n", add(5, 6));

    // ...

    printf("%d\n", add(7, 8));

    // ...

    printf("We\n");
    printf("Are\n");
    printf("Done\n");

    return 0;
}
