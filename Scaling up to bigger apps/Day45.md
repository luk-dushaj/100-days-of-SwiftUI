# Today was a learning day

- I learned various navigation styling techniques like .navigationBarTitleDisplayMode(.inline), .toolbarBackground, .toolbarColorScheme(.dark), .toolbar(.hidden, for: .navigationBar)
- Also the for: parameter in .toolbarBackground can specify which toolbar to modify
- What ToolBarItem does along with ToolBarItemGroup and the use cases
- also the placement: parameter for where to place the text on screen and the different prebuilt styles for it for example like .confirmationAction to agree to like a TOS or something
- .navigationBarBackButtonHidden(), useful modifier to remove the back button especially in a crucial view for your app
- Saw how to make titles editable basically you create an @State variable and pass it back to .navigationTitle like .navigationTitle($title), then have .navigationBarTitleDisplayMode(.inline) to have a dropdown to rename the title