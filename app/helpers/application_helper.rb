module ApplicationHelper
    def format_date(date)
      date.strftime("%Y/%m/%d") if date.present?
    end
  
    def format_datetime(datetime)
      datetime.strftime("%Y/%m/%d %H:%M") if datetime.present?
    end
  end