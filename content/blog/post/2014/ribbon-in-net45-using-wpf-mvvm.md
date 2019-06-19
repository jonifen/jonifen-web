---
author: "Jon"
date: "2014-07-18T20:18:00Z"
description: "I've been spending some time recently to learn WPF a bit better including the MVVM pattern to encourage the separation of concerns between the view and the logic behind it."
tags: ["programming", "csharp", "wpf"]
title: "Ribbon in .NET 4.5 using WPF and MVVM"
type: "post"

---

I've been spending some time recently to learn WPF a bit better including the MVVM pattern to encourage the separation of concerns between the view and the logic behind it.

It's been a steep learning curve (to say the least!) but today I spent a bit of time looking into getting an Office-esque ribbon bar onto the main window of my dummy application. At first I wasn't too sure, but I soon realised it's not too dissimilar to any other button.

First of all, you need to add the Ribbon bar onto the screen (or enter the following XAML:

	<Ribbon>
		<RibbonTab header="A random tab name">
			<RibbonGroup header="A random group name">
				<RibbonButton largeimagesource="ImageLocation\Image.png" label="Button caption" command="{Binding ClickTheButton}">
			</RibbonGroup>
		</RibbonTab>
	</Ribbon>

Of course, the binding to the ViewModel is already configured for the View at this stage :-)

Then, I added the following C# code to the ViewModel:

	public ICommand ClickTheButton
	{
		get { return new RelayCommand(new Action(this.ClickTheButtonExecute), this.CanClickTheButtonExecute); }
	}

	private void ClickTheButtonExecute()
	{
		// Your code goes here to respond to the button click
	}

	private bool CanClickTheButtonExecute()
	{
		// Logic would go here to decide whether the button should be enabled or not.
		// Hard coding a return value of true will mean the button will always be enabled.
		return true;
	}

You'll notice that I've been using a class called "RelayCommand". I got this from an [article by Josh Smith for MSDN Magazine](http://msdn.microsoft.com/en-us/magazine/dd419663.aspx#id0090030).

Hopefully this will help a few people out.
