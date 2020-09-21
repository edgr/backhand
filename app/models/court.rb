class Court < ApplicationRecord
  CLAY = "Clay".freeze
  HARD = "Hard".freeze
  GRASS = "Grass".freeze
  CARPET = "Carpet".freeze

  ALL_SURFACES = [CLAY, HARD, GRASS, CARPET]

  belongs_to :club, optional: true

  scope :those_indoor, -> { where(indoor: true) }
  scope :those_single, -> { where(single: true) }
  scope :with_lights, -> { where(lights: true) }
  scope :with_surface, ->(surface_type) { where(surface: surface_type) }
end
