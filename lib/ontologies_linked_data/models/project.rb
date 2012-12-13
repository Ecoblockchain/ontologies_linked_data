module LinkedData
  module Models
    class Project < LinkedData::Models::Base
      model :project
      attribute :creator, :cardinality => { :max => 1, :min => 1 }
      attribute :created, :date_time_xsd => true, :cardinality => { :max => 1, :min => 1 }
      attribute :name, :cardinality => { :max => 1, :min => 1 }
      attribute :homePage, :cardinality => { :max => 1, :min => 1 }
      attribute :description, :cardinality => { :max => 1, :min => 1 }
      attribute :contacts, :cardinality => { :max => 1 }
      attribute :ontologyUsed, :instance_of => { :with => :ontology }, :cardinality => { :min => 1 }
    end
  end
end
