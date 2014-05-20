class Organization < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  validates_presence_of :title

  has_many :inventories
  has_many :users

  scope :with_catalog, -> { joins(:inventories).where("inventories.published = 't'") }

  def current_inventory
    inventories.unpublished.first
  end

  def current_catalog
    inventories.published.first
  end

  def last_file_version
    inventories.date_sorted.first
  end

  def old_file_versions
    inventories.date_sorted.offset(1)
  end
end