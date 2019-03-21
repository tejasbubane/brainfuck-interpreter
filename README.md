# BrainFuck Interpreter

[![Build Status](https://travis-ci.org/tejasbubane/brainfuck-interpreter.svg?branch=master)](https://travis-ci.org/tejasbubane/brainfuck-interpreter)

Interpreter for [brainfuck](https://en.wikipedia.org/wiki/Brainfuck) language in Haskell.

Inspired by [this blog](https://github.com/quchen/articles/blob/master/write_yourself_a_brainfuck.md).

[Examples](spec/support) from [Wikipedia](https://en.wikipedia.org/wiki/Brainfuck).

```sh
stack build
stack exec brainfuck spec/support/hello.bf
stack exec brainfuck spec/support/seven.bf
stack exec brainfuck spec/support/rot13.bf
```
