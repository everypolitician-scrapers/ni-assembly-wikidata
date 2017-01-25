#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

sparq = 'SELECT ?item WHERE { ?item wdt:P463 wd:%s . }'
terms = %w(Q21128140 Q21128144 Q21128152 Q21124329 Q24050037)
ids = terms.map { |id| EveryPolitician::Wikidata.sparql(sparq % id) }.reduce(:|)

names = WikiData::Category.new('Category:Northern Ireland MLAs 2016–2017', 'en').member_titles

EveryPolitician::Wikidata.scrape_wikidata(ids: ids, names: { en: names })

