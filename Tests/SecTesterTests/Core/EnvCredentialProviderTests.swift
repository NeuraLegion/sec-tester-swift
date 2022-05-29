import Mockingbird
@testable import SecTester
import XCTest

final class EnvCredentialProviderTests: XCTestCase {
  func testYouCanNotGetCredentialsFromEnvironment() async throws {
    let provider = EnvCredentialProvider()

    let credentials = try await provider.get()

    XCTAssertEqual(credentials?.token, nil)
  }

  func testYouCanGetCredentialsFromEnvironment() async throws {
    let provider = EnvCredentialProvider(["BRIGHT_TOKEN": "weobbz5.nexa.vennegtzr2h7urpxgtksetz2kwppdgj0"])

    let credentials = try await provider.get()

    XCTAssertEqual(credentials?.token, "weobbz5.nexa.vennegtzr2h7urpxgtksetz2kwppdgj0")
  }
}
