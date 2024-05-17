# So today was a challenge day I had to write a app based on these directions:

## Your challenge
You need to build an app that handles unit conversions: users will select an input unit and an output unit, then enter a value, and see the output of the conversion.

Which units you choose are down to you, but you could choose one of these:

- Temperature conversion: users choose Celsius, Fahrenheit, or Kelvin.
- Length conversion: users choose meters, kilometers, feet, yards, or miles.
- Time conversion: users choose seconds, minutes, hours, or days.
- Volume conversion: users choose milliliters, liters, cups, pints, or gallons.

If you were going for length conversion you might have:

- A segmented control for meters, kilometers, feet, yard, or miles, for the input unit.
- A second segmented control for meters, kilometers, feet, yard, or miles, for the output unit.
- A text field where users enter a number.
- A text view showing the result of the conversion.
- 
So, if you chose meters for source unit and feet for output unit, then entered 10, you’d see 32.81 as the output.

I will say the app and the logic of the app wasn't hard I got all of it done in a day. Only thing I struggled with was getting my enum to work with my Picker. All that struggling was for a single line of code I missed...

```swift
var id: Self { self }
```