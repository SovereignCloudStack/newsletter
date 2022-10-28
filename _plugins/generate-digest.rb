#!/usr/bin/env ruby
require 'securerandom'
require 'pathname'

module Jekyll
  class DigestMailing < Document
    def initialize(document, dest)
      @data = document.data
      self.data['layout'] = "digest/mailing"
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

  class DigestRaw < Document
    def initialize(document, dest)
      @data = document.data
      self.data['layout'] = "digest/raw"
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
    mailing = DigestMailing.new(document, dest)
    raw = DigestRaw.new(document, dest)
  end
end
