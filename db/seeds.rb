# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

batches = 500
records_in_batch = 1000

User.set_bcrypt_cost

password = Faker::Internet.password(min_length: 10, max_length: 20, mix_case: true, special_characters: true)
password_digest = BCrypt::Password.create(password)
large_data = "a" * 1024 * 250

(1..batches).each do |current_batch|
  User.transaction do
    records = []
    (1..records_in_batch).each do |_current_record_in_batch|
      email = Faker::Internet.email
      email_hmac = User.hmac email

      records.push({
                     email: email,
                     email_hmac: email_hmac,
                     reset_password_token: Faker::Crypto.sha1,
                     last_name: Faker::Name.last_name,
                     first_name: Faker::Name.first_name,
                     name: Faker::Internet.username,
                     current_sign_in_ip: Faker::Internet.ip_v4_address,

                     skype: Faker::Internet.username,
                     linkedin: Faker::Internet.username,
                     twitter: Faker::Internet.username,

                     failed_attempts: rand(10),

                     reset_password_sent_at: Faker::Date.between(from: 2.years.ago, to: Date.today),
                     current_sign_in_at: Faker::Date.between(from: 2.years.ago, to: Date.today),
                     last_sign_in_at: Faker::Date.between(from: 2.years.ago, to: Date.today),

                     password_digest: password_digest,

                     large_data: large_data.next,
                   })
    end

    ids = User.insert_all records, returning: %w[ id ]

    permission_records = ids.map do |attrs|
      (1..50).map do
        {
          user_id: attrs["id"],
          p1: "a" * 50,
          p2: "b" * 50,
          p3: "c" * 50,
        }
      end
    end.flatten

    settings_records = ids.map do |attrs|
      (1..5).map do
        {
          user_id: attrs["id"],
          s1: "a" * 50,
          s2: "b" * 50,
          s3: "c" * 50,
        }
      end
    end.flatten

    Permission.insert_all permission_records
    Setting.insert_all settings_records

  end

  puts "Batch: #{current_batch}, total: #{current_batch * records_in_batch} users created"
end