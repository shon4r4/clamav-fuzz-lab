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
