# Today I learned:

- voiceover can even read out the image name, so make sure to either have good names or have separate labels for them
- You can use .accessibilityLabel to label image names
- There is .accessibilityAddTraits() to change what the type to be called *like .isButton*
- Then there is .accessibilityRemoveTraits() to remove what the type would be called *like .isImage*\
- Image(decorative:) and Image(*picture*).accessibilityHidden(true) to hide non descriptive/important images
- .accessibilityElement(children: .combine) to combine multiple text views into one sentence
- .accessibilityLabel is another option and you can just pass in your text in there to be read out as one line but change .accessibilityElement to .ignore if you still have the Text views there

## Then in the last example I can combine all of these and accomplish something like this:

```swift
VStack {
    Text("Value: \(value)")
    Button ("Increment") {
        value += 1
    }
    Button ("Decrement") {
        value -= 1
    }
```

then I can have all my modifiers below which accomplish:

**.accessibilityElement()**: To combine the whole vstack into it
**.accessibilityLabel("Value")**: So voiceover knows what to read out
**.accessibilityValue(String(value))**: Now the value is stringified for voiceover
**.accessibilityAdjustableAction**: You pass in a value to the closure to signify the direction in which the user will swipe to increase/decrease the value and if it is a invalid swipe then it will be handled by the default case in the switch statement
