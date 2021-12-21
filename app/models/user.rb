class User < ApplicationRecord
  has_secure_password

  def self.set_bcrypt_cost
    BCrypt::Engine.cost = 12
  end

  def self.hmac(data)
    secret = "12345678"
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), secret, data)
  end

  def self.authenticate_by(attributes)
    passwords = attributes.select { |name, value| !has_attribute?(name) && has_attribute?("#{name}_digest") }

    raise ArgumentError, "One or more password arguments are required" if passwords.empty?
    raise ArgumentError, "One or more finder arguments are required" if passwords.size == attributes.size

    if record = find_by(attributes.except(*passwords.keys))
      Rails.logger.info "user found"
      record if passwords.count { |name, value| record.public_send(:"authenticate_#{name}", value) } == passwords.size
    else
      Rails.logger.info "user missing"
      new(passwords)
      nil
    end
  end
end
