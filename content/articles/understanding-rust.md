+++
Title = "Understanding Rust"
Slug = "understanding-rust"
Date = "2017-01-02T16:50:00+00:00"
Description = "Notes on the Rust programming language"
Categories = ["programming"]
Tags = ["programming", "rust"]
Type = "article"
Draft = true

+++

The [Rust programming language](https://www.rust-lang.org) is not difficult, but
requires you to understand a few concepts before you start to work with it.

<!--more-->

# Overview #

## String ##

Rust has two basic types for strings:

* *String* holds a set of characters encoded in UTF-8
* *&str* is a pointer to a string that is stored elsewhere

Strings are collections, like arrays and vectors. Internally, a String is
actually a Vec<u8> (a vector of 8-bit unsigned numbers). You need to use methods
like *to_string* to access the contents of a String as text:

```rust
 let my_string = "This is a string!";
 println!("{}", my_string.to_string());
```

Similarly, you should use *String::from* to create a String from text:

```rust
let my_string = String::from("This is a string!");
```

You cannot get individual characters in a String with indexing. Instead use the
*chars* method to loop over human-readable characters extracted from the string.

Rust also has other string types for specialised purposes.

## Ownership ##

1. Each value in Rust has a variable that is called its owner.
2. There can only be one owner at a time.
3. When the owner goes out of scope, the value will be dropped.

Rust removes values from memory by calling the *drop* function on the value when
the owner goes out of scope.

## Moves ##

Rust only creates deep copies of values either when explicitly told to, or when
handling types with a known (built-in) size, like integers, floating point
numbers and booleans. Otherwise, it *moves* the value.

A move copies the pointer, length and capacity of the value to the new value,
and invalidates the first value.

This means that by default, if you use a variable as an input to a function, the
function then takes ownership of the value.

## Copying ##

Types with a known size implement the *Copy* trait. Types cannot implement both
*Copy* and *Drop*.

Tuples of types with *Copy* also implement *Copy*. A tuple will not implement
the *Copy* trait if it contains any type that does not implement *Copy*, such as
String.

## Borrowing ##

TODO

## Lifetimes ##

TODO

## Modules ##

TODO

## Tools ##

TODO

* rustup
* cargo
* rustfmt
* clippy

Cargo is Rust’s primary workflow tool.

Cargo supports [third-party subcommands](https://github.com/rust-lang/cargo/wiki/Third-party-cargo-subcommands).

## Compiling Rust Code ##

Rust uses [LLVM](http://llvm.org/) to produce binary library and executable
files. The Rust compiler first converts Rust source code into MIR (Mid-level
Intermediate Representation), performs several operations on the MIR code, and
then converts the final MIR version of the code into LLVM bytecode. LLVM itself
then compiles the bytecode into a library or executable for a specific operating
system.

This means that a Rust library can be made in a way that allows the functions to
be called from other languages, such as Python, in the same way that the
functions of C libraries can be called from higher-level languages.

## Documentation ##

To use the supplied documentation, first install it with *rustup*:

    rustup component add rust-docs

To open the documentation, enter the command *rustup doc*:

    rustup doc

To see the documentation for a specific error code, run *rustc --explain*:

    rustc --explain E0200
