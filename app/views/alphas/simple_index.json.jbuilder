
json.(@version, :id, :name)

json.alphas @version.alphas do |json, alpha|
  json.(alpha, :id, :name, :color) #, :definition, :description
  json.states alpha.states do |json, state|
      json.(state, :id, :name)
      json.checklists  state.checklists, :id, :name
  end
end