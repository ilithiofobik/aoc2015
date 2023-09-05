// Copyright 2023 Wojciech Sek

#include <cassert>
#include <numeric>
#include <string>
#include <vector>
#include <algorithm>

#include "utils.hpp"

int task1(const std::vector<std::vector<int>> &int_vectors) {
    int counter = 0;
    for (std::vector<int> int_vector : int_vectors) {
        int x = int_vector[0];
        int y = int_vector[1];
        int z = int_vector[2];
        int w = x * y;
        int h = y * z;
        int l = z * x;
        int small_area = std::min(w, std::min(h, l));

        counter +=  2 * (w + h + l) + small_area;
    }
    return counter;
}

int task2(const std::vector<std::vector<int>> &int_vectors) {
    int counter = 0;
    for (std::vector<int> int_vector : int_vectors) {
        int x = int_vector[0];
        int y = int_vector[1];
        int z = int_vector[2];
        int max = std::max(x, std::max(y, z));

        counter +=  2 * (x + y + z - max) + x * y * z;
    }
    return counter;
}

int main() {
    std::vector<std::vector<int>> input =
        file_to_int_vec2("../input/day2.txt", 'x');

    int result1 = task1(input);
    int result2 = task2(input);

    printf("Task1: %d\n", result1);
    printf("Task2: %d\n", result2);

    assert(result1 == 1586300);
    assert(result2 == 3737498);

    return 0;
}
