import Foundation

protocol CredentialProvider {
  func get() async throws -> Credentials?
}
