#!/bin/env ruby
# encoding: utf-8

require 'colorize'
require 'nokogiri'
require 'pry'
require 'scraperwiki'
require 'wikidata/fetcher'

require 'open-uri/cached'
OpenURI::Cache.cache_path = '.cache'

def ids_from_claim(claim_str)
  url = 'https://wdq.wmflabs.org/api?q=%s' % claim_str
  json = JSON.parse(open(url).read, symbolize_names: true)
  json[:items].map { |id| "Q#{id}" }
end

terms = %w(Q21128140 Q21128144 Q21128152 Q21124329)
claim = terms.map { |t| "claim[463:%d]" % t.sub('Q','').to_i }.join('+OR+')

ids_from_claim(claim).each do |id|
  data = WikiData::Fetcher.new(id: id).data or next
  ScraperWiki.save_sqlite([:id], data)
end
