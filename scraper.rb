#!/bin/env ruby
# encoding: utf-8

require 'everypolitician'
require 'wikidata/fetcher'

sparq = 'SELECT ?item WHERE { ?item wdt:P39/wdt:P279* wd:Q3272410 }'
members = EveryPolitician::Wikidata.sparql(sparq)
existing = EveryPolitician::Index.new.country("Northern-Ireland").lower_house.popolo.persons.map(&:wikidata).compact

EveryPolitician::Wikidata.scrape_wikidata(ids: existing | members)
