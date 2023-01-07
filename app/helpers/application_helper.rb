module ApplicationHelper
  def title
    return t("piazza") unless content_for?(:title)

    "#{content_for(:title)} | #{t("piazza")}"
  end
end
