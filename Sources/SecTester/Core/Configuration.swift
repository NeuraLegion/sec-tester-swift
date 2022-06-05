import Foundation

class Configuration {
  private let SCHEMA_REGEXP = #"^.+:\/\/"#
  private let CLUSTER_NORMALIZATION_REGEXP = #"^(?!(?:\w+:)?\/\/)|^\/\/"#

  private(set) var bus: String!
  private(set) var api: String!
  private(set) var credentials: Credentials?
  private(set) var credentialProviders: [CredentialProvider]? = [EnvCredentialProvider()]

  init(hostname: String) throws {
    try resolveUrls(hostname: hostname)
  }

  convenience init(hostname: String, credentials: Credentials) throws {
    try self.init(hostname: hostname)
    self.credentials = credentials
  }

  convenience init(hostname: String, credentialProviders: [CredentialProvider]) throws {
    try self.init(hostname: hostname)
    if credentialProviders.isEmpty {
      throw Exception.unexpected("Please provide either credentials or credential providers")
    }

    self.credentialProviders = credentialProviders
  }

  func resolveUrls(hostname: String) throws {
    var hostname = hostname

    if hostname.range(of: SCHEMA_REGEXP, options: .regularExpression) == nil {
      hostname = hostname.replacingOccurrences(
        of: CLUSTER_NORMALIZATION_REGEXP,
        with: "https://",
        options: .regularExpression
      )
    }

    let url = URL(string: hostname)

    guard let hostname = url?.host, !hostname.isEmpty else {
      throw Exception.unexpected("Please make sure that you pass correct 'hostname' option.")
    }

    if hostname == "localhost" || hostname == "127.0.0.1" {
      bus = "amqp://\(hostname):5672"
      api = "http://\(hostname):8000"
    } else {
      bus = "amqps://amq.\(hostname):5672"
      api = "https://\(hostname)"
    }
  }
}
