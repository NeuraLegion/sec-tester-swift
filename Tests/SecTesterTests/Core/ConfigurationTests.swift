import Mockingbird
@testable import SecTester
import XCTest

final class ConfigurationTests: XCTestCase {
  var provider: CredentialProviderMock!

  override func setUp() {
    provider = mock(CredentialProvider.self)
  }

  override func tearDown() {
    reset(provider)
  }

  func testYouCanNotCreateConfigurationIfCredentialsOrCredentialProvidersAreNotPassed() async throws {
    XCTAssertThrowsError(try Configuration(hostname: "example.com", credentialProviders: []))
  }

  func testYouCanNotCreateConfigurationIfHostnameIsWrong() async throws {
    XCTAssertThrowsError(try Configuration(hostname: ":test", credentials: try Credentials(token: "weobbz5.nexa.vennegtzr2h7urpxgtksetz2kwppdgj0")))
  }

  func testYouCanPassUrlInsteadOfHost() async throws {
    let config = try Configuration(hostname: "https://example.com")

    XCTAssertEqual(config.bus, "amqps://amq.example.com:5672")
    XCTAssertEqual(config.api, "https://example.com")
  }

  func testYouCanPassLocalhostAsHostname() async throws {
    let config = try Configuration(hostname: "localhost")

    XCTAssertEqual(config.bus, "amqp://localhost:5672")
    XCTAssertEqual(config.api, "http://localhost:8000")
  }
}
