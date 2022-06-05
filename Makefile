# OS specific differences
UNAME = ${shell uname}
ifeq ($(UNAME), Darwin)
SWIFTC_FLAGS =
LINKER_FLAGS = -Xlinker -L/usr/local/lib
LLVM_COV = xcrun llvm-cov
LLVM_COV = xcrun llvm-cov
LLVM_COV_FILES = .build/debug/sec-tester-swiftPackageTests.xctest/Contents/MacOS/sec-tester-swiftPackageTests
endif
ifeq ($(UNAME), Linux)
SWIFTC_FLAGS = -Xcc -fblocks
LINKER_FLAGS = -Xlinker -rpath -Xlinker .build/debug
LLVM_COV = llvm-cov
LLVM_COV_FILES = .build/debug/sec-tester-swiftPackageTests.xctest
endif

gen-mock:
	set -eu
	cd "$(dirname "$0")"
	swift package describe --type json > project.json
	.build/checkouts/mockingbird/mockingbird generate \
		--project project.json \
		--output-dir Tests/SecTesterTests/Mocks \
		--testbundle SecTesterTests \
		--targets SecTester

lint:
	swiftlint --config .swiftlint.yml

format:
	swift run -c release swiftformat . --lint

build:
	swift build $(SWIFTC_FLAGS) $(LINKER_FLAGS)

test: gen-mock build
	swift test

coverage: gen-mock build
	swift test --enable-code-coverage
	$(LLVM_COV) export \
		-format="lcov" \
		-instr-profile=.build/debug/codecov/default.profdata \
		-ignore-filename-regex=".build|Tests" \
		 $(LLVM_COV_FILES) > coverage.lcov

clean:
	rm -rf .mockingbird coverage.lcov project.json
	swift package reset

distclean:
	swift package clean

.PHONY: build test distclean lint
