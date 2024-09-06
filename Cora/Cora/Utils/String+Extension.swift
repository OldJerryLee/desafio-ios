//
//  String+Extension.swift
//  Cora
//
//  Created by Fabricio Pujol on 05/09/24.
//

import Foundation

extension String {
    func applyingCPFFormat() -> String {
        let cleanedString = self.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)
        let length = cleanedString.count
        switch length {
        case 0...3:
            return cleanedString
        case 4...6:
            return "\(cleanedString.prefix(3)).\(cleanedString.suffix(length - 3))"
        case 7...9:
            return "\(cleanedString.prefix(3)).\(cleanedString.dropFirst(3).prefix(3)).\(cleanedString.suffix(length - 6))"
        case 10...:
            return "\(cleanedString.prefix(3)).\(cleanedString.dropFirst(3).prefix(3)).\(cleanedString.dropFirst(6).prefix(3))-\(cleanedString.suffix(length - 9))"
        default:
            return cleanedString
        }
    }
    
    var isCPF: Bool {
        let numbers = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        guard numbers.count == 11 else { return false }

        let set = NSCountedSet(array: Array(numbers))
        guard set.count != 1 else { return false }

        let i1 = numbers.index(numbers.startIndex, offsetBy: 9)
        let i2 = numbers.index(numbers.startIndex, offsetBy: 10)
        let i3 = numbers.index(numbers.startIndex, offsetBy: 11)
        let d1 = Int(numbers[i1..<i2])
        let d2 = Int(numbers[i2..<i3])

        var temp1 = 0, temp2 = 0

        for i in 0...8 {
            let start = numbers.index(numbers.startIndex, offsetBy: i)
            let end = numbers.index(numbers.startIndex, offsetBy: i+1)
            let char = Int(numbers[start..<end])

            temp1 += char! * (10 - i)
            temp2 += char! * (11 - i)
        }

        temp1 %= 11
        temp1 = temp1 < 2 ? 0 : 11-temp1

        temp2 += temp1 * 2
        temp2 %= 11
        temp2 = temp2 < 2 ? 0 : 11-temp2

        return temp1 == d1 && temp2 == d2
    }
}
