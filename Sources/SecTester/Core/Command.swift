import Foundation

class Command<TPayload, TReturn>: Message<TPayload> {
  private(set) var expectReply: Bool? = true
  private(set) var ttl: Int? = 10000

  init(payload: TPayload, type: String?, correlationId: String?, createdAt: Date?, expectReply: Bool?, ttl: Int?) {
    self.expectReply = expectReply
    self.ttl = ttl != nil && ttl! > 0 ? ttl : nil
    super.init(payload: payload, type: type, correlationId: correlationId, createdAt: createdAt)
  }

  func execute(dispatcher: CommandDispatcher) async throws -> TReturn? {
    return try await dispatcher.execute(command: self)
  }
}
