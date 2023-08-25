from conan import ConanFile
from conan.tools.cmake import CMake, cmake_layout


class helloRecipe(ConanFile):
    name = "my_lib"
    version = "1.0"

    # Optional metadata
    license = "<Put the package license here>"
    author = "<Put your name here> <And your email here>"
    url = "<Package recipe repository url here, for issues about the package>"
    description = "<Description of hello package here>"
    topics = ("<Put some tag here>", "<here>", "<and here>")

    # Binary configuration
    settings = "os", "compiler", "build_type", "arch"
    options = {"fPIC": [True, False]}
    default_options = {
        "fPIC": True,
        "cpp-httplib/*:with_openssl": True,
    }

    # Sources are located in the same place as this recipe, copy them to the recipe
    exports_sources = "CMakeLists.txt", "src/*", "include/*"

    generators = ["CMakeDeps", "CMakeToolchain"]

    def requirements(self):
        self.requires("cpp-httplib/0.12.2", transitive_headers=True)

    def layout(self):
        cmake_layout(self)

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def package(self):
        cmake = CMake(self)
        cmake.install()

    def package_info(self):
        self.cpp_info.libs = ["my_lib"]
