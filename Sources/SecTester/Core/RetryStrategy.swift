import Foundation

protocol RetryStrategy {
  func acquire<R>(task: (_ args: Any ...) async throws -> R) async rethrows -> R?
}
