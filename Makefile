PROTOC=protoc
SRC_DIR=.
DEST_DIR=.

.PHONY: all frame run test clean

all: frame run
clean: frame_clean run_clean

frame: ghostpacer/frame/frame1.proto
	cd ghostpacer/frame; \
	$(PROTOC) --python_out=$(DEST_DIR)/ --cpp_out=$(DEST_DIR)/ $(SRC_DIR)/frame1.proto; \
	mv $(DEST_DIR)/frame1.pb.cc $(DEST_DIR)/frame1.pb.cpp; \

docker_protobuf: Dockerfile-protobuf
	sudo docker build -f Dockerfile-protobuf -t protobuf-build .; \
	sudo docker run -v "$(shell pwd):/protocols" -it protobuf-build;

docker_pyrobuf: Dockerfile
	sudo docker build -t protocols .; \
	sudo docker run -v "$(shell pwd):/protocols" protocols;

frame_pyrobuf: ghostpacer/frame/frame1.proto
	cd ghostpacer/frame; \
	python3 -m pyrobuf frame1.proto --package=frame1_pb2 --build-dir .; \
	mv $(DEST_DIR)/lib.linux-armv7l-3.5/frame1_pb2.cpython-35m-arm-linux-gnueabihf.so $(DEST_DIR)/frame1_pb2.so; \
	rm -rf out temp.* lib.*;

run: ghostpacer/run/rundown1.proto ghostpacer/run/runup1.proto ghostpacer/run/track_start_point.proto
	cd ghostpacer/run; \
	$(PROTOC) --python_out=$(DEST_DIR)/ --swift_out=$(DEST_DIR)/ $(SRC_DIR)/rundown1.proto; \
	$(PROTOC) --python_out=$(DEST_DIR)/ --swift_out=$(DEST_DIR)/ $(SRC_DIR)/runup1.proto; \
	$(PROTOC) --python_out=$(DEST_DIR)/ --swift_out=$(DEST_DIR)/ $(SRC_DIR)/track_start_point.proto;

frame_clean:
	cd ghostpacer/frame; $(RM) *_pb2.py; $(RM) *.pb.cpp; $(RM) *.pb.h;

run_clean:
	cd ghostpacer/run; $(RM) *_pb2.py; $(RM) *.pb.swift;

