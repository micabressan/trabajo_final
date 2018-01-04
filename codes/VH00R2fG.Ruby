def with_retry(tries_count)
      return unless block_given?

      tries ||= tries_count

      raise StandardError unless yield
    rescue StandardError => error
      retry if (tries -= 1) > 0

      Rollbar.error(error, error.message)
    end