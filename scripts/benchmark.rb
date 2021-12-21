include Benchmark


User.set_bcrypt_cost

existing_email = User.order(Arel.sql('RANDOM()')).pluck(:email).first
password = ""
near_miss_email = existing_email.next
missing_email = "z000000000000000000000000000000000000000000000000000000000000000"

n = 1000
Benchmark.benchmark(CAPTION, 7, FORMAT, ">total:", ">avg:") do |x|
  results = []
  results.push x.report("User exists:") { n.times do   User.authenticate_by(email: existing_email, password: password) end }
  results.push x.report("User does not exists (near misss):") { n.times do   User.authenticate_by(email: near_miss_email, password: password) end }
  results.push x.report("User does not exists:") { n.times do   User.authenticate_by(email: missing_email, password: password) end }

  results.push x.report("User exists (hmac):") { n.times do   User.authenticate_by(email_hmac: User.hmac(existing_email), password: password) end }
  results.push x.report("User does not exists (near misss, hmac):") { n.times do   User.authenticate_by(email: User.hmac(near_miss_email), password: password) end }
  results.push x.report("User does not exists (hmac):") { n.times do   User.authenticate_by(email: User.hmac(missing_email), password: password) end }

  [results.sum, results.sum/results.size]
end

Benchmark.benchmark(CAPTION, 7, FORMAT, ">total:", ">avg:") do |x|
  results = []
  results.push x.report("User find:") { n.times do   User.where(email: existing_email).first.authenticate_password(password) end }
  results.push x.report("User new:") { n.times do   User.new({email: near_miss_email, password: password}) end }

  [results.sum, results.sum/results.size]
end