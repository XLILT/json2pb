CC=gcc
CXX=g++
CPPFLAGS = -g -fPIC -std=c++11 -I. -I/home/maxiaolong/local/include
LDFLAGS = -Wl,-rpath=/home/maxiaolong/local/lib -L/home/maxiaolong/local/lib

.PYONY: all clean -lprotobuf -lstdc++

all: libjson2pb.so test_json

clean:
	-rm -f *.o *.so *.a libjson2pb.so.* test

test_json: test_json.o test.pb.o libjson2pb.so -lprotobuf -lstdc++
test_json.o: test.pb.h

-lprotobuf:
-lstdc++:

json2pb.o: bin2ascii.h

libjson2pb.so: json2pb.o
	$(CXX) $(LDFLAGS) -o $@ $^ -Wl,-soname=$@ -Wl,-h -Wl,$@ -shared -L. -lcurl -lprotobuf -lstdc++ -ljansson

test.pb.h test.pb.cc: test.proto
	protoc --cpp_out=$(shell pwd) test.proto
