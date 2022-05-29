import Mockingbird
@testable import SecTester
import XCTest

final class MessageTests: XCTestCase {
  func testYouCanUseDefaultValues() async throws {
    let payload = "Test"

    let message = Message(payload: payload, type: nil, correlationId: nil, createdAt: nil)

    XCTAssertEqual(message.payload, payload)
    XCTAssertEqual(message.type, "Message")
    XCTAssertNotNil(message.correlationId)
    XCTAssertNotNil(message.createdAt)
  }

  func testYouCanSpecifyConcreteValues() async throws {
    let payload = "Test"
    let correlationId = "1"
    let createdAt = Date()
    let type = "Event"

    let message = Message(payload: payload, type: type, correlationId: correlationId, createdAt: createdAt)

    XCTAssertEqual(message.payload, payload)
    XCTAssertEqual(message.type, type)
    XCTAssertEqual(message.correlationId, correlationId)
    XCTAssertEqual(message.createdAt, createdAt)
  }
}
