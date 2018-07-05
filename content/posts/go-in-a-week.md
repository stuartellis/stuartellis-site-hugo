+++
Categories = ["programming"]
Tags = []
Description = ""
Date = "2018-07-05T20:11:00Z"
Title = "Go in a Week (Maybe)"
Type = "post"
Draft = true

+++

The consensus is that Go has is easy to learn. I have a limited (but not non-existent)
amount of time. So I asked myself the question: if I had to learn Go in a week, how
would that work?

<!--more-->

I actually looked at Go before this.

I've been reading
[Secrets of Productive People, by Mark Forster](http://markforster.squarespace.com/), a
book which is full of incredibly practical advice (despite the sensationalist title),
and one of the ideas that Forster promotes seemed extremely relevant: keep ask
questions.

# Questions!

- How do I learn Go in a week?
- What does "learn" mean here?
- Exactly how long is a "a week"?
- What do I need before I start?
- What do I learn before anything else?
- What concepts are essential to be able to read Go code?
- What concepts are important to be able to write Go code?
- What do I do afterwards?

# Requirements

- Atom package go-plus

# How?

- https://tour.golang.org/
- [Learn Go in One Video, by Derek Banas](https://www.youtube.com/watch?v=CF9S4QZuV30)
- [Golang Web Dev, by Todd McLeod](https://www.youtube.com/watch?v=Xfd24pMt_Q8&list=PLSak_q1UXfPrPJ3s7v43CMH9iMa4Dvh4X)
- https://learnxinyminutes.com/docs/go/
- https://howistart.org/posts/go/1
- https://dave.cheney.net/resources-for-new-go-programmers

Install the [Tour of Go](https://tour.golang.org/) for offline use:

    go get golang.org/x/tour/gotour

Run the Tour:

    gotour

Install the Linter and the Go Tools pack:

    go get -u golang.org/lint/lint
    go get -u golang.org/x/tools

Other peoples answers:

[Tiffany Jernigan - How to Raise a Gopher in Record Time](https://youtu.be/85-ii6Dgi1s?list=PLDWZ5uzn69eyh791ZTkEA9OaTxVpGY8_g)

[Getting started with Go, by Andrew Gerrand](https://www.youtube.com/watch?v=2KmHtgtEZ1s)

"Hannah Get Go-ing":

https://www.youtube.com/watch?v=m9U6YwJupfA&feature=youtu.be

Evolution of a Gopher, by Francesc Campoy:

https://www.youtube.com/watch?v=5iD0Hl0alZ0

"Go: The Language, the Purpose, the Ecosystem, and the Community by Carlisia Pinto"

https://www.youtube.com/watch?v=x-iUWJlVfiY

# Concepts

- Garbage collection
- Concurrency
- Constants
- Interfaces
- Packages
- _nil_

# Best Practices

[Twelve Go Best Practices](https://youtu.be/8D3Vmm1BGoY), by Francesc Campoy:

1.  "Avoid nesting by handling errors first" - Check that err is not equal to nil, and
    use early returns
2.  "Avoid repetition when possible" - Do not repeat the package name in the functions
    and structs, deploy one-off utility types for simpler code, use switch on types for
    special cases, use function adapters to add shared behaviour to functions
3.  "Important code goes first" - "License, then build tags, then package
    documentation", put the most important types or functions first in the code
4.  "Document your code" - Include package documentation, as well as function
    documentation; remember that exposed identifiers will appear in godoc
5.  "Shorter is better" - Use the shortest name that is self-explanatory
6.  "Packages with multiple files" - Have a _doc.go_ for package documentation
7.  "Make your packages "go get-able" - Use a separate _cmd_ directory for executables
    (which are not reusable, because _main_ packages cannot be imported)
8.  "Ask for what you need" - Use interfaces as function parameters; make interfaces as
    small as possible
9.  "Keep independent packages independent" - Separate domain types and interfaces from
    specific resource handling
10. "Avoid concurrency in your API" - Concurrency is the business of the application,
    not the libraries
11. "Use goroutines to manage state"
12. "Avoid leaking goroutines"

# Afterwards

- [Standard Package Layout](https://medium.com/@benbjohnson/standard-package-layout-7cdbc8391fc1#.epus9ggex)
- [Understanding nil](https://www.youtube.com/watch?v=ynoY2xz-F8s)
- [Effective Go](???)
- [7 common mistakes in Go and when to avoid them by Steve Francia (Docker)](https://www.youtube.com/watch?v=29LLRKIL_TI)
- [Golang UK Conference 2016 - Dave Cheney - SOLID Go Design](https://www.youtube.com/watch?v=zzAdEt3xZ1M)
- [dotGo 2015 - Fatih Arslan - Tools for working with Go Code](https://www.youtube.com/watch?v=wqN-l4OrMP4)
- [Go Tooling in Action](https://www.youtube.com/watch?v=uBjoTxosSys)
