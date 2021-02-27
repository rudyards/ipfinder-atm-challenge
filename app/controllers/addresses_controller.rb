# frozen_string_literal: true

require 'net/http'
require 'uri'

# This governs the ip finding and listing endpoints
class AddressesController < ApplicationController
  def find
    ip = params['ip']
    unless session_addresses.include?("ip #{ip}")
      uri = URI.parse("https://get.geojs.io/v1/ip/geo/#{ip}.json")
      response = Net::HTTP.get_response(uri)
      hash = JSON.parse response.body
      session["ip #{ip}"] = hash
    end
    render json: session["ip #{ip}"]
  end

  def show
    sessions = []
    session_addresses.each do |address|
      if params['city'].present? && params['country'].present?
        sessions << session[address] if city?(address) && country?(address)
      elsif params['city'].present?
        sessions << session[address] if city?(address)
      elsif params['country'].present?
        sessions << session[address] if country?(address)
      else
        sessions << session[address]
      end
    end
    render json: sessions
  end

  private

  def session_addresses
    ip_addresses = []
    session.keys.each do |key|
      ip_addresses << key if key.include? 'ip '
    end
    ip_addresses
  end

  def city?(address)
    session[address]['city'] == params['city'].gsub(/[!@%&"]/, '')
  end

  def country?(address)
    session[address]['country'] == params['country'].gsub(/[!@%&"]/, '')
  end
end
