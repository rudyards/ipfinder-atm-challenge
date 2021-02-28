# frozen_string_literal: true

require 'rails_helper'

describe AddressesController do
  describe 'GET find' do
    context 'with a valid ip address' do
      it 'should find details for ip address' do
        get :find, params: { ip: '100.0.100.100' }
        expect(response.status).to eq(200)
        expect(response.body).to eq('{"organization_name":"UUNET","region":"Massachusetts","accuracy":5,"asn":701,"organization":"AS701 UUNET","timezone":"America/New_York","longitude":"-71.0712","country_code3":"USA","area_code":"0","ip":"100.0.100.100","city":"Dorchester","country":"United States","continent_code":"NA","country_code":"US","latitude":"42.2904"}')
      end
    end

    context 'with an invalid ip address' do
      it 'should return an error' do
        get :find, params: { ip: '1000.0.100.100' }
        expect(response.status).to eq(200)
        expect(response.body).to eq('{"error":"No valid IP Address given"}')
      end
    end
  end

  describe 'GET show' do
    before do
      get :find, params: { ip: '100.0.100.100' } # Dorchester, MA, USA
      get :find, params: { ip: '129.100.254.153' } # London, Ontario, CAN
      get :find, params: { ip: '51.89.21.57' } # London, England, UK
    end
    context 'without a filter' do
      it 'should return all ip addresses' do
        get :show
        expect(response.status).to eq(200)
        expect(response.body).to eq('[{"organization_name":"UUNET","region":"Massachusetts","accuracy":5,"asn":701,"organization":"AS701 UUNET","timezone":"America/New_York","longitude":"-71.0712","country_code3":"USA","area_code":"0","ip":"100.0.100.100","city":"Dorchester","country":"United States","continent_code":"NA","country_code":"US","latitude":"42.2904"},{"organization_name":"UWO-AS","region":"Ontario","accuracy":10,"asn":823,"organization":"AS823 UWO-AS","timezone":"America/Toronto","longitude":"-81.2602","country_code3":"CAN","area_code":"0","ip":"129.100.254.153","city":"London","country":"Canada","continent_code":"NA","country_code":"CA","latitude":"42.9979"},{"organization_name":"OVH SAS","region":"England","accuracy":500,"asn":16276,"organization":"AS16276 OVH SAS","timezone":"Europe/London","longitude":"-0.0972","country_code3":"GBR","area_code":"0","ip":"51.89.21.57","city":"London","country":"United Kingdom","continent_code":"EU","country_code":"GB","latitude":"51.5096"}]')
      end
    end

    context 'with a filter' do
      it 'should return all matching cities' do
        get :show, params: { city: 'London' }
        expect(response.status).to eq(200)
        expect(response.body).to eq('[{"organization_name":"UWO-AS","region":"Ontario","accuracy":10,"asn":823,"organization":"AS823 UWO-AS","timezone":"America/Toronto","longitude":"-81.2602","country_code3":"CAN","area_code":"0","ip":"129.100.254.153","city":"London","country":"Canada","continent_code":"NA","country_code":"CA","latitude":"42.9979"},{"organization_name":"OVH SAS","region":"England","accuracy":500,"asn":16276,"organization":"AS16276 OVH SAS","timezone":"Europe/London","longitude":"-0.0972","country_code3":"GBR","area_code":"0","ip":"51.89.21.57","city":"London","country":"United Kingdom","continent_code":"EU","country_code":"GB","latitude":"51.5096"}]')
      end
      it 'should return all matching countries' do
        get :show, params: { country: 'United Kingdom' }
        expect(response.status).to eq(200)
        expect(response.body).to eq('[{"organization_name":"OVH SAS","region":"England","accuracy":500,"asn":16276,"organization":"AS16276 OVH SAS","timezone":"Europe/London","longitude":"-0.0972","country_code3":"GBR","area_code":"0","ip":"51.89.21.57","city":"London","country":"United Kingdom","continent_code":"EU","country_code":"GB","latitude":"51.5096"}]')
      end
      it 'should not return non matching cities' do
        get :show, params: { city: 'Derry' }
        expect(response.status).to eq(200)
        expect(response.body).to eq('[]')
      end
    end
  end
end
