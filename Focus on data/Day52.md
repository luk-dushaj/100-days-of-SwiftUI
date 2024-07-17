# Today was a review and challenge day

I successfully completed both and here were the challenges I completed to add on top of the CupcakeCorner project:

1. Our address fields are currently considered valid if they contain anything, even if it’s just only whitespace. Improve the validation to make sure a string of pure whitespace is invalid.
2. If our call to placeOrder() fails – for example if there is no internet connection – show an informative alert for the user. To test this, try commenting out the request.httpMethod = "POST" line in your code, which should force the request to fail.
3. For a more challenging task, try updating the Order class so it saves data such as the user's delivery address to UserDefaults. This takes a little thinking, because @AppStorage won't work here, and you'll find getters and setters cause problems with Codable support. Can you find a middle ground?
