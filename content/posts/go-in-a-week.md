+++
Categories = ["programming"]
Tags = []
Description = ""
Date = "2017-01-16T18:40:00Z"
Title = "Go in a Week (Maybe)"
Type = "post"
Draft = true

+++

The consensus is that Go has is easy to learn. I have a limited (but not non-existent) amount of time. So I asked myself the question: if I had to learn Go in a week, how would that work?

<!--more-->

I actually looked at Go before this.

I've been reading [Secrets of Productive People, by Mark
Forster](http://markforster.squarespace.com/), a book which is full of incredibly practical advice (despite the sensationalist title), and one of the ideas that Forster promotes seemed extremely relevant: keep ask questions.

# Questions!

* How do I learn Go in a week?
* What does "learn" mean here?
* Exactly how long is a "a week"?
* What do I need before I start?
* What do I learn before anything else?
* What concepts are essential to be able to read Go code?
* What concepts are important to be able to write Go code?
* What do I do afterwards?

# Requirements

* Atom package go-plus

# How?

* https://tour.golang.org/
* [Learn Go in One Video, by Derek Banas](https://www.youtube.com/watch?v=CF9S4QZuV30)
* [Golang Web Dev, by Todd McLeod](https://www.youtube.com/watch?v=Xfd24pMt_Q8&list=PLSak_q1UXfPrPJ3s7v43CMH9iMa4Dvh4X)
* https://learnxinyminutes.com/docs/go/
* https://howistart.org/posts/go/1
* https://dave.cheney.net/resources-for-new-go-programmers

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

"Audrey Lim - How a complete beginner learned Go as her first backend language in 5 weeks":

https://www.youtube.com/watch?v=fZh8uCInEfw

Evolution of a Gopher, by Francesc Campoy:

https://www.youtube.com/watch?v=5iD0Hl0alZ0

"Go: The Language, the Purpose, the Ecosystem, and the Community by Carlisia Pinto"

https://www.youtube.com/watch?v=x-iUWJlVfiY

# Concepts

* Garbage collection
* Concurrency
* Constants
* Interfaces
* Packages
* *nil*

# Afterwards

* [Standard Package Layout](https://medium.com/@benbjohnson/standard-package-layout-7cdbc8391fc1#.epus9ggex)
* [Understanding nil](https://www.youtube.com/watch?v=ynoY2xz-F8s)
* [Effective Go](???)
* [7 common mistakes in Go and when to avoid them by Steve Francia (Docker)](https://www.youtube.com/watch?v=29LLRKIL_TI)
* [Golang UK Conference 2016 - Dave Cheney - SOLID Go Design](https://www.youtube.com/watch?v=zzAdEt3xZ1M)
* [dotGo 2015 - Fatih Arslan - Tools for working with Go Code](https://www.youtube.com/watch?v=wqN-l4OrMP4)
* [Go Tooling in Action](https://www.youtube.com/watch?v=uBjoTxosSys)
