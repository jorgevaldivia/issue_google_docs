require "issue_google_docs/version"
require "issue_google_docs/issue"
require "issue_google_docs/document"
require 'gdata'
require 'pp'
require 'nokogiri'

module IssueGoogleDocs

  class Interface

    attr_reader :client

    def initialize(username, password)
      @client = GData::Client::DocList.new
      @client.clientlogin(username, password)
    end

    def get_all_documents
      feed = @client.get('https://docs.google.com/feeds/documents/private/full/-/mine').to_xml
    end

    def create_document(title)
      new_doc = '<?xml version="1.0" encoding="UTF-8"?>'
      new_doc += '<entry xmlns="http://www.w3.org/2005/Atom" xmlns:docs="http://schemas.google.com/docs/2007">'
      new_doc += '<!-- Replace the following line appropriately to create another type of resource. -->'
      new_doc += '<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/docs/2007#document"/>'
      new_doc += "<title>#{title}</title>"
      new_doc += "</entry>"

      @client.post('https://docs.google.com/feeds/documents/private/full/', new_doc.to_s).to_xml

    end

    def get_document(id)
      IssueGoogleDocs::Document.new(self, id)
    end

  end # end interface

end # end module
