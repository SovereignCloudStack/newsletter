#!/usr/bin/env ruby
require 'securerandom'
require 'pathname'

module Jekyll
  class Mailing < Document
    def initialize(document, dest)
      @data = document.data
      self.data['layout'] = "mailing"
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
  
  class Raw < Document
    def initialize(document, dest)
      @data = document.data
      self.data['layout'] = "raw"
      self.data['issue'] = document.basename_without_ext
      @renderer = Jekyll::Renderer.new(document.site, document)
      @output = self.renderer.run
      self.write(dest)
    end
    def destination(dest)
      path = Pathname.new(dest) + "raw.txt"
    end
  end
    
  Jekyll::Hooks.register :digest, :post_write do |document|
    dest = Pathname.new(document.site.dest) + document.collection.label + document.basename_without_ext
    mailing = Mailing.new(document, dest)
    raw = Raw.new(document, dest)
  end  
end