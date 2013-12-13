require 'rubygems'
require 'rake'
require 'alpha_card_parser'

namespace :semat do

  desc 'Imports an excel document'
  task :import_alpha_cards => :environment  do |t, args|
#    AlphaCardParser.import("./lib/simple.xlsx", "Simple")
    AlphaCardParser.import("./lib/SEMAT_Alpha_Cards_OMG_1.0.xlsx", "OMG 1.0")
    AlphaCardParser.import("./lib/SEMAT_Alpha_Cards_Printed_Cards.xlsx", "Printed Cards 1.0")
  end

end


# Clean up accidental run of parser
# sql = "DELETE from CHECKLISTS where created_at > '2013-12-11'"
# ActiveRecord::Base.connection.execute sql
# sql = "DELETE from STATES where created_at > '2013-12-11'"
# ActiveRecord::Base.connection.execute sql
# sql = "DELETE from ALPHAS where created_at > '2013-12-11'"
# ActiveRecord::Base.connection.execute sql
# sql = "DELETE from ESSENCE_VERSIONS where created_at > '2013-12-11'"
# ActiveRecord::Base.connection.execute sql
