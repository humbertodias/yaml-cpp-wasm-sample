#include <yaml-cpp/yaml.h>
#include <iostream>

void read_yaml() {
    try {
        YAML::Node config = YAML::LoadFile("config.yaml");
        std::cout << "name: " << config["name"].as<std::string>() << std::endl;
        std::cout << "version: " << config["version"].as<float>() << std::endl;

        std::cout << "features:" << std::endl;
        for (const auto& feature : config["features"]) {
            std::cout << "- " << feature.as<std::string>() << std::endl;
        }
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
    }
}

int main() {
    read_yaml();
    return 0;
}