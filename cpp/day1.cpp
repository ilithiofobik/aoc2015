// Copyright 2023 Wojciech Sek

#include <cassert>
#include <numeric>
#include <string>
#include <vector>
#include <algorithm>
#include <stdexcept>

#include "utils.hpp"

int to_num(char c) {
    switch (c) {
        case '(': return 1;
        case ')': return -1;
        default:
            throw std::invalid_argument("Input must consist of '(' and ')'");
    }
}

int task1(const std::string &s) {
    std::vector<char> iter(s.begin(), s.end());
    std::transform(iter.begin(), iter.end(), iter.begin(), to_num);
    return std::accumulate(iter.begin(), iter.end(), 0);
}

int task2(const std::string &s) {
    int counter = 0;
    int length = s.length();

    for (int i = 0; i < length; i++) {
        switch (counter) {
            case -1: return i;
            default: counter += to_num(s[i]);
        }
    }

    return length;
}

int main() {
    std::string s = file_to_string("../input/day1.txt");

    int result1 = task1(s);
    int result2 = task2(s);

    printf("Task1: %d\n", result1);
    printf("Task2: %d\n", result2);

    assert(result1 == 138);
    assert(result2 == 1771);

    return 0;
}
