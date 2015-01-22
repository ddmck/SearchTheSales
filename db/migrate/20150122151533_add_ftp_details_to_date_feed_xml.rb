class AddFtpDetailsToDateFeedXml < ActiveRecord::Migration
  def change
    add_column :data_feed_xmls, :host, :string
    add_column :data_feed_xmls, :user_name, :string
    add_column :data_feed_xmls, :password, :string
  end
end
