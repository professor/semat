
json.checklist @checked_checklists.alphas do |json, checklist|
  json.(checklist, :id)
end