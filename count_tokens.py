#!/usr/bin/env python3
import codecs
import sys

import tiktoken

# Create encoder once globally
enc = tiktoken.get_encoding("cl100k_base")


def count_tokens(text):
    try:
        # Use the global encoder directly
        return len(enc.encode(text))
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        return 0


if __name__ == "__main__":
    # Use binary mode and handle encoding with codecs
    sys.stdin = codecs.getreader("utf-8")(sys.stdin.buffer, errors="ignore")
    text = sys.stdin.read()
    print(count_tokens(text))
