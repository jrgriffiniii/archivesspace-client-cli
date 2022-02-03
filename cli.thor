require 'archivesspace/client'

class Aspace < Thor
  desc "get_resource_marc21_xml", "request an XML representation of resource metadata"
  def get_resource_marc21_xml
    client.login

    response = client.get("/repositories/4/resources/marc21/2065.xml")
    marc_document = Nokogiri::XML(response.body)
    say(marc_document.to_xml)
  end

  no_tasks do
    def base_uri
      ENV["ASPACE_BASE_URI"]
    end

    def username
      ENV["ASPACE_USERNAME"]
    end

    def password
      ENV["ASPACE_PASSWORD"]
    end

    def config
      @config ||= ArchivesSpace::Configuration.new({
        base_uri: base_uri,
        base_repo: "",
        username: username,
        password: password,
        #page_size: 50,
        #throttle: 0,
        #verify_ssl: false,
      })
    end

    def client
      @client ||= ArchivesSpace::Client.new(config)
    end
  end
end
