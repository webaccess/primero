class SuggestedField   < CouchRest::Model::Base
  use_database :suggested_field

  include PrimeroModel

  property :unique_id
  property :name
  property :display_name
  property :help_text
  property :field, Field
  property :is_used, TrueClass

  design do
    view :by_is_used ,
        :map=> "function(doc) {
          if ((doc['couchrest-type'] == 'SuggestedField') ) {
            emit(doc['is_used'], null);
          }
        }"

    # Should unique_id just be the unique id for the record??
    view :by_unique_id

  end

  def self.mark_as_used suggested_field_id
    suggested_field = get_by_unique_id suggested_field_id
    suggested_field.is_used = true
    suggested_field.save
  end
  def self.get_by_unique_id unique_id
    self.by_unique_id(:key=>unique_id).first
  end
  def self.all_unused
    return self.by_is_used(:key=>false)
  end

end
