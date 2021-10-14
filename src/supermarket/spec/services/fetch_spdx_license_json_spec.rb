require "spec_helper"
require "webmock/rspec"

describe FetchSpdxLicenseJson do
  let(:fetch_spdx) { FetchSpdxLicenseJson.new }
  let(:sample_response) do
    {
      "licenseListVersion": "fafa781",
      "licenses": [
        {
          "reference": "https://spdx.org/licenses/eGenix.html",
          "isDeprecatedLicenseId": false,
          "detailsUrl": "https://spdx.org/licenses/eGenix.json",
          "referenceNumber": 0,
          "name": "eGenix.com Public License 1.1.0",
          "licenseId": "eGenix",
          "seeAlso": [
            "http://www.egenix.com/products/eGenix.com-Public-License-1.1.0.pdf",
            "https://fedoraproject.org/wiki/Licensing/eGenix.com_Public_License_1.1.0",
          ],
          "isOsiApproved": false,
        },
      ],
    }
  end

  context "makes a call to json url " do
    before :each do
      ENV["SPDX_LICENSE_URL"] = "https://raw.githubusercontent.com/spdx/license-list-data/master/json/licenses.json"

      stub_request(:get, ENV["SPDX_LICENSE_URL"])
        .to_return(status: 200, body: sample_response.to_json, headers: {})
    end

    it "returns license data which is not nil" do
      expect(FetchSpdxLicenseJson.spdx_license_json).not_to be_nil
    end

    it "returns correct license data as received as response" do
      expect(FetchSpdxLicenseJson.spdx_license_json[0]["reference"]).to eql("https://spdx.org/licenses/eGenix.html")
      expect(FetchSpdxLicenseJson.spdx_license_json[0]["detailsUrl"]).to eql("https://spdx.org/licenses/eGenix.json")
    end
  end

end