FROM ghdl/ghdl:ubuntu20-llvm-10

WORKDIR /build
COPY scheme scheme

WORKDIR /build/scheme/src
RUN mkdir work

RUN ghdl -i --workdir=work --ieee=synopsys --std=08 *.vhd
RUN ghdl -m --workdir=work --ieee=synopsys --std=08 cordic_tb
RUN ghdl -r --workdir=work --ieee=synopsys --std=08 cordic_tb --assert-level=note
