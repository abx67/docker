FROM 460427586040.dkr.ecr.us-west-2.amazonaws.com/autonomy/base_ubuntu:latest

COPY bazel-bin /work/bazel-bin/
COPY go /work/go/
COPY data /work/data/
COPY HDMapData /work/HDMapData/


WORKDIR /work
ENTRYPOINT ["bash"]