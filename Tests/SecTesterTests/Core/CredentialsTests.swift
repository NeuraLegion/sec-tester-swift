@testable import SecTester
import XCTest

final class CredentialsTests: XCTestCase {
  func testYouCanObserveErrorIfTokenIsNotValid() async throws {
    XCTAssertThrowsError(try Credentials(token: "qwerty").token)
  }

  func testYouCanUseOrgApiKey() async throws {
    let token = "weobbz5.nexa.vennegtzr2h7urpxgtksetz2kwppdgj0"

    let credentials = try Credentials(token: token)

    XCTAssertEqual(credentials.token, token)
  }

  func testYouCanUsePersonalApiKey() async throws {
    let token = "w0iikzf.nexp.aeish9lhiag7ledmsdwpwcbilagupc3r"

    let credentials = try Credentials(token: token)

    XCTAssertEqual(credentials.token, token)
  }

  func testYouCanUseProjectApiKey() async throws {
    let token = "0zmcwpe.nexr.0vlon8mp7lvxzjuvgjy88olrhadhiukk"

    let credentials = try Credentials(token: token)

    XCTAssertEqual(credentials.token, token)
  }
}
