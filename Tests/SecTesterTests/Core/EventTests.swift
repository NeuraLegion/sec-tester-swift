import Mockingbird
@testable import SecTester
import XCTest

final class EventTests: XCTestCase {
  var eventDispatcher: EventDispatcherMock!

  override func setUp() {
    eventDispatcher = mock(EventDispatcher.self)
  }

  override func tearDown() {
    reset(eventDispatcher)
  }

  func testYouCanPublishEvent() async throws {
    let event = Event(payload: "Test", type: nil, correlationId: nil, createdAt: nil)
    given(await eventDispatcher.publish(event: event)).willReturn()

    try await event.publish(dispatcher: eventDispatcher)

    verify(await eventDispatcher.publish(event: event)).wasCalled()
  }
}
