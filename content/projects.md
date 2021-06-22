---
title: "Projects"
type: "sitecontent"
author: "Jon"
description: "I've got a few bits and pieces that I've created which is available for all to use. Some are pretty nonsense things, intended for fun. Some are more serious and have taken some time to work on (and may still be in progress)."
date: 2019-06-21T22:43:01+01:00
---

### Side projects

#### Cluedo Assistant

[Github](https://github.com/jonifen/cluedo-assistant/) &middot; [Demo](https://jonifen.co.uk/cluedo-assistant/)

At home, like most families, we have the board game Cluedo. As most families have found, the sheets you use to track game progress tend to get used up over time, and you end up with scraps of paper, or making some alternatives in Excel and print a bunch out (we've been here too!) but it seemed a bit of a waste of paper, especially as we all own mobile phones. So I created an initial version of this, which was just large checkboxes next to the names. But I've now evolved it to the current implementation. It's written in React 16.8 in a Test Driven Development way.

My end goal is for this to learn from the accusations being made and make suggestions to the player as to what the winning accusation could be.


#### GameBrowser

[Github](https://github.com/jonifen/GameBrowser/) &middot; Demo coming soon

This is a browser tool to fetch details about a gaming server. It will return the list of players with their scores, and then other details such as mod and map etc.

Initially it only supported Quake III Arena, but I've since added support for the original Unreal Tournament. Currently I'm working on adding support for Steam servers (Quake Live etc.).

It was originally written in a VB6 desktop application, ported to a C# WinForms application and then rewritten during the COVID-19 Lockdown to become a web application with an API.

My end goal is to run this in a Docker container on a Raspberry Pi which is also running a Quake III Arena game server in Docker.

---

### Other projects

#### Terraria server in Docker on Raspberry Pi

[GitHub](https://github.com/jonifen/terraria-docker-raspberry-pi)

We needed a server for us to play Terraria on at home, and it made sense to get it running on a machine that was always on. This meant the Raspberry Pi was the ideal candidate, but any existing solutions online weren't working as we had hoped. This gave me the opportunity to do some learning and get it working myself. The biggest challenge was getting it to work on an ARM cpu rather than x86.

Because I had managed to get things working, I thought it right to share it with others. We can't be the only ones wanting to host a Terraria server on a Pi!

#### Katas

If I have some free time that's not taken up by family time or my other side projects, I like to try katas to find new ways to solve problems. A few of these are on my GitHub account, with attempts committed under branches for reference. The only downside to uploading previous attempts online is that I may be given something much more complicated in an interview one day ;)

---

### Fun stuff

#### Cakeable Offence

[Github](https://github.com/jonifen/cakes/) &middot; [Demo](https://jonifen.co.uk/cakes/)

This was intended as a fun project, created one afternoon at a previous workplace when taking a break from the in-play project work.

The culture was that when a colleague left their machines unlocked, an email was sent out to the department requesting cake orders. As punishment, the colleague had to buy cakes for everyone. However, over time, people stopped buying cakes, and on one occasion, a colleague got a bit upset that they weren't going to be receiving their cake order and as such, the Head of Development said we were no longer to send emails to avoid disappointment, so in a long-winded way, this was then formed. The idea was to put this full screen on their computer screens and lock the machine (for security purposes). On their return, they'd unlock the machine to see the aftermath.


#### Is it home time yet?

[Github](https://github.com/jonifen/isithometimeyet/) &middot; [Demo](https://jonifen.co.uk/isithometimeyet/)

Again, this was created at a previous workplace in a break during a day which appeared to have no end. We've all had days like this, right? It took less than 30 minutes to create, and has had a few minor tweaks over time just to tidy things up a little. This was my opportunity to learn how to use browser notifications (not that I'm a fan, but they do work well for this!)

