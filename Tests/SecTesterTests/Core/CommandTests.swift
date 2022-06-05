import Mockingbird
@testable import SecTester
import XCTest

final class CommandTests: XCTestCase {
  var commandDispatcher: CommandDispatcherMock!

  override func setUp() {
    commandDispatcher = mock(CommandDispatcher.self)
  }

  override func tearDown() {
    reset(commandDispatcher)
  }

  func testYouCanExecuteCommand() async throws {
    let command = Command<String, String>(payload: "Foo", type: nil, correlationId: nil, createdAt: nil, expectReply: nil, ttl: nil)
    given(await commandDispatcher.execute(command: command)).willReturn("Bar")

    let result = try await command.execute(dispatcher: commandDispatcher)

    verify(await commandDispatcher.execute(command: command)).wasCalled()
    XCTAssertEqual(result, "Bar")
  }
}
