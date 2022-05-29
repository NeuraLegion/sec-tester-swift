import Foundation

class Message<T> {
  private(set) var type: String
  private(set) var payload: T
  private(set) var correlationId: String
  private(set) var createdAt: Date

  init(payload: T, type: String?, correlationId: String?, createdAt: Date?) {
    self.payload = payload
    self.type = type ?? "\(Swift.type(of: self))".replacingOccurrences(
      of: #"<.+>"#,
      with: "",
      options: .regularExpression
    )
    self.correlationId = correlationId ?? UUID().uuidString
    self.createdAt = createdAt ?? Date()
  }
}
