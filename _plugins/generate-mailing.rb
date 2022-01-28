#!/usr/bin/env ruby
require 'securerandom'

module Jekyll
  class Mailing < Page
    def initialize(site, page)
      @site = site
      @page = page
      @name = 'mailing.eml'
      self.process(@name)
      self.read_yaml(File.join(site.source, '_layouts'), 'mailing.html')
      self.data['issue'] = page.basename
      self.data['frontmatter'] = page.data
      self.data['multipart_boundary'] = SecureRandom.hex
      self.data['html_content'] = page.output
    end
  end  
    
  Jekyll::Hooks.register :site, :post_write do |site|
    site.pages.each do |page|
      Jekyll.logger.info "Generating mailing for #{page.path}"
      dest = site.dest + page.dir
      mailing = Mailing.new(site, page)
      mailing.render(site.layouts, site.site_payload)
      mailing.write(dest)
    end
  end  
end