CMAKE := $(shell command -v cmake)
# Build type (can override via `make build BUILD_TYPE=Debug`)
BUILD_TYPE ?= Release

.PHONY: build
build:
	$(CMAKE) -Bbuild -DCMAKE_BUILD_TYPE=$(BUILD_TYPE)
	$(CMAKE) --build build -- -j

run:
	cd build && ./wasm_yaml

build/wasm:	clean
	emcmake $(CMAKE) -Bbuild -DCMAKE_BUILD_TYPE=$(BUILD_TYPE)
	$(CMAKE) --build build

run/wasm:
	python -m http.server --directory build

clean:
	rm -rf build CMakeFiles