import Foundation
import SwiftUI

extension String {
    init(localized key: String.LocalizationValue, comment: StaticString = "") {
        self.init(localized: key, bundle: Bundle(for: AccuChekUIController.self), comment: comment)
    }

    subscript(bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start ... end])
    }

    subscript(bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start ..< end])
    }

    var asciiValues: Data { Data(compactMap(\.asciiValue)) }

    func replace(target: String, withString: String) -> String {
        replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}

extension Text {
    init(_ key: LocalizedStringKey, comment: StaticString = "") {
        self.init(key, bundle: Bundle(for: AccuChekUIController.self), comment: comment)
    }
}
