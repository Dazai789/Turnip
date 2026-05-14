#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$ROOT"

rm -rf .turnip

work=$(mktemp -d "${TMPDIR:-/tmp}/turnip-demo.XXXXXX")
trap 'rm -rf "$work"; rm -rf "$ROOT/.turnip"' EXIT INT TERM

mkdir -p "$work/tests/public-small" "$work/tests/public-negative"
mkdir -p "$work/tests/mark-small" "$work/tests/mark-negative"

printf '3\n' > "$work/tests/public-small/arguments"
printf '4\n' > "$work/tests/public-small/stdin"
printf '12\n' > "$work/tests/public-small/stdout"

printf -- '-2\n' > "$work/tests/public-negative/arguments"
printf '5\n' > "$work/tests/public-negative/stdin"
printf -- '-10\n' > "$work/tests/public-negative/stdout"

printf '6\n' > "$work/tests/mark-small/arguments"
printf '7\n' > "$work/tests/mark-small/stdin"
printf '42\n' > "$work/tests/mark-small/stdout"
printf '5\n' > "$work/tests/mark-small/marks"

printf -- '-3\n' > "$work/tests/mark-negative/arguments"
printf '8\n' > "$work/tests/mark-negative/stdin"
printf -- '-24\n' > "$work/tests/mark-negative/stdout"
printf '5\n' > "$work/tests/mark-negative/marks"

tar -cf "$work/multiply.tests" -C "$work/tests" .

./turnip-add lab1 "$work/multiply.tests"
./turnip-submit lab1 z1234567 examples/multiply_wrong.sh
./turnip-submit lab1 z7654321 examples/multiply_right.py

./turnip-summary
./turnip-status z1234567

./turnip-test lab1 examples/multiply.sh
./turnip-mark lab1

./turnip-fetch lab1 z7654321 >/dev/null
./turnip-rm lab1

echo "demo complete"
