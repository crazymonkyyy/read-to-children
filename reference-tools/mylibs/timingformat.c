#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int* read(char* where) {
    FILE *fp;
    int *out_, temp;
    int count = 0;
    fp = fopen(where, "rb");
    if (fp == NULL) {
        perror("Error opening file");
        exit(1);
    }
    while (fread(&temp, sizeof(int), 1, fp)) {
        out_ = (int*) realloc(out_, (++count) * sizeof(int));
        out_[count-1] = temp;
    }
    out_ = (int*) realloc(out_, (++count) * sizeof(int));
    out_[count-1] = INT_MAX;
    fclose(fp);
    return out_;
}

int main() {
    int *out = read("test");
    for (int i = 0; out[i] != INT_MAX; i++) {
        printf("%d\n", out[i]);
    }
    free(out);
    return 0;
}
