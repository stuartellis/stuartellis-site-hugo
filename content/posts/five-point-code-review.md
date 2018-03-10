+++
Categories = ["programming"]
Tags = []
Description = ""
Date = "2017-10-23T13:10:00Z"
Title = ""
Type = "post"
Draft = true

+++

Notes on code reviews.

<!--more-->

# Code review

Acronym of *LETS-C*:

* *Legal* - Does this link to or include a copy of third-party code? If so, can you see the license?
* *Efficient* - Does this code do the minimum amount of work? Does it use more objects that it needs?
* *Testable* - How is this code tested? How will it be re-tested when something changes?
* *Safe* - What happens if this code fails? Will the people reading logs and error messages understand them?
* *Correct* - Does this code do what the ticket describes? Does it do other things as well?
