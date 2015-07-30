#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require 'wikidata/fetcher'

@pages = [
  'Category:Northern Ireland MLAs 2011–',
  'Category:Northern Ireland MLAs 2007–11',
  'Category:Northern Ireland MLAs 2003–07',
  'Category:Northern Ireland MLAs 1998–2003',
]

@pages.map { |c| WikiData::Category.new(c).wikidata_ids }.flatten.uniq.each do |id|
  data = WikiData::Fetcher.new(id: id).data or next
  ScraperWiki.save_sqlite([:id], data)
end
