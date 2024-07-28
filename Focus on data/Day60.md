# Today was a review and advanced technique day

- I reviewed and really went over what I learned in this unit
Then I learned a lot more about Codable like:
- directly decoding, decoder.keyDecodingStrategy = .convertFromSnakeCase
- Creating a enum to convert properties to swift:
```swift
struct User: Codable {
    enum CodingKeys: String, CodingKey {
        case firstName = "first"
        case lastName = "last"
    }

    var firstName: String
    var lastName: String
}
```
- also you can customly convert properties to different types:
```swift
struct User: Codable {
    enum CodingKeys: String, CodingKey {
        case firstName = "first"
        case lastName = "last"
        case age
    }

    var firstName: String
    var lastName: String
    var age: Int

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        let stringAge = try container.decode(String.self, forKey: .age)
        self.age = Int(stringAge) ?? 0
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.firstName, forKey: .firstName)
        try container.encode(self.lastName, forKey: .lastName)
        try container.encode(self.age, forKey: .age)
    }
}
```
