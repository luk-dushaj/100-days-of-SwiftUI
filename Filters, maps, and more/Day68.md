# Today I learned:

- passing closures in .sorted to manually sort the data
- The Comparable type along with seeing how operator overloading words
- URL.documentsDirectory is the directory we get control of to use and write/read data
- the options .atomic writes the data to a temporary file then after writes the data back to main. Thats in case if another part of the app is currently gonna read the data.
- The .completeFileProtection is to make sure the data is fully encrypted until the user unlocks the phone, yes it is fully optional because iOS is very secure but why not when it isn't a hassle to add.
- Switching view states with enums and how effortless it can be
