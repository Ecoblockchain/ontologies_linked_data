require "test/unit"
require "date"
require "json"
require_relative "../../lib/ontologies_linked_data"

class Person
  def initialize(name, age, height = 6)
    @name = name
    @age = age
    @height = height
  end

  def person_is_how_old
    "#{@name} is #{@age}"
  end

  def name_upcase
    @name.upcase
  end

  def relative_age
    if @age < 10
      "young"
    elsif @age < 20
      "teenager"
    elsif @age > 20
      "old"
    end
  end

  def serializable_methods
    [:relative_age, :name_upcase, :person_is_how_old]
  end
end

class TestSerializerXML < Test::Unit::TestCase
  PERSON = Person.new("Simon", 21)
  PEOPLE = [Person.new("Simon", 21), Person.new("Gloria", 28)]
  DATE = DateTime.now

  USER_XML = <<-EOS.gsub(/\s+/, "")
    <user>
      <created>#{DATE.to_s}</created>
      <email>alejandra@example.com</email>
      <username>alejandra</username>
      <roleCollection>
        <role>LIBRARIAN</role>
      </roleCollection>
      <id>http://data.bioontology.org/metadata/user/alejandra</id>
    </user>
  EOS

  USERS_XML = <<-EOS.gsub(/\s+/, "")
    <userCollection>
      <user>
        <created>#{DATE.to_s}</created>
        <email>alejandra@example.com</email>
        <username>alejandra</username>
        <roleCollection>
          <role>LIBRARIAN</role>
        </roleCollection>
        <id>http://data.bioontology.org/metadata/user/alejandra</id>
      </user>
      <user>
        <created>#{DATE.to_s}</created>
        <email>alessandra@example.com</email>
        <username>alessandra</username>
        <roleCollection>
          <role>LIBRARIAN</role>
        </roleCollection>
        <id>http://data.bioontology.org/metadata/user/alessandra</id>
      </user>
      <user>
        <created>#{DATE.to_s}</created>
        <email>amelia@example.com</email>
        <username>amelia</username>
        <roleCollection>
          <role>LIBRARIAN</role>
        </roleCollection>
        <id>http://data.bioontology.org/metadata/user/amelia</id>
      </user>
      <user>
        <created>#{DATE.to_s}</created>
        <email>anderson@example.com</email>
        <username>anderson</username>
        <roleCollection>
          <role>LIBRARIAN</role>
        </roleCollection>
        <id>http://data.bioontology.org/metadata/user/anderson</id>
      </user>
      <user>
        <created>#{DATE.to_s}</created>
        <email>anisa@example.com</email>
        <username>anisa</username>
        <roleCollection>
          <role>LIBRARIAN</role>
        </roleCollection>
        <id>http://data.bioontology.org/metadata/user/anisa</id>
      </user>
      <user>
        <created>#{DATE.to_s}</created>
        <email>arlena@example.com</email>
        <username>arlena</username>
        <roleCollection>
          <role>LIBRARIAN</role>
        </roleCollection>
        <id>http://data.bioontology.org/metadata/user/arlena</id>
      </user>
    </userCollection>
  EOS

  PERSON_XML = <<-EOS.gsub(/\s+/, "")
    <?xml version="1.0" encoding="UTF-8"?>
    <person>
      <name>Simon</name>
      <age>21</age>
      <height>6</height>
    </person>
  EOS

  PEOPLE_XML = <<-EOS.gsub(/\s+/, "")
    <?xml version="1.0" encoding="UTF-8"?>
    <personCollection>
      <person>
        <name>Simon</name>
        <age>21</age>
        <height>6</height>
      </person>
      <person>
        <name>Gloria</name>
        <age>28</age>
        <height>6</height>
      </person>
    </personCollection>
  EOS

  USERS_HASH = {
    :created=>DATE,
    :email=>"alejandra@example.com",
    :username=>"alejandra",
    :role=>["LIBRARIAN"],
    :id=>"http://data.bioontology.org/metadata/user/alejandra"
  }

  USERS_ARRAY = [
   {:created=>DATE,
    :email=>"alejandra@example.com",
    :username=>"alejandra",
    :role=>["LIBRARIAN"],
    :id=>"http://data.bioontology.org/metadata/user/alejandra"},
   {:created=>DATE,
    :email=>"alessandra@example.com",
    :username=>"alessandra",
    :role=>["LIBRARIAN"],
    :id=>"http://data.bioontology.org/metadata/user/alessandra"},
   {:created=>DATE,
    :email=>"amelia@example.com",
    :username=>"amelia",
    :role=>["LIBRARIAN"],
    :id=>"http://data.bioontology.org/metadata/user/amelia"},
   {:created=>DATE,
    :email=>"anderson@example.com",
    :username=>"anderson",
    :role=>["LIBRARIAN"],
    :id=>"http://data.bioontology.org/metadata/user/anderson"},
   {:created=>DATE,
    :email=>"anisa@example.com",
    :username=>"anisa",
    :role=>["LIBRARIAN"],
    :id=>"http://data.bioontology.org/metadata/user/anisa"},
   {:created=>DATE,
    :email=>"arlena@example.com",
    :username=>"arlena",
    :role=>["LIBRARIAN"],
    :id=>"http://data.bioontology.org/metadata/user/arlena"}
  ]

  def test_hash_to_xml
    xml = LinkedData::Serializers::XML.send("convert_hash", USERS_HASH, "user")
    assert_equal xml.to_s.gsub(/\s+/, ""), USER_XML
  end

  def test_array_to_xml
    xml = LinkedData::Serializers::XML.send("convert_array", USERS_ARRAY, "user")
    assert_equal xml.to_s.gsub(/\s+/, ""), USERS_XML
  end

  def test_person_to_xml
    xml = LinkedData::Serializers::XML.serialize(PERSON, {})
    assert_equal xml.to_s.gsub(/\s+/, ""), PERSON_XML
  end

  def test_people_to_xml
    xml = LinkedData::Serializers::XML.serialize(PEOPLE, {})
    assert_equal xml.to_s.gsub(/\s+/, ""), PEOPLE_XML
  end

end