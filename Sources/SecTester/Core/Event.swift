import Foundation

class Event<TPayload>: Message<TPayload> {
  override init(payload: TPayload, type: String?, correlationId: String?, createdAt: Date?) {
    super.init(payload: payload, type: type, correlationId: correlationId, createdAt: createdAt)
  }

  func publish(dispatcher: EventDispatcher) async throws {
    try await dispatcher.publish(event: self)
  }
}
