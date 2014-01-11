class SnapshotMailer < ActionMailer::Base
  default from: "semat.tool@sv.cmu.edu", bcc: "semat.tool@sv.cmu.edu"

  def summary(snapshot)
    @snapshot = snapshot
    @essence_version = snapshot.team.essence_version
    emails = snapshot.team.members.collect(&:email).join(",")
    mail(to: emails,
         subject: "Summary of team " + snapshot.team.name + " meeting on " + snapshot.updated_at.to_s)
  end

end
