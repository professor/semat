require 'rubygems'
require 'rake'
require 'JSON'

namespace :semat do

  desc 'Exports data for a team'
  task :export_team_data => :environment  do |t, args|
    team_ids = [21, 26, 108, 121, 124, 143, 148]
    team_ids.each do |id|
      team = Team.find(id)
      generate_json_for_meetings(team)
      generate_json_for_deltas(team)
    end
  end

  def generate_json_for_meetings(team)
    data = []
    team.snapshots.each do |snapshot|
      hash = snapshot.checklist_ids_hash
      data << hash unless hash == {}
    end
    json_string = JSON.generate(data)
    File.write(File.expand_path("../../generated_json/team_#{team.id}_weekly.json", __FILE__), json_string)
  end

  def generate_json_for_deltas(team)
    delta_meetings = team.delta_array_of_checklists.delete_if {|item| item == {}}
    json_string = delta_meetings.to_json
    File.write(File.expand_path("../../generated_json/team_#{team.id}_deltas.json", __FILE__), json_string)
  end
end
