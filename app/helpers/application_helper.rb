module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Searchthesales"
    end
  end
end
