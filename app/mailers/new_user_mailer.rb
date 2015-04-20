class NewUserMailer

  def initialize(user)
    @mg_client = Mailgunner::Client.new()

    if user.fetch_my_fashion
      @html =  render_anywhere('mailgun_templates/fetchmyfashion/welcome', {:email => user.email}).to_str
      @params = {
        :from    => "Bertie Wilson <customercare@fetchmyfashion.com>",
        :to      => user.email,
        :subject => 'Welcome to Fetch My Fashion!',
        :text    => 'Welcome to Fetch My Fashion!', 
        :html    => @html
      }
    else
      @html =  render_anywhere('mailgun_templates/searchthesales/welcome', {:email => user.email}).to_str
      @params = {
        :from    => "Bertie Wilson <customercare@searchthesales.com>",
        :to      => user.email,
        :subject => 'Welcome to Search The Sales!',
        :text    => 'Welcome to Search The Sales!', 
        :html    => @html
      }
    end
  end

  def render_anywhere(partial, assigns = {})
    view = ActionView::Base.new(ActionController::Base.view_paths, assigns)
    view.extend ApplicationHelper
    view.render(:partial => partial)
  end

  def deliver
    @mg_client.send_message(@params)
  end 

end