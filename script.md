# Webinar 21 - The Power of Small Things in Modern 4D Development

## Slide

Today I’m going to present my favorite new features in 4D 21. These are not features that the end user will directly see in the interface or on the screen.
Taken individually, each improvement may seem small. But when you put them together, they very concretely change the way we develop:
more productivity, code that is easier to read and maintain, and fewer mistakes while writing it.
With 4D 21, many more checks are performed for us even before compiling or running the application — something that wasn’t possible in 4D 20.
So we free up time that we can spend on what really matters: delivering useful features faster and providing more reliable applications to our users.

📍 Slide:
* Form classes (https://blog.4d.com/empower-your-development-process-with-your-forms/)
* Code Live Checker (https://blog.4d.com/introducing-code-live-checker-elevating-code-quality-in-4d-development/)
* Dynamic Data Sources for Forms (https://blog.4d.com/building-forms-on-the-fly-with-new-data-source-commands/)
* Simplified declarations and assignments(https://blog.4d.com/class-property-declarations-and-assignments-on-a-single-line/ andhttps://blog.4d.com/simplify-variable-declarations-assignments-in-a-single-line/)

## Part 1 – Project

The project shown here is intentionally extremely simple. One dataclass, one list form, one detail form. Each form has its own class.

📍 I show the explorer and run the application, open the list form, and double-click the list box to open the detail form.

## Part 2 – Form class and Code Live Checker

Let’s open the List form.
In the property list, you can see the form is associated with its class. Here is the class with its properties and functions.
Immediately we get several benefits:  auto-completion that saves time, better code readability, and most importantly error detection while typing.
For example here, when assigning a datasource to a list box. I deliberately make a mistake, I validate — and a warning appears.
No need to run the application or compile the code anymore to see an error: it appears instantly.
Inside the form code, I also benefit from auto-completion with the Form command — no more typos.

📍 I show error detection in the property list and auto-completion in the code with the list form.

## Part 3 – Dynamic data sources

Let’s run the project and look at this contact. If I change the type, the displayed fields automatically change.
In real applications, it’s common to display different fields depending on an option or a context.
Let’s look at the code.
The form is associated with the ContactDetailForm class. The pop-up calls the CreateDynamicFields function.
We duplicate and position the objects.
The difference is that before, we assigned the data source using pointers. Now, with OBJECT SET DATA SOURCE FORMULA, we directly associate a formula as the data source, which simplifies and clarifies the code.
And here comes the real benefit.
Inside the onSave function, the code you see is not form-specific — it is standard ORDA code.
Previously, dynamic duplication forced us to manipulate pointers. Now, using formulas allows us to write code exactly the same way as everywhere else in the application.

📍 I show the duplication code and the save function.

## Part 4 – Simplified declarations

The final feature is more subtle, but just as important.
It allows you to declare and initialize a variable or property in a single line.
This detail may seem trivial, but in a real project — repeated dozens or even hundreds of times — it significantly improves readability and reduces code verbosity.
For example, here in this method.

📍 I show an initialization in a method.

## Part 5 – Conclusion

That’s it for this demo. No visible feature was added to the interface.
The goal was to observe the code, and how we write it today with 4D 21.
These are very concrete improvements with a direct impact on the developer’s daily work: less code to write, fewer errors, more comfort — and above all more time to focus on what matters for your customers: building useful features, maintaining more stable applications, and reducing bugs.

