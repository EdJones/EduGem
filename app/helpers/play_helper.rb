module PlayHelper

def refresh
  render :update do |page|
    page.replace_html "highScore", :text => session[:current_game].high_score
    page.replace_html "message", :text => ""
    page.replace_html "displayGameTime", :inline => "<%= 'Time: ' + session[:current_game].time_since_start.to_i.to_s  + ' sec'  %>"
  end
end

end
