require 'rails_helper'

RSpec.describe Contact, type: :model do
  before(:each) do
    @contact = Contact.new(name: 'Visitante', phone: '42 98898-8877',
                           email: 'visitante@gmail.com', message: 'Olá')
  end

  it 'when valid' do
    expect(@contact).to be_valid
  end

  it 'when have a valid name' do
    @contact.name = ' '
    expect(@contact).not_to be_valid
  end

  it 'accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp]
    valid_addresses.each do |valid_address|
      @contact.email = valid_address
      expect(@contact).to be_valid, "#{valid_address.inspect} should be valid"
    end
  end

  it 'reject invalid addresses' do
    invalid_addresses = %w[user@example,com user.name@example.foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @contact.email = invalid_address
      expect(@contact).not_to be_valid, "#{invalid_address.inspect} should be invalid"
    end
  end

  it 'when have a valid message' do
    @contact.message = ' '
    expect(@contact).not_to be_valid
  end
end
