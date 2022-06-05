enum Exception: Error {
  case eventHandlerNotFound(String)

  case illegalOperation(String)

  case noResponse(String)

  case noSubscriptionsFound(String)

  case unsupportedEventType(String)

  case unexpected(String)
}
