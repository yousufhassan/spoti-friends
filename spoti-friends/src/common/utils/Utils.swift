import Foundation
import CryptoKit

/// Print the error message to the console.
func printError(_ message: String) -> Void {
    print("ERROR: " + message)
}

/// Print the info message to the console.
func printInfo(_ message: String) -> Void {
    print("INFO: " + message)
}

/// Store the key-value pair in the user defaults object.
func storeInUserDefaults(key: String, value: Any) -> Void {
    UserDefaults.standard.set(value, forKey: key)
}

func getStringFromUserDefaultsValueForKey(_ key: String) -> String {
    return UserDefaults.standard.string(forKey: key) ?? ""
}
