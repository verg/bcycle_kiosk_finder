module LocationsHelper
  def distance_in_words(start, finish)
    "#{start.distance_from(finish).round(1)} mi"
  end
end
