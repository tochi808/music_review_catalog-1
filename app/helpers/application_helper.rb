module ApplicationHelper
  
  def login_notice_message
    if flash[:notice] then
      content_tag :div, flash[:notice], :class => "label label-info"
    end
  end 

  def login_alert_message
    if flash[:alert] then
      content_tag :div, flash[:alert], :class => "label label-warning"
    end
  end
end
