module ApplicationHelper

  def full_title(page_title = '')
    base_title = app_name
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def app_name
    "Capriccio"
  end

  def tweet_template
    " #{root_url}"
  end

  def is_development
    Rails.env == "development"
  end

end
