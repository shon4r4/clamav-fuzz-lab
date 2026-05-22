# ClamAV AFL++ Fuzzing Report – Run 001

## Project Information

- Project: Dockerized ClamAV AFL++ Fuzzing Environment
- Purpose: Defensive cybersecurity research and reproducible fuzz testing
- Environment: Controlled university lab
- Target: ClamAV (`clamscan`)
- Fuzzer: AFL++
- Instrumentation: LLVM (`afl-clang-fast`)
- Containerization: Docker

---

# Objective

The objective of this fuzzing run was to:

1. Validate the Docker-based AFL++ fuzzing environment
2. Confirm AFL++ instrumentation works correctly
3. Verify that ClamAV can be fuzzed inside a reproducible containerized setup
4. Establish a baseline fuzzing workflow for future vulnerability research

---

# Environment Information

## Host System

```text
Docker version 28.5.2+dfsg4
```

Recommended host operating systems:

- Kali Linux Rolling
- Debian 12+
- Ubuntu 22.04+

---

## Container Environment

### AFL++

```text
AFL++ 4.41a
```

### Clang

```text
Debian clang version 19.1.7
```

### ClamAV Commit

```text
1d043e2fe8b703d850e7dc435f1077b6be941f43
```

### AFL++ Commit

```text
a918a9ab647d86824d289f36014b9ca99f077984
```

---

# Build Configuration

ClamAV was compiled using AFL++ LLVM instrumentation:

```bash
export CC=afl-clang-fast
export CXX=afl-clang-fast++
```

Build system:

```text
CMake + Ninja
```

Build type:

```text
RelWithDebInfo
```

---

# Fuzzing Target

The fuzzing target used during this run was:

```text
./clamscan/clamscan @@
```

The AFL++ placeholder `@@` represents mutated input files generated during fuzzing.

---

# Initial Corpus

The initial corpus contained four small seed files:

```text
hosts
services
sample.txt
```

These files were intentionally simple and primarily used to validate the fuzzing pipeline.

---

# AFL++ Runtime Statistics

## Runtime Information

```text
Runtime: 1 hour 4 minutes 46 seconds
Total executions: 814k
Execution speed: ~756 exec/sec
Cycles completed: 1357
Corpus count: 4
```

---

## Coverage Information

```text
Map density: 0.61%
Count coverage: 1.25 bits/tuple
New edges discovered: 2
```

---

## Stability Information

```text
Stability: 99.35%
```

This indicates that the target behaved consistently during fuzzing and that instrumentation was functioning correctly.

---

# Crash Analysis

## Crashes

```text
Saved crashes: 0
Total crashes: 0
```

No crashes were detected during this fuzzing session.

---

## Hangs

```text
Saved hangs: 0
```

No persistent hangs were identified.

---

## Timeouts

```text
Total timeouts: 7549
Saved timeouts: 0
```

Timeouts occurred during fuzzing but were not considered stable or reproducible by AFL++.

---

# Interpretation

The fuzzing environment functioned successfully:

- AFL++ instrumentation was active
- ClamAV executed correctly under AFL++
- Coverage feedback was collected
- Mutation and queue management operated correctly
- Session state was saved successfully

The fuzzing session reached a `finished` state because AFL++ exhausted useful mutations for the very small seed corpus.

The low map density and low number of discovered edges indicate limited code coverage.

This result is expected because:

- the corpus was extremely small
- the seed files were generic
- the target (`clamscan`) is large and complex
- no format-specific dictionary was used

The original output "/out/default" directory is also available for processing
---

# Vulnerability Assessment

## Result

No confirmed vulnerability was identified during this initial fuzzing session.

This result does **not** imply that ClamAV is free of vulnerabilities.

It only indicates that:

- this short-duration fuzzing run
- using a limited corpus
- against the full `clamscan` target

did not produce crashing or hanging inputs.

---

# Limitations

The following limitations affected fuzzing depth and coverage:

- Small initial corpus
- Generic seed files
- Limited fuzzing duration
- Large monolithic target (`clamscan`)
- No AddressSanitizer (ASAN)
- No UndefinedBehaviorSanitizer (UBSAN)
- No format-aware fuzzing dictionary
- No dedicated parser harnesses

---

# Recommendations for Future Work

Future fuzzing sessions should include:

## Improved Corpus

Use realistic ClamAV-related samples:

- PDFs
- ZIP archives
- PE executables
- HTML files
- Office documents
- Email samples
- Malformed files

---

## Sanitizer Builds

Enable:

```bash
export AFL_USE_ASAN=1
```

and optionally:

```bash
export AFL_USE_UBSAN=1
```

---

## Dedicated Fuzz Harnesses

Instead of fuzzing the entire `clamscan` application, future work should target:

- PDF parser
- PE parser
- Archive handlers
- Mail parsers
- HTML parser

This improves:

- execution speed
- code coverage
- crash quality
- reproducibility

---

# Reproducibility

The project successfully demonstrated:

- reproducible Docker-based fuzzing
- portable AFL++ instrumentation
- persistent mounted fuzzing outputs
- reproducible build environment
- version-controlled setup

The environment can now be cloned and executed consistently by all project team members.

---

# Conclusion

This initial AFL++ fuzzing campaign successfully validated the Dockerized ClamAV fuzzing infrastructure.

Although no vulnerability was identified during this run, the environment proved stable, reproducible, and suitable for future defensive vulnerability research and parser-focused fuzzing campaigns.

The next research stage should focus on:

- richer corpora
- parser-specific harnesses
- sanitizer-assisted fuzzing
- longer fuzzing campaigns
- crash triage workflows
