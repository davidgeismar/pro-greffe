# Class that will deliver the sitemap in our domain name.
class SitemapController < ApplicationController
  
  def show
    data = open("https://s3-eu-west-1.amazonaws.com/greffe-sans-frais/sitemaps/sitemap.xml.gz")
    send_data data.read, :type => data.content_type
  end
end
