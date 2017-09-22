module PicturesHelper
  def years_for_select
    current_year = Time.now.year.to_i
    years = []
    current_year.downto(1) do |year|
      years << year
    end
    years
  end
end
