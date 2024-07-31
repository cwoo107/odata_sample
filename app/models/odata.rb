class Odata
  def self.process_request(url:, username:, password:)
    require "uri"
    require "net/http"

    @url = url

    url = URI(@url)

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Basic #{Base64.strict_encode64("#{username}:#{password}")}"

    response = https.request(request)
    response.read_body
  end
end