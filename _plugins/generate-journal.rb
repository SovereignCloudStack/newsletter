#!/usr/bin/env ruby
require 'securerandom'
require 'pathname'

module Jekyll
  class JournalMailing < Document
    def initialize(document, dest)
      @data = document.data
      self.data['layout'] = "journal/mailing"
      self.data['issue'] = document.basename_without_ext
      self.data['multipart_boundary'] = SecureRandom.hex
      self.data['html_content'] = document.output
      @renderer = Jekyll::Renderer.new(document.site, document)
      @output = self.renderer.run
      self.write(dest)
    end
    def destination(dest)
      path = Pathname.new(dest) + "mailing.eml"
    end
  end

  class JournalRaw < Document
    def initialize(document, dest)
      @data = document.data
      self.data['layout'] = "journal/raw"
      self.data['issue'] = document.basename_without_ext
      @renderer = Jekyll::Renderer.new(document.site, document)
      @output = self.renderer.run
      self.write(dest)
    end
    def destination(dest)
      path = Pathname.new(dest) + "raw.txt"
    end
  end

  Jekyll::Hooks.register :journal, :post_write do |document|
    dest = Pathname.new(document.site.dest) + document.collection.label + document.basename_without_ext
    mailing = JournalMailing.new(document, dest)
    raw = JournalRaw.new(document, dest)
  end
end
