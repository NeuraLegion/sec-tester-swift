import Foundation

protocol EventDispatcher {
  func publish<TPayload>(event: Event<TPayload>) async throws
}
