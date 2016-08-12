class Catalog < ActiveRecord::Base
  include Loggable

  belongs_to :organization

  has_many :datasets, dependent: :destroy
  has_many :distributions, through: :datasets

  validates_presence_of :organization_id

  accepts_nested_attributes_for :datasets

  def inventory_datasets
    datasets.where(public_access: true, editable: true).select do |dataset|
      dataset.valid?(:inventory)
    end
  end

  def opening_plan_datasets
    datasets.where(public_access: true, published: true, editable: true)
  end

  def catalog_datasets
    datasets.where(public_access: true, published: true).select do |dataset|
      dataset.valid?(:opening_plan)
    end
  end

  def editable_datasets
    datasets.where(editable: true)
  end

  def non_editable_datasets
    datasets.where(editable: false)
  end
end
