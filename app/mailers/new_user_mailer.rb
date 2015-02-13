class NewUserMailer

  def initialize(user)
    @mg_client = Mailgun::Client.new(ENV['MAILGUN_API_KEY'])
    @html =  render_anywhere('mailgun_templates/welcome', {:email => user.email}).to_str
    @params = {
      :from    => "Bertie Wilson <customercare@fetchmyfashion.com>",
      :to      => user.email,
      :subject => 'Welcome to Fetch My Fashion!',
      :text    => 'Welcome to Fetch My Fashion!', 
      :html    => @html
    }
  end

  def render_anywhere(partial, assigns = {})
    view = ActionView::Base.new(ActionController::Base.view_paths, assigns)
    view.extend ApplicationHelper
    view.render(:partial => partial)
  end

  def deliver
    @mg_client.send_message("mg.fetchmyfashion.com", @params)
  end 

end