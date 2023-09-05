// Copyright 2023 Wojciech Sek

#ifndef CPP_UTILS_HPP_
#define CPP_UTILS_HPP_
#endif  // CPP_UTILS_HPP_

#include <string>
#include <vector>

std::string file_to_string(const std::string &filepath);

const char WHITESPACE[] = " \n\r\t\f\v";

std::string ltrim(const std::string &s);

std::string rtrim(const std::string &s);

std::string trim(const std::string &s);

std::vector<std::string> file_to_vec(const std::string &filepath);
std::vector<std::vector<int>> file_to_int_vec2(
        const std::string &filepath,
        char sep);
