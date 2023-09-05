// Copyright 2023 Wojciech Sek

#include <fstream>
#include <iostream>
#include <sstream>
#include <string>

#include "utils.hpp"

std::string file_to_string(const std::string &filepath) {
    std::ifstream inFile;
    inFile.open(filepath);

    std::stringstream strStream;
    strStream << inFile.rdbuf();

    return strStream.str();
}
