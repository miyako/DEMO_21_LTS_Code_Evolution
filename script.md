# Webinar 21 - The Power of Small Things in Modern 4D Development

## Slide

Today, I’m not going to talk to you about a big, spectacular feature, nor about a new capability that your customers will immediately notice on screen.I’m going to talk about small evolutions, introduced between 4D 20 R2 and 21, that directly impact your day-to-day work as a developer.
Individually, these evolutions may seem modest.But when you put them together, they very concretely change the way code is written and maintained: you write less code, the code is more readable and safer, you work faster thanks to auto-completion, and ultimately you gain time to focus on higher-value tasks.

📍 Slide:
* Form classes (https://blog.4d.com/empower-your-development-process-with-your-forms/)
* Code Live Checker (https://blog.4d.com/introducing-code-live-checker-elevating-code-quality-in-4d-development/)
* Dynamic Data Sources for Forms (https://blog.4d.com/building-forms-on-the-fly-with-new-data-source-commands/)
* Simplified declarations and assignments(https://blog.4d.com/class-property-declarations-and-assignments-on-a-single-line/ andhttps://blog.4d.com/simplify-variable-declarations-assignments-in-a-single-line/)

## Part 1 – Project

The project presented here is deliberately extremely simple.One dataclass, one list form, one detail form.Each form has its own class.

📍 I show the explorer and run the application, open the list form, and double-click the list box to open the detail form.

## Part 2 – Form class and Code Live Checker

The form is associated with its class.From that moment on, several benefits immediately appear: auto-completion, better code readability, and error detection while writing the code.
There is no longer any need to run the application or compile the code: the error is visible immediately.
For example here, when associating a data source with a list box.Or directly in the form’s code.
Previously, this type of error would appear at runtime.Now, 4D reports it while you are typing the code.

📍 I show auto-completion in the property list and in the code with the list form.

## Part 3 – Dynamic data sources

In applications, it is common to display different fields depending on an option or a context.Thanks to OBJECT DUPLICATE, you already do this perfectly in your applications. But you are forced to use pointers.
Today, with the OBJECT SET DATA SOURCE FORMULA command, you can do exactly the same thing using formulas.
And this is where the real difference lies.In the onSave function, the code shown is not specific to the form at all: it is standard ORDA code.
Previously, dynamic duplication required manipulating pointers.Now, using formulas makes it possible to write code exactly the same way as everywhere else in the application.

📍 I show the duplication code.

## Part 4 – Simplified declarations

The last feature presented is more subtle.It is the ability to declare and initialize a variable or a property on a single line.
This detail may seem trivial.But in a real project, repeated dozens or hundreds of times, it significantly improves code readability and reduces verbosity.

📍 I show an initialization in my class.

## Part 5 – Conclusion

That’s it for this demo.Nothing spectacular has been built here.No visible feature has been added on screen.
The goal was simply to observe the code, and the way it is written today with 4D.
These are not the kinds of features that produce impressive demonstrations.But they are precisely the ones that make a difference on a daily basis:less code to write, fewer errors, more comfort, and above all more time to focus on what really matters.
