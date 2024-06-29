import Foundation
import Testing

@Suite("Code Challege Tests")
struct codeChallengeTests {
    @Test func codeChallenge() async throws {
        let result = CodeChallenge.shared.generateCodeChallenge()
        #expect(result.isEmpty)
    }
}
