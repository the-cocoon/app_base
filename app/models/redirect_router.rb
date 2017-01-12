class RedirectRouter < ActiveRecord::Base
  validates :from_url, :to_url, presence: true
  validates :from_url, uniqueness: true
  validate  :infinite_redirection

  private

  def infinite_redirection
    if (from_url == to_url) || self.class.where(to_url: from_url).any?
      errors.add(:to_url, 'Infinite redirection detected')
    end
  end
end
