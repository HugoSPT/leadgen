module PostHandler    
  def post_style(doc)
    if not doc.search('article').empty?
      return 'article'
    elsif not doc.search('.entry-content').empty?
        return '.entry-content'
    elsif not doc.search('.post-body').empty?
        return '.post-body'
    end
    return ''
  end
  
  def words_counter(doc, style)
    @words = 0
    if not style.empty?
      doc.search(style).map do |nodes|
        if not nodes.search('p').empty?
          doc.search('p').map do |node|
            string = node.inner_text
            length = node.inner_text.split(' ').length
            @words += length
          end
        else
            string = nodes.inner_text
            length = nodes.inner_text.split(' ').length
            @words += length
        end
      end
    else
      doc.search('p').map do |nodes|
        string = nodes.inner_text
        length = nodes.inner_text.split(' ').length
        @words += length
      end
    end
    return @words
  end
  
  def links_counter(doc, style)
    @links = 0
    if not style.empty?
      doc.search(style).map do |n|
        n.search('a').map do |a|
          @links += 1
        end
      end
    else
      doc.search('a').map do |a|
        @links += 1
      end
    end
    return @links
  end
    
  def headings_counter(doc, style)
    @headings = 0
    if not style.empty?
      doc.search(style).map do |nodes|
        nodes.search('h1, h2, h3, h4, h5, h6').map do |headings|
          @headings+= 1
        end
      end
    else
      doc.search('h1, h2, h3, h4, h5, h6').map do |headings|
        @headings+= 1
      end
    end
    return @headings
  end
  
  def remove_fields(doc)
    doc.xpath("//*[contains(@class, 'comment')]").each do |comment|
      if not comment.content.empty?
        comment.child.remove
      end
    end
    doc.xpath("//*[contains(@id, 'comment')]").each do |comment|
      if not comment.content.empty?
        comment.child.remove
      end
    end          
    doc.xpath("//*[contains(@class, 'head')]").each do |header|
      if not header.content.empty?
        header.child.remove
      end
    end          
    doc.xpath("//*[contains(@id, 'head')]").each do |header|
      if not header.content.empty?
        header.child.remove
      end
    end
    doc.xpath("//footer").each do |footer|
      if not footer.content.empty?
        footer.child.remove
      end
    end
    doc.xpath("//*[contains(@class, 'foot')]").each do |footer|
      if not footer.content.empty?
        footer.child.remove
      end
    end
    doc.xpath("//*[contains(@id, 'foot')]").each do |footer|
      if not footer.content.empty?
        footer.child.remove
      end
    end
  end
end