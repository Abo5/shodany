# lib/shodany/error.rb

module Shodany
    # General error for all exceptions in Shodany
    class Error < StandardError; end
  
    # Error raised when there is a network or connection problem
    class NetworkError < Error; end
  
    # Error raised when the response from the API is unexpected or invalid
    class InvalidResponseError < Error; end
  
    # Error raised when the requested resource is not found
    class NotFoundError < Error; end

    # api token missing
    class MissingApiKeyError < Error; end
end
  