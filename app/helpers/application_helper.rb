module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Searchthesales"
    end
  end

  def asset_path(file_path)
    if Rails.env.development?
      "http://localhost:8000/" + file_path
    elsif Rails.env.production?
      "https://s3-eu-west-1.amazonaws.com/storeluv/" + file_path
    end
  end
end
