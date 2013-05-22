require "goo"

# Setup Goo (repo connection and namespaces)
require_relative "ontologies_linked_data/config/config"

# Include other dependent code
require_relative "ontologies_linked_data/security/authorization"
require_relative "ontologies_linked_data/hypermedia/hypermedia"
require_relative "ontologies_linked_data/serializer"
require_relative "ontologies_linked_data/serializers/serializers"
require_relative "ontologies_linked_data/utils/file"
require_relative "ontologies_linked_data/utils/triples"
require_relative "ontologies_linked_data/utils/namespaces"
require_relative "ontologies_linked_data/parser/parser"
require_relative "ontologies_linked_data/monkeypatches/object"
require_relative "ontologies_linked_data/monkeypatches/logging"
require_relative "ontologies_linked_data/sample_data/sample_data"
require_relative "ontologies_linked_data/mappings/mappings"

# Require base model
require_relative "ontologies_linked_data/models/base"

#TODO: TEMPORAL HACK hypermedia links in ontology uses class model.
#      we need to import this one first.
#require_relative "ontologies_linked_data/models/class"

# Require all models
project_root = File.dirname(File.absolute_path(__FILE__))
#Dir.glob(project_root + '/ontologies_linked_data/models/**/*.rb', &method(:require))
require_relative "ontologies_linked_data/models/users/user"
$project_bin = project_root + '/../bin/'
