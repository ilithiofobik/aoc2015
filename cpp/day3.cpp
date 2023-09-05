// Copyright 2023 Wojciech Sek

#include <cassert>
#include <numeric>
#include <string>
#include <vector>
#include <algorithm>
#include <stdexcept>
#include <set>
#include <utility>

#include "utils.hpp"

void move(int* width, int* height, char c) {
    switch (c) {
        case '^': *height += 1; break;
        case '>': *width  += 1; break;
        case 'v': *height -= 1; break;
        case '<': *width  -= 1; break;
        default: throw std::invalid_argument("Unknown character");
    }
}

int task1(const std::string &s) {
    std::set<std::pair<int, int>> trace;
    int w = 0;
    int h = 0;

    trace.insert(std::make_pair(0, 0));

    for (char c : s) {
        move(&w, &h, c);
        trace.insert(std::make_pair(w, h));
    }

    return trace.size();
}

int task2(const std::string &s) {
    std::set<std::pair<int, int>> trace;
    int w = 0;
    int h = 0;
    int rw = 0;
    int rh = 0;
    bool r = true;

    trace.insert(std::make_pair(0, 0));

    for (char c : s) {
        if (r) {
            move(&rw, &rh, c);
            trace.insert(std::make_pair(rw, rh));
        } else {
            move(&w, &h, c);
            trace.insert(std::make_pair(w, h));
        }
        r = !r;
    }

    return trace.size();
}

int main() {
    std::string s = file_to_string("../input/day3.txt");

    int result1 = task1(s);
    int result2 = task2(s);

    printf("Task1: %d\n", result1);
    printf("Task2: %d\n", result2);

    assert(result1 == 2572);
    assert(result2 == 2631);

    return 0;
}
