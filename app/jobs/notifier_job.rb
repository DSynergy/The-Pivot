class NotifierJob < ActiveJob::Base
  queue_as :default
end
