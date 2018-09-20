module ApplicationHelper
  
  def bootstrap_class_for(flash_type)
    { success: 'alert-success', error: 'alert-danger', alert: 'alert-warning',
      notice: 'alert-info' }[flash_type.to_sym] || flash_type.to_s
  end 

  def academic_graduated(value)
    if value == false 
      value = 'Não'
    else
      value = 'Sim'  
    end
  end    
end
