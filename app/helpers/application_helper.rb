module ApplicationHelper
  def  page_attributes
    @page_data_attributes if @page_data_attributes.present?
  end
 
  def page_data(options = {})
    @page_data_attributes ||= {}
    @page_data_attributes.merge!(options)
  end
end
