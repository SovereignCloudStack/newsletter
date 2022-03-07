#!/usr/bin/env ruby
require 'securerandom'

module Jekyll
  class RawView < Page
    def initialize(site, page)
      @site = site
      @page = page
      @name = 'raw.txt'
      self.process(@name)
      self.read_yaml(File.join(site.source, '_layouts'), 'raw.html')
      self.data['frontmatter'] = page.data
      self.data['html_content'] = page.output
    end
  end  
    
  Jekyll::Hooks.register :site, :post_write do |site|
    site.pages.each do |page|
      Jekyll.logger.info "Generating raw view for #{page.path}"
      dest = site.dest + page.dir
      rawview = RawView.new(site, page)
      rawview.render(site.layouts, site.site_payload)
      rawview.write(dest)
    end
  end  
end