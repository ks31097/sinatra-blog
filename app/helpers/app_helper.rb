module AppHelper
  def title(title='Blog')
    @title = title
  end

  def footer
    Date.today.year
  end
end
