module Rubypress
  module XMLRPCRetryable
    include Retryable

    RETRY_EXCEPTIONS = [
      Timeout::Error,
      Net::ReadTimeout
    ]

    def self.extended(instance)
      instance.singleton_class.send(:alias_method, :call_without_retry, :call)
      instance.singleton_class.send(:alias_method, :call, :call_with_retry)
    end

    def call_with_retry(method, *args)
      retryable on: RETRY_EXCEPTIONS do
        call_without_retry(method, *args)
      end
    end
  end
end
