+++
Categories = ["programming"]
Tags = []
Description = ""
Date = "2017-01-16T18:40:00Z"
Title = "Rust in a Week (A Thought Exercise)"
Type = "post"
Draft = true

+++

The consensus is that learning Rust has a steep learning curve. Unfortunately, I have a limited (but not non-existent) amount of time. So I asked myself the question: if I *had* to learn Rust in a week, how would that work?

<!--more-->

??? I actually started learning Rust before this.

Basically, I got to the swearing-at-the-borrow-checker stage, and it felt like I
would be there for some time. Rather than just keep grinding away, I decided to
step back and try a different way of thinking about the problem.

I've been reading [Secrets of Productive People, by Mark
Forster](http://markforster.squarespace.com/), a book which is full of incredibly practical advice (despite the sensationalist title), and one of the ideas that Forster promotes seemed very relevant: keep ask questions.


https://m-decoster.github.io//2017/01/16/fighting-borrowchk/

From https://www.reddit.com/r/rust/comments/5ny09j/tips_to_not_fight_the_borrow_checker/:

mmstick says:

The borrow checker is stupid simple and can boiled down to these simple rules:

    You may only have one mutable borrow at a time
    You may have as many immutable borrows as you want
    You may not borrow immutably and mutably at the same time
    Taking a value by self drops the original value
    Instead of attempting multiple simultaneous mutable borrows, queue your future changes in a separate location and apply them later
