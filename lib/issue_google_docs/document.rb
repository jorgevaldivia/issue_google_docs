module IssueGoogleDocs
  class Document
    attr :id, true
    attr_reader :interface
    attr_reader :location
    attr_reader :src
    attr_reader :title
    attr_reader :stories

    def initialize(interface, doc_id)
      @interface = interface
      @id = doc_id
      @stories = Array.new

      if !@id.nil?
        get
        get_stories
      end
    end

    def get
      feed = @interface.client.get("https://docs.google.com/feeds/documents/private/full/document%3A#{@id}").to_xml
      @location = feed.elements["id"].text
      @title = feed.elements["title"].text
      @src = feed.elements['content'].attributes['src']
    end

    def download(src)
      @interface.client.get(src)
    end

    def get_stories

      document = self.download(@src)

      html_doc = Nokogiri::HTML(document.body)
      html_doc.css('table').each do |node|
        #puts "#{node.path} -- #{node.class}\n"
        
        if node.css('tbody tr').first.css('td').first.text == "Category"
          
          issue_rows = node.css('tbody tr')
          
          story = nil
          issue_rows[1..-2].each do |issue|
            attributes = issue.css('td')
            type = attributes[0].text.to_s.gsub(':', '') # Get type and remove colon
            description = attributes[1].text
            points = attributes[2].text
            hours = attributes[3].text
            
            issue = IssueGoogleDocs::Issue.new(type, description, points, hours)

            # TODO: handle case
            if type == "Story"
              #if story != nil
              #end
              story = issue
              @stories.push(story)
            else
              story.add_task(issue)
            end

          end
        end
        
      end

    end # end get_stories

  end

end
