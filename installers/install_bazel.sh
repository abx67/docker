#!/usr/bin/env bash
set - e
cd "$(dirname "${BASH_SOURCE[0]}")"
wget -nc https://github.com/bazelbuild/bazel/releases/download/0.28.1/bazel-0.28.1-installer-linux-x86_64.sh || true
bash bazel-0.28.1-installer-linux-x86_64.sh

echo "source /usr/local/lib/bazel/bin/bazel-complete.bash" >> ~/.bashrc

# Clean up.
apt-get clean && rm -rf /var/lib/apt/lists/*
rm -fr bazel-0.28.1-installer-linux-x86_64.sh /etc/apt/sources.list.d/bazel.list
