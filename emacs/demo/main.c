#include <stdio.h>

int
add(int x, int y, int z)
{
    return x + y + z;
}

int
main(void)
{
    printf("%d\n", add(1, 2, 0));

    // ...

    printf("%d\n", add(3, 4, 1));

    // ...

    printf("%d\n", add(5, 6, 2));

    // ...

    printf("%d\n", add(7, 8, 3));

    // ...

    return 0;
}
