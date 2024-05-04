let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

// I will admit only part I struggled on was I didn't know I had to map each element to the string type.
// https://www.hackingwithswift.com/forums/swift/using-map-function-to-transform-int-to-string/19695
let answer = luckyNumbers.filter{ $0 % 2 == 1 }.sorted().map( {String($0)} )

for i in answer {
    print("\(i) is a lucky number")
}
