class UpdateCount
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    secondly(5)
  end

  def perform
    counts = Count.where(is_modify:false)
    unless counts.blank?
      counts.each do |count|
        count.update(refresh_time:Time.now,is_modify:true)
      end
    end
  end
end