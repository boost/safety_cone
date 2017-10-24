module SafetyCone
  # Module for Filtering requests and raise notices
  # and take measures
  module Helper
    def safetycone_notice
      flash[:safetycone_notice]
    end

    def safetycone_alert
      flash[:safetycone_alert]
    end
  end
end

ActionView::Base.send :include, SafetyCone::Helper
