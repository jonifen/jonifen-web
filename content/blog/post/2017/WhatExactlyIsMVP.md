+++
draft = true
type = "post"
title = "What exactly is \"MVP\"?"
author = "Jon"
description = "I've been giving the topic of MVP some thought for a while now, and toyed with writing a post about it but never actually got around to it... until now."
tags = [
  "programming",
  "agile",
  "scrum"
]
date = "2017-02-24T19:44:28Z"

+++

I've been giving the topic of MVP some thought for a while now, and toyed with writing a post about it but never actually got around to it... until now.

MVP is an acronym for many things, but in this context, I'm talking about "Minimum Viable Product". It's an agile concept which allows developers to create software which delivers _just enough_ functionality that provides sufficient value for it to be viable to the customer.

#### But how much functionality is _just enough_?

Let's look at an example. A salon owner has been in touch. They want a system that can:

 * Store details of their customers
 * Provide a calendar to allow the booking of appointments and stop double bookings
 * Provide a secure website for customers to book appointments in available slots to reduce interruptions for salon staff when they are with other customers
 * Send emails/SMS to remind customers of their upcoming appointments, to stop people from missing appointments
 * Send emails/SMS to those customers to advise of promotions if it's a known occasion or they've not visited for a while.
 * keep track of customers' previous appointments (including any "treatments" - or whatever it's called at a salon, I'm going bald, so how would I know!?)
 * Be simultaneously accessible on a computer and tablet devices (each member of staff will be provided with a tablet) to allow multiple people to check/update the diary.

Now we know that it would take quite some time to offer all of this functionality, and the salon owner wants it ASAP because their current system is no longer suitable.

So a team of developers go away, look at the requirements and offer an estimate of 3 months. The salon owner doesn't want to wait that long though, they want it in an absolute maximum of 2 weeks! What do the developers do now? 3 months doesn't fit into 2 weeks. And the developers can't work 24/7 on it (despite some misconceived theories that all developers are writing code all of the time...)

Let's look at this from a different angle for a moment. What functionality can the salon owner live without in the first release if the developers provide only some of the requirements at the first release?

The salon owner says that their current paper diary doesn't work well, as only one member of staff can update it at any time. As a result, staff members are assuming that they are free at a particular time (as they can't check the book to be sure) and are trying to remember new appointments with the intention of updating the diary. Except they forget. They end up double booked, with angry customers which turns into a loss of business as angry customers are usually very vocal with bad experiences!

So the developers have their first requirement: "Provide a calendar to allow the booking of appointments". By providing a web-based application, it can be accessible on multiple devices simultaneously. This is the second requirement sorted too.

The developers go back to the owner and suggest these two requirements as a first release. The owner still wants it all really, but is happy to compromise on the basis that he gets something in 2 weeks' time.

He says that missed appointments are typically a bigger problem at other times of the year, so he's happy for this to wait for a later time. He also says that they've never kept a record of customers and past appointments/treatments, so this can also wait a while longer. And he's happy to wait for the online booking system as it's something that'll be more valuable in the summer and also in the run-up to Christmas.

The developers get to work and in 2 weeks they've created a responsive web application that is accessible on a computer and on multiple tablet devices and allows the staff to book in appointments with a name and phone number. It is a direct replacement for their current paper book, but it's a huge success. The salon owner is delighted as he no longer has any double bookings or missed appointments. Their customers are happier as a result.

This software is the Minimum Viable Product for the salon owner. They've received software within their expected timescale which already adds value to their day to day workload and solves a problem they had. The software will be revisited, so the developers accepted that they'd take some shortcuts in terms of code quality because it can be refactored when additional features are added at a later date. Obviously, while the code isn't the most elegant, it isn't the "giant sweaty mess" that some might assume, but it works, and is pretty performant at the same time. It's also easy for the developers to pick up again as it's self-explanatory.

The salon owner now wants the system to retain customer details so they can see previous appointments. The developers add the customer details functionality, and revisit the appointments area to remove the previous name/number fields and tie in the customer details functionality instead. They perform some refactoring here too to clean things up a bit. They don't expect to be coming back here for a while, but it's cleaner (than before), it's still very readable (and therefore maintainable) and as a result, the new developer who joins the team next week will be able to understand it just fine.

#### So when is MVP not MVP?

Just to recap on the above: MVP is the absolute minimum amount of functionality that can be provided to an end user which gives them value.

MVP should be done in the quickest amount of time, and therefore it's acceptable for some shortcuts to be made along the way (which should be taken on as "Technical Debt" at a later date).

What if the developers wrote clean, elegant code in the first instance, but it resulted in the first requirements taking longer to release? The salon owner is fine with it (in this instance anyway), but the areas of code are being revisited in the next release anyway - we could have given them something sooner.

### Get in touch!

What are your thoughts on MVP? In particular, code quality in the first instance when you know you will be revisiting the code in the near future.

What are your thoughts on Technical Debt?

Give me a shout on Twitter @jonifen - I'd be interested to hear other developers' theories/opinions on the matter.
