import Foundation
import CryptoKit


/// This Singleton class contains the functions that generate the Code Challenge needed for implementing the Authorization with PKCE Flow.
class CodeChallenge {
    static let shared = CodeChallenge()
    
    /// Generates and returns the code challenge for Spotify Authorization.
    /// It can only be used with the `auth` module.
    internal func generateCodeChallenge() -> String {
        let codeVerifier = generateRandomStringOfLength(64)
        let hashed = Data(sha256(codeVerifier))
        let codeChallenge = base64encode(hashed)
        
        storeInUserDefaults(key: "code_verifier", value: codeVerifier)
        return codeChallenge
    }
    
    /// Generates and returns a random string of a given length.
    private func generateRandomStringOfLength(_ length: Int) -> String {
        let possibleCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        let possibleCharactersArray = Array(possibleCharacters)
        var randomString = ""
        
        for _ in 0..<length {
            if let randomCharacter = possibleCharactersArray.randomElement() {
                randomString.append(randomCharacter)
            }
        }
        
        return randomString
    }
    
    /// Returns a SHA-256 hashing of the input string.
    private func sha256(_ input: String) -> SHA256Digest {
        let inputData = Data(input.utf8)  // Convert the input string to Data
        let hashed = SHA256.hash(data: inputData)  // Perform SHA-256 hash
        return hashed
    }
    
    /// Returns the input in a Base64 encoded  and URL-safe form.
    private func base64encode(_ input: Data) -> String {
        // Convert the input data to a Base64 encoded string
        let base64Encoded: String = input.base64EncodedString()
        
        // Replace URL-unsafe characters
        let base64UrlSafe: String = base64Encoded
            .replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
        
        return base64UrlSafe
    }
}
