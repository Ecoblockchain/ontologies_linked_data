require_relative 'details/base'
require_relative '../ontology'
require_relative '../class'

module LinkedData
  module Models
    class Note < LinkedData::Models::Base
      model :note, name_with: :noteId
      attribute :noteId, enforce: [:existence, :unique]
      attribute :creator, enforce: [:existence, :user]
      attribute :created, enforce: [:date_time], :default => lambda { |record| DateTime.now }
      attribute :body
      attribute :subject
      attribute :relatedOntology, enforce: [:list, :ontology]
      attribute :relatedClass, enforce: [:list, :class]
      attribute :createdInSubmission, enforce: [:ontology_submission]
      attribute :details, enforce: [LinkedData::Models::Notes::Details::Base]
    end
  end
end
