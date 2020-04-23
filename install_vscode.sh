# install vscode
# wget https://az764295.vo.msecnd.net/stable/0dd516dd412d42323fc3464531b1c715d51c4c1a/code_1.33.0-1554390824_amd64.deb
apt update
dpkg -i code_1.41.1-1576681836_amd64.deb
apt-get install -f
dpkg -i code_1.41.1-1576681836_amd64.deb
apt install gdb
mkdir /work/vscode
apt install libasound2
echo "{
   "configurations": [
       {
           "name": "Linux",
           "includePath": [
               "/usr/lib/gcc/x86_64-linux-gnu/7.3.0",
               "/usr/include",
               "/usr/local/include",
               "${workspaceRoot}",
               "/root/.cache/bazel/_bazel_root/1e0bb3bee2d09d2e4ad3523530d3b40c/execroot/__main__/bazel-out/k8-fastbuild/genfiles",
               "/root/.cache/bazel/_bazel_root/1e0bb3bee2d09d2e4ad3523530d3b40c/external/com_google_protobuf/src",
               "/root/.cache/bazel/_bazel_root/1e0bb3bee2d09d2e4ad3523530d3b40c/external/eigen"
           ],
           "defines": [
               "_GNU_SOURCE"
           ],
           "intelliSenseMode": "clang-x64",
           "browse": {
               "path": [
                   "/usr/lib/gcc/x86_64-linux-gnu/7.3.0",
                   "/usr/include",
                   "/usr/local/include",
                   "${workspaceRoot}"
               ],
               "limitSymbolsToIncludedHeaders": true,
               "databaseFilename": ""
           },
           "compilerPath": "/usr/bin/gcc",
           "cStandard": "c11",
           "cppStandard": "c++14"
       }
   ],
   "version": 4
}
" > /work/vscode/c_cpp_properties.json
echo "{
   // Use IntelliSense to learn about possible attributes.
   // Hover to view descriptions of existing attributes.
   // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
   \"version\": \"0.2.0\",
   \"configurations\": [
       {
           \"name\": \"(gdb) Launch\",
           \"type\": \"cppdbg\",
           \"request\": \"launch\",
           \"program\": \"/work/bazel-bin/infrastructure/example/example_main\",
           \"args\": [],
           \"stopAtEntry\": false,
           \"cwd\": \"/work\",
           \"environment\": [],
           \"externalConsole\": false,
           \"MIMode\": \"gdb\",
           \"miDebuggerPath\": \"/usr/bin/gdb\",
           \"setupCommands\": [
               {
                   \"description\": \"Enable pretty-printing for gdb\",
                   \"text\": \"-enable-pretty-printing\",
                   \"ignoreFailures\": true
               }
           ]
       }
   ]
}
" > /work/vscode/launch.json
code . --user-data-dir='/work/vscode/'
# bazel build ... --compilation_mode=dbg -s
