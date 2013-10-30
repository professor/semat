require 'rubygems'
require 'rake'
require 'alpha_card_parser'

namespace :semat do

  desc 'Imports an excel document'
  task :import_alpha_cards => :environment  do |t, args|
    AlphaCardParser.import
  end

end