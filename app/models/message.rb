class Message < ApplicationRecord
  after_create_commit { puts self.to_json }
end
