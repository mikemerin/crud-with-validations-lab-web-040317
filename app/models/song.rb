class Song < ActiveRecord::Base

  validates :title,
    presence: {
      scope: true,
      message: "You must enter a title." },
    uniqueness: {
      scope: [:release_year, :artist_name],
      message: "You cannot have a repeating song from an artist in the same released year." }

  validates :released, inclusion: { in: [true, false] }

  with_options if: :released? do |song|

    song.validates :release_year,
      presence: {
        scope: true,
        message: "If song is released, you must enter a release year." },
      numericality: { less_than_or_equal_to: Date.today.year }

  end

  # with_options unless: :released? do |song|
  #
  #   song.validates :release_year,
  #     presence: {
  #       scope: false,
  #       message: "Cannot enter a release year unless song is released." }
  #
  # end

  validates :artist_name,
    presence: {
      scope: true,
      message: "You must enter an artist name." }

  # def not_future_date?
  #   if self.release_year > Date.today.year
  #     errors.add(:release_year, "Can't be a future date.")
  #   end
  # end

end
