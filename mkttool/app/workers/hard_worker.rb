  require 'blog'
  require 'posthandler'
  require 'anemone'
  require 'nokogiri'
  require 'boilerpipe'
  require 'socialcount'
  include PostHandler
class HardWorker
  @queue = :search_queue
  
  def self.perform(name)
    
    category_filter = /category/
    author_filter = /author/
    tag_filter = /tag/
    pictures_filter = /pictures/
    images_filter = /images/
    contributors_filter = /contributors/
    feed_filter = /feed/
    rss_filter = /rss/
    page_filter = /page/
    images_extensions = %r{\.(gif|jpe?g|png)\z}i
    
    Blog.create(:name => "#{name}")
    @blog_id = Blog.find_by(name: name)
    
    puts @blog_id[:_id]
    Anemone.crawl(name) do |anemone|
      anemone.on_every_page do |page|
        if not page.nil? && page.not_found?
          if (page.code >= 200 && page.code < 400)
              page_url_string = page.url.to_s
              if page_url_string != name && page_url_string !~ category_filter && page_url_string !~ tag_filter && page_url_string !~ pictures_filter && page_url_string !~ images_filter && page_url_string !~ rss_filter && page_url_string !~ feed_filter && page_url_string !~ author_filter && page_url_string !~ contributors_filter && page_url_string !~ page_filter && page_url_string !~ images_extensions
                result = Boilerpipe.extract(page.url, {:output => :htmlFragment, :extractor => :ArticleExtractor})
                if result.size > 100
                  doc = Nokogiri::HTML.parse(result)
                  style = PostHandler.post_style(doc) #The blog structure/pattern
                  remove_fields(doc)
                  @words = words_counter(doc, style)
                  if(@words > 400)
                    @links = links_counter(doc, style)
                    @headings = headings_counter(doc, style)
                    stats = SocialCount.new    
                    post_stats = stats.query(page_url_string)
                    if not post_stats.nil?
                      Post.create(:blog_id => String.new(@blog_id[:_id]), :name => page.url.to_s, :words => @words, :links => @links, :headings => @headings, :fb => post_stats['facebook']['total_count'], :twitter => post_stats['twitter'], :linkedin => post_stats['linkedin'])
                    else
                      next
                    end
                  end
                end
              end
          else
            next
          end
        end
      end
    end
    rescue Resque::DirtyExit
      Resque.enqueue(HardWorker, name)
      
  end  
end