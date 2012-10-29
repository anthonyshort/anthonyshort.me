xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  xml.title "Anthony Short"
  xml.subtitle "Designer and Frond-End Developer"
  xml.id "http://anthonyshort.me/"
  xml.link "href" => "http://anthonyshort.me/"
  xml.link "href" => "http://anthonyshort.me/feed.xml", "rel" => "self"
  xml.updated data.blog.articles.first.date.to_time.iso8601
  xml.author { xml.name "Anthony Short" }

  data.blog.articles.each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => article.url.sub('.html','')
      xml.id article.url
      xml.published article.date.to_time.iso8601
      xml.updated article.date.to_time.iso8601
      xml.author { xml.name "Anthony Short" }
      xml.summary article.summary, "type" => "html"
      xml.content article.body, "type" => "html"
    end
  end
end

