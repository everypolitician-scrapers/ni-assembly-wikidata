#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

terms = %w(Q21128140 Q21128144 Q21128152 Q21124329 Q24050037)
claim = terms.map { |t| "claim[463:%d]" % t.sub('Q','').to_i }.join(' OR ')
ids = EveryPolitician::Wikidata.wdq(claim)

names = WikiData::Category.new('Category:Northern Ireland MLAs 2016–', 'en').member_titles

EveryPolitician::Wikidata.scrape_wikidata(ids: ids, names: { en: names }, output: false)

