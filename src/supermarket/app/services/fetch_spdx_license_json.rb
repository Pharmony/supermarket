class FetchSpdxLicenseJson

  def self.spdx_license_json
    response = JSON(Net::HTTP.get(URI(ENV["SPDX_LICENSE_URL"])))
    response["licenses"]
  rescue StandardError => e
    [:error, e]
  end

end