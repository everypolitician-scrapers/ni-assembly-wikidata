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
  url = 'https://wdq.wmflabs.org/api?q=claim[39:3272410]'
  json = JSON.parse(open(url).read, symbolize_names: true)
  json[:items].map { |id| "Q#{id}" }
end

ids_from_claim('39:3272410').each do |id|
  data = WikiData::Fetcher.new(id: id).data or next
  ScraperWiki.save_sqlite([:id], data)
end
