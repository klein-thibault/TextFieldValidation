//: UITextField validation

import UIKit

extension UITextField {

    func validateField(functions: [String -> Bool]) -> Bool {
        return functions.map { f in f(self.text ?? "") }.reduce(true) { $0 && $1 }
    }
    
}

extension String {
    func evaluate(regexp: String) -> Bool {
        guard let range = rangeOfString(regexp, options: .RegularExpressionSearch) else {
            return false
        }
        return range.startIndex == startIndex
            && range.endIndex == endIndex
    }
}

func isPhoneNumberValid(text: String) -> Bool {
    let regexp = "^[0-9]{10}$"
    return text.evaluate(regexp)
}

func isZipCodeValid(text: String) -> Bool {
    let regexp = "^[0-9]{5}$"
    return text.evaluate(regexp)
}

func isStateValid(text: String) -> Bool {
    let regexp = "^[A-Z]{2}$"
    return text.evaluate(regexp)
}

func isCVCValid(text: String) -> Bool {
    let regexp = "^[0-9]{3,4}$"
    return text.evaluate(regexp)
}

func isEmailValid(text: String) -> Bool {
    let regexp = "[A-Z0-9a-z._]+@([\\w\\d]+[\\.\\w\\d]*)"
    return text.evaluate(regexp)
}

let cvcTextField = UITextField()
cvcTextField.text = "123"
cvcTextField.validateField([isCVCValid])

let emailTextField = UITextField()
emailTextField.text = "thibault@gmail.com"
emailTextField.validateField([isEmailValid])
