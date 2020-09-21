class Club < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  before_create :set_slug

  has_many :courts
  has_many :matches
  has_many :users

  def clay_courts
    courts.with_surface(Court::CLAY)
  end

  def hard_courts
    courts.with_surface(Court::HARD)
  end

  def grass_courts
    courts.with_surface(Court::GRASS)
  end

  def carpet_courts
    courts.with_surface(Court::CARPET)
  end

  def courts_indoors
    courts.those_indoor
  end

  def courts_with_lights
    courts.with_lights
  end

  def singles_courts
    courts.those_single
  end

  def to_param
    slug
  end

  private

  def set_slug
    self.slug = name.downcase.split(/\W+/).join('-')
  end
end
