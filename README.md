# ClamAV AFL++ Docker Fuzzing Lab

Docker-based fuzzing environment for ClamAV using AFL++ and Clang/LLVM.

This project is for authorized university cybersecurity research in a controlled lab environment. The goal is defensive vulnerability research, reproducibility, and safe analysis.

## Contents

- Debian-based Docker image
- Clang/LLVM
- AFL++
- ClamAV source code
- Build dependencies
- Mounted corpus/output folders
- AFL++ fuzzing workflow

## Project Structure

```text
clamav-fuzz-lab/
├── Dockerfile
├── README.md
├── .gitignore
├── corpus/
├── out/
└── findings/
```
## Reproducibility Information

Host:

```bash
docker --version
```

## Container Environment
Inside the container:
```bash
afl-clang-fast --version
clang --version
git -C /opt/clamav rev-parse HEAD
git -C /opt/AFLplusplus rev-parse HEAD
```
ClamAV commit:
1d043e2fe8b703d850e7dc435f1077b6be941f43

AFL++ commit:
a918a9ab647d86824d289f36014b9ca99f077984

Clang:
Debian clang version 19.1.7

# How To Use

### Clone Repository

```bash
git clone https://github.com/shon4r4/clamav-fuzz-lab.git
cd clamav-fuzz-lab
```

### Build Docker Image
```bash
docker build -t clamav-afl .
```

### Run Container
```bash
docker run --rm -it \
  -v "$PWD/corpus:/work/corpus" \
  -v "$PWD/out:/work/out" \
  -v "$PWD/findings:/work/findings" \
  clamav-afl
```

### Build Instrumented ClamAV
Inside container:
```bash
export CC=afl-clang-fast
export CXX=afl-clang-fast++

cd /work/build-clamav

cmake /opt/clamav \
  -G Ninja \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DENABLE_TESTS=OFF

ninja
```

### Verify AFL++ Instrumentation
```bash
afl-showmap -o /dev/null -- ./clamscan/clamscan /etc/hosts
```
Expected result:
Captured XXXX tuples

### Start Fuzzing
```bash
afl-fuzz \
  -i /work/corpus \
  -o /work/out \
  -- ./clamscan/clamscan @@
```

### Stop Fuzzing
CTRL + C

AFL++ automatically saves progress.

### Resume Existing Session
```bash
afl-fuzz \
  -i - \
  -o /work/out \
  -- ./clamscan/clamscan @@
```

### Important Output Directories
out/default/queue/      interesting test cases
out/default/crashes/   crashes
out/default/hangs/     hangs
out/default/fuzzer_stats

# Ethics and Safety

This project is intended only for authorized defensive security research in a controlled university lab. Do not use unauthorized malware samples or run fuzzing outputs outside the lab environment.

