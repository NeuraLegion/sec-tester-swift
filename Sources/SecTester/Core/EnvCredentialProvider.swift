import Foundation

class EnvCredentialProvider: CredentialProvider {
  private let env: [String: String]

  init(_ env: [String: String] = ProcessInfo.processInfo.environment) {
    self.env = env
  }

  func get() async throws -> Credentials? {
    if let token = env["BRIGHT_TOKEN"] {
      return try Credentials(token: token)
    }

    return nil
  }
}
