# TestWorker.perform_async
# TestWorker.perform_in(1.minute)

class TestWorker
  include Sidekiq::Worker

  # sidekiq_options retry: 5
  # sidekiq_options retry: false

  def perform()
    2 + 2
  end
end