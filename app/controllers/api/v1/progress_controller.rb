class Api::V1::ProgressController < ApplicationController

  def mark
    #Maybe we can remove these finds if saving TeamChecklist fails if the FK's don't exist
    begin
      team = Team.find(params[:team_id])
      checklist = Checklist.find(params[:checklist_id])
      user = User.find(params[:user_id])
      checked = params[:checked]

      if checked == "true"
        puts "*** checked"
          checklist_present = TeamChecklist.where(:team_id => team.id, :checklist_id => checklist.id).first
          if checklist_present.nil?
            checklist = TeamChecklist.create(:team_id => team.id, :checklist_id => checklist.id, :scribe_id => user.id)
            @response = true
          else
            @response = "warning - already present"
          end
      else
        puts "*** unchecked"
        checklist = TeamChecklist.where(:team_id => team.id, :checklist_id => checklist.id).first
        if (checklist)
          checklist.destroy
          @response = true
        end
      end

    rescue ActiveRecord::RecordNotFound => e
      @response = e.message
    end
  end

end