# Turnip

Turnip is a lightweight command-line submission and autotesting toolkit.

It models the core workflow of a small programming course platform: create an
assignment, accept versioned submissions, run public tests, fetch submitted
files, summarize activity, and mark the latest submissions against hidden tests.

## Commands

```txt
turnip-add      create an assignment from a tar test bundle
turnip-submit   submit a file for a student id
turnip-summary  list assignments and submission counts
turnip-status   list one student's submissions
turnip-fetch    print a submitted file
turnip-test     run public tests against a local file
turnip-mark     run marked tests against latest submissions
turnip-rm       remove an assignment
```

## Example Workflow

```sh
./tests/run_demo.sh
```

The demo creates a temporary test bundle, adds an assignment, submits two sample
solutions, runs public tests, marks the latest submissions, fetches a submission,
and removes the assignment.

## Manual Usage

```sh
./turnip-add lab1 tests.tar
./turnip-submit lab1 z1234567 examples/multiply.sh
./turnip-test lab1 examples/multiply.sh
./turnip-status z1234567
./turnip-mark lab1
./turnip-fetch lab1 z1234567
./turnip-rm lab1
```

## Test Bundle Format

`turnip-add` expects a tar archive containing one directory per test. Each test
directory may contain:

```txt
arguments     command-line arguments
stdin         standard input
stdout        expected standard output
stderr        expected standard error
exit_status   expected exit status
options       comparison options
marks         presence means the test is used by turnip-mark
```

Tests without `marks` are public tests used by `turnip-test`. Tests with `marks`
are marking tests used by `turnip-mark`.

## Notes

Turnip stores its working state in `.turnip/`, which is ignored by Git. The
repository includes only the CLI tools, sample programs, and a self-contained
demo test script. Course-specific submission files, private reference tests, and
official materials are not included.
