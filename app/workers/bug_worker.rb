# BugWorker.perform_async
# BugWorker.perform_in(1.minute)

class BugWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform()
    0/0
  end
end