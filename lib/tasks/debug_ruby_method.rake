require 'rubygems'
require 'rake'
require 'new_cards_analysis_parser'

namespace :semat do

  desc 'Allows us to have rubymine debugger have at a ruby method'
  task :debug_ruby_method => :environment  do |t, args|
    NewCardsAnalysisParser.import("./lib/SEMAT_New_Cards_Analysis.xlsx", "./lib/SEMAT_New_Cards_Analysis.tsv")
  end

end
