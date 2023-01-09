SOM_BENCHMARKS = som_benchmarks

ALLOY="https://github.com/softdevteam/rustgc"
ALLOY_DIR=`pwd`/build/alloy
YKSOM="https://github.com/softdevteam/yksom"
YKSOM_DIR=`pwd`/build/yksom
SOMPP="https://github.com/smarr/SOMpp"
SOMPP_DIR=`pwd`/build/sompp


all: build_som

clean:
	rm -rf ${SOM_BENCHMARKS}

build_alloy:
	set -e; \
		mkdir -p ${ALLOY_DIR}; \
		git clone ${ALLOY} ${ALLOY_DIR}; \
		cd ${ALLOY_DIR}; \
		python3 x.py build --stage 2 --config benchmark.config.toml; \
		rustup toolchain link alloy_bench ${ALLOY_DIR}/build/x86_x64-unknown-linux-gnu/stage2; \

build_yksom: build_alloy
	set -e; \
		git clone ${YKSOM} ${YKSOM_DIR}; \
		cd ${YKSOM_DIR}; \
		cargo build +alloy_bench --release

build_sompp:
	set -e; \
		git clone ${SOMPP} ${SOMPP_DIR}; \
		cd ${SOMPP_DIR}; \
		make;

benchmark: build_yksom build_sompp
	set -e; \
		cd ${SOM_BENCHMARKS}; \
		tmpfile=$(mktemp benchmark); \
		rebench -S -N --experiment all rebench.conf all > tmpfile; \
		python process.py tmpfile
		rm tmpfile;



