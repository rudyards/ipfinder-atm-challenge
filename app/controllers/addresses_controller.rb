# frozen_string_literal: true

IP_ADDRESS_REGEX = /^((?:(?:^|\.)(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])){4})$/.freeze

require 'net/http'
require 'uri'

# This governs the ip finding and listing endpoints
class AddressesController < ApplicationController
  def find
    ip_address = params['ip']
    if (ip_address =~ IP_ADDRESS_REGEX).nil?
      render json: {error: 'No valid IP Address given'}.to_json
      return false
    end
    if cache_address(ip_address).blank?
      uri = URI.parse("https://get.geojs.io/v1/ip/geo/#{ip_address}.json")
      response = Net::HTTP.get_response(uri)
      cache_address(ip_address, JSON.parse(response.body))
    end
    render json: cache_address(ip_address)
  end

  def show
    ip_addresses = []
    cached_addresses.each do |address|
      if !params['city'].present? && !params['country'].present?
        ip_addresses << session[address]
      elsif params['city'].present? && params['country'].present?
        ip_addresses << session[address] if in_city?(address, params['city']) && in_country?(address, params['country'])
      elsif in_city?(address, params['city'])
        ip_addresses << session[address]
      elsif in_country?(address, params['country'])
        ip_addresses << session[address]
      end
    end
    render json: ip_addresses
  end

  private

  # There are better ways to cache info (Redis or Memcache) if this was a larger scale project
  # In order to be lightweight, I elected to cache addresses in the session
  def cache_address(ip_address, result = nil)
    session["ip #{ip_address}"] = result if result
    session["ip #{ip_address}"]
  end

  def cached_addresses
    ip_addresses = []
    session.keys.each do |key|
      ip_addresses << key if key.include? 'ip '
    end
    ip_addresses
  end

  def in_city?(address, city)
    session[address]['city'] == city.gsub(/[!@%&"]/, '').titleize if city
  end

  def in_country?(address, country)
    session[address]['country'] == country.gsub(/[!@%&"]/, '').titleize if country
  end
end
