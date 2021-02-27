# frozen_string_literal: true

require 'spec_helper'

describe AddressesController do
  describe '#find' do
    context 'with a valid ip address' do
      it 'should find a new ip address if there is no existing one' do
        get :find, { ip: '100.0.100.100' }
      end
      it 'should return existing ip address if one is present' do
        get :find, { ip: '100.0.100.100' }
      end
    end

    context 'with an invalid ip address' do
      it 'should return an error' do
        get :find, { ip: '1000.0.100.100' }
      end
    end
  end

  describe '#show' do
    context 'without a filter' do
      it 'should return all ip addresses' do
        get :show
      end
    end

    context 'with a filter' do
      it 'should return all matching cities' do
        get :show, { city: 'Leicester' }
      end
      it 'should return all matching countries' do
        get :show, { country: 'United Kingdom' }
      end
      it 'should not return non matching cities' do
        get :show, { city: 'Derry' }
      end
    end
  end
end
