// Copyright 2023 Wojciech Sek

#include <cassert>
#include "utils.hpp"

int to_num(char c) {
    switch (c) {
        case '(': return 1;
        case ')': return -1;
        default: return 0;
    }
}

int task1(const std::string &s) {
    int counter = 0;

    for (char c : s) {
        counter += to_num(c);
    }

    return counter;
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

    assert(task1(s) == 138);
    assert(task2(s) == 1771);

    return 0;
}
