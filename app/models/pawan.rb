require 'couchrest'
server = CouchRest.new
db = server.database!(' primero_form_section_development    ')
doc = db.get('0824c73de7eb0c40eeca719be27b23b2')
puts doc.inspect