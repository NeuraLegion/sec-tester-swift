import Foundation

class Credentials {
  private let TOKEN_VALIDATION_REGEXP = #"^[A-Za-z0-9+/=]{7}\.nex[apr]\.[A-Za-z0-9+/=]{32}$"#

  private(set) var token: String

  init(token: String) throws {
    if token.range(of: TOKEN_VALIDATION_REGEXP, options: .regularExpression) == nil {
      throw Exception.unexpected("Unable to recognize the API key.")
    }

    self.token = token
  }
}
