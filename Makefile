PROTOC=protoc
SRC_DIR=.
DEST_DIR=.

.PHONY: all frame run test clean

all: frame run
clean: frame_clean run_clean

frame: ghostpacer/frame/frame1.proto
	cd ghostpacer/frame; $(PROTOC) --python_out=$(DEST_DIR)/ --cpp_out=$(DEST_DIR)/ $(SRC_DIR)/frame1.proto

run: ghostpacer/run/rundown1.proto ghostpacer/run/runup1.proto ghostpacer/run/track_start_point.proto
	cd ghostpacer/run; \
	$(PROTOC) --python_out=$(DEST_DIR)/ --swift_out=$(DEST_DIR)/ $(SRC_DIR)/rundown1.proto; \
	$(PROTOC) --python_out=$(DEST_DIR)/ --swift_out=$(DEST_DIR)/ $(SRC_DIR)/runup1.proto; \
	$(PROTOC) --python_out=$(DEST_DIR)/ --swift_out=$(DEST_DIR)/ $(SRC_DIR)/track_start_point.proto;

frame_clean:
	cd ghostpacer/frame; $(RM) *_pb2.py; $(RM) *.pb.cc; $(RM) *.pb.h;

run_clean:
	cd ghostpacer/run; $(RM) *_pb2.py; $(RM) *.pb.swift;

