#include "axe/core/Engine.h"

#include <cstdio>
#include <filesystem>
#include <string>

namespace {

bool setWorkingDirectoryToExecutableFolder(const char* argv0) {
    if (!argv0 || !argv0[0]) {
        return false;
    }

    std::error_code error;
    const std::filesystem::path executablePath = std::filesystem::absolute(argv0, error);
    if (error) {
        return false;
    }

    std::filesystem::current_path(executablePath.parent_path(), error);
    return !error;
}

} // namespace

int main(int argc, char** argv) {
    setWorkingDirectoryToExecutableFolder(argv ? argv[0] : nullptr);

    std::string scenePath = "scenes/level_01/level_01.json";

    for (int i = 1; i < argc; ++i) {
        const std::string arg = argv[i];
        if (arg == "--scene" && i + 1 < argc) {
            scenePath = argv[++i];
        }
    }

    std::printf("__GAME_DISPLAY_NAME__\n");
    std::printf("====================\n\n");

    axe::Engine engine;
    if (!engine.init("Autoplayer One - __GAME_DISPLAY_NAME__", 1280, 720, false)) {
        std::fprintf(stderr, "Failed to initialize engine\n");
        return 1;
    }

    engine.getRenderer()->setClearColor(112, 181, 255, 255);

    if (!engine.loadScene(scenePath.c_str())) {
        std::fprintf(stderr, "Failed to load scene: %s\n", scenePath.c_str());
        engine.shutdown();
        return 1;
    }

    engine.run();
    engine.shutdown();
    return 0;
}
