// Copyright 2023 Wojciech Sek

#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

#include "utils.hpp"

std::string ltrim(const std::string &s) {
    size_t start = s.find_first_not_of(WHITESPACE);
    return (start == std::string::npos) ? "" : s.substr(start);
}

std::string rtrim(const std::string &s) {
    size_t end = s.find_last_not_of(WHITESPACE);
    return (end == std::string::npos) ? "" : s.substr(0, end + 1);
}

std::string trim(const std::string &s) {
    return rtrim(ltrim(s));
}

std::string file_to_string(const std::string &filepath) {
    std::ifstream inFile;
    inFile.open(filepath);

    std::stringstream strStream;
    strStream << inFile.rdbuf();

    return trim(strStream.str());
}

std::vector<std::string> file_to_str_vec(const std::string &filepath) {
    std::ifstream file(filepath);
    std::vector<std::string> vector;
    std::string line;
    while (std::getline(file, line)) {
        std::string row = trim(line);
        if (!row.empty()) {
            vector.push_back(trim(line));
        }
    }
    file.close();
    return vector;
}

/// @brief Reads a file, returns its content as vector of int vectors.
/// @param filepath path to the file
/// @param sep seperator between ints in each line
/// @return Vector of int vectors.
std::vector<std::vector<int>> file_to_int_vec2(
    const std::string &filepath,
    char sep
    ) {
    std::vector<std::string> str_vector = file_to_str_vec(filepath);
    std::vector<std::vector<int>> int_vectors;

    for (std::string s : str_vector) {
        std::vector<int> int_vector;
        std::stringstream ss(s);
        std::string word;

        while (!ss.eof()) {
            getline(ss, word, sep);
            int num = std::stoi(word);
            int_vector.push_back(num);
        }

        int_vectors.push_back(int_vector);
    }

    return int_vectors;
}
