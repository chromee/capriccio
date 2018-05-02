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
    "Capp"
  end

  def tweet_template
    " ##{app_name} - #{root_url}"
  end

end
