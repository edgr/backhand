class Club < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  before_create :set_slug

  has_many :users
  has_many :matches
  has_many :courts

  def clay_courts
    self.courts.find_all { |court| court.surface == "Clay" }
  end

  def hard_courts
    self.courts.find_all { |court| court.surface == "Hard" }
  end

  def grass_courts
    self.courts.find_all { |court| court.surface == "Grass" }
  end

  def carpet_courts
    self.courts.find_all { |court| court.surface == "Carpet" }
  end

  def courts_indoors
    self.courts.find_all { |court| court.indoor == true }
  end

  def courts_with_lights
    self.courts.find_all { |court| court.lights == true }
  end

  def singles_courts
    self.courts.find_all { |court| court.single == true }
  end

  def to_param
    slug
  end

  private

  def set_slug
    self.slug = name.downcase.split(/\W+/).join('-')
  end
end
