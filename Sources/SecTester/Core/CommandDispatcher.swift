import Foundation

protocol CommandDispatcher {
  func execute<TPayload, TReturn>(command: Command<TPayload, TReturn>) async throws -> TReturn?
}
