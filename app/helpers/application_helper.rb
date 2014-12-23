module ApplicationHelper
  def title(title = nil)
    if title.present?
      content_for :title, title
    else
      content_for?(:title) ? APP_CONFIG['default_title'] + ' | ' + content_for(:title) : APP_CONFIG['default_title']
    end
  end

  def meta_description(desc = nil)
    if desc.present?
      content_for :meta_description, desc
    else
      content_for?(:meta_description) ? content_for(:meta_description) : APP_CONFIG['meta_description']
    end
  end

  def asset_path(file_path)
    if Rails.env.development?
      "http://localhost:8000/" + file_path
    elsif Rails.env.production?
      "https://s3-eu-west-1.amazonaws.com/storeluv/" + file_path
    end
  end

  def link_to(*args, &block)
    if block_given?
      unless args.second && args.second.has_key?(:target)
        args = [(args.first || {}), (args.second || {}).merge(:target => '_self')]
      end
      super(args.first, args.second, block)
    else
      unless args.third && args.third.has_key?(:target)
        args = [(args.first || {}), (args.second || {}), (args.third || {}).merge(:target => '_self')]
      end
      super(args.first, args.second, args.third)
    end
    
  end

end
