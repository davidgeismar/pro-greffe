module ApplicationHelper

  def phone_link(html_class= "")
    content_tag(:a, href:"tel:#{PhoneGenerator.main_phone_intern}", class: "#{html_class}") do
        PhoneGenerator.main_phone
    end
  end
  def boolean_display(boolean)
    if boolean.nil?
      content_tag(:span, "Non indiqué", class: "btn btn-default btn-xs")
    elsif boolean == true
      content_tag(:span, "Oui", class: "btn btn-success btn-xs")
    else
      content_tag(:span, "Non", class: "btn btn-danger btn-xs")
    end
  end

  # To display euros
  def money_display(value)
    return number_to_currency(value, unit: " €", separator: ",", delimiter: " ", precision: 0, format: "%n %u")
  end

  # To display card in all the site
  def container_card(title, &block)
    content_tag(:div, class: "card card-accent-info") do
      content_tag(:div, class: "card-header") do
        title
      end +
      content_tag(:div, class: "card-block") do
        capture(&block)
      end

    end
  end

  def to_percent(value)
    if value
      return "#{value*100} %"
    else
      return ""
    end
  end

  def helper_card(title = "", &block)
    content_tag(:div, class: "alert alert-info") do
      content_tag(:strong, class: "") do
        title
      end +
      content_tag(:span, class: "") do
        capture(&block)
      end

    end
  end

  def current_url(new_params)
    url_for :params => params.to_unsafe_h.merge(new_params)
  end


end
