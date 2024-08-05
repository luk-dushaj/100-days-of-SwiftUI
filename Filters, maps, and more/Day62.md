# Today I learned:

- Cool stuff about @State and @Environment are actually just structs behind the scenes
- Learned about how those are called property wrappers and also how didSet doesn't work with $ bindings underneath the hood because bindings bypass the setter in the @State struct. While in his example code setting the value itself does trigger the didSet.
- the .onChange modifier solves the binding issue above with executing code as soon as a property has changed
- .confirmationDialog and how flexible it is *basically tap out of the view* and I can display multiple options for the user
