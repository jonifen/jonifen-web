---
type: "blog"
title: "Moq - Setup Mock method specifying parameters of type"
description: "When working on my GameBrowser project this evening, I wanted to verify that a method setup on a mock object had been called when a property of the parameter object was a particular value."
date: 2020-08-22T22:16:44+01:00
author: "Jon"
tags: ["csharp", "programming", "testing", "moq"]
---
When working on my GameBrowser project this evening, I wanted to verify that a method setup on a mock object had been called when a property of the parameter object was a particular value.

My scenario was that I was writing a unit test for the Quake3 protocol client and within that protocol client, I build the payload to include the 4-byte prefix data, so I needed to test that it was doing that payload building part correctly. I may extract this logic out in the future if I need to, but currently it's only used within the Quake3 protocol so it can remain here for now.

At first, I had been using `It.IsAny<Request>()`, but this didn't allow me to see inside of the object to validate the payload.

First of all, I created the expected request payload that will be passed in the UDP request, and generated a string equivalent of it.

```
_udpRequestPayload = new byte[] { 255,255,255,255,103,101,116,105,110,102,111 };
_udpRequestPayloadString = System.Text.Encoding.Default.GetString(_udpRequestPayload);
```

Then, when setting up the mock of the UDP Server client (which is injected into the Quake3 protocol client), I was able to set up the method listener using the following:
```
_udpServerClient.Setup(c => c.GetData(It.Is<Request>(r => System.Text.Encoding.Default.GetString(r.Payload) == _udpRequestPayloadString))).ReturnsAsync(_udpResponse);
```

As such, by doing it this way, I have been able to verify that the mock method was called with the correct payload as so:

```
_udpServerClient.Verify(u => u.GetData(It.Is<Request>(r => System.Text.Encoding.Default.GetString(r.Payload) == _udpRequestPayloadString)), Times.Once);
```

You can see the rest of the class (to see the full context) in the [GitHub repository](https://github.com/jonifen/GameBrowser), in particular [this class](https://github.com/jonifen/GameBrowser/blob/master/api/GameBrowser.Tests/Clients/Protocols/Quake3ClientTests/WhenGetInfoIsSuccessful.cs).
