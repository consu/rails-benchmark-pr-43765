# README

Just a little benchmark.

```bash
> bundle
> rails db:create db:migrate db:seed
> rails r scripts/benchmark.rb
```

If you have a lot of time, you can change, the bcrpt costs upto 31,
**BEFORE** you seed the db.

```ruby 
   # within user.rb
   def self.set_bcrypt_cost
    BCrypt::Engine.cost = 31
  end
```

If you choose a larger password, try to create "insert-load"
and let run `rails db:seed` once again during benchmarking.


My benchmark (password = "a", BCrypt::Engine.cost = 12):

|            |user|     system|      total|        real|
|------------|----|-----------|-----------|------------|
|User exists:|266.967539|  33.657878| 300.625417| (373.912028)|
|User does not exists (near misss):|246.400698|   0.432785| 246.833483| (248.315649)|
|User does not exists: |246.625893|   0.425846| 247.051739| (248.542191)|
|User exists (hmac):|262.102862|  32.277677 |294.380539 |(346.124288)|
|User does not exists (near misss, hmac):|246.436053 |  0.455649 |246.891702 |(248.908833)|
|User does not exists (hmac): |246.589072 |  0.513362| 247.102434| (248.726466)|
| total:| 1515.122117|  67.763197| 1582.885314 |(1714.529455)|
| avg:|   252.520353|  11.293866| 263.814219 |(285.754909)|

|              |user|     system|      total|        real|
|--------------|----|-----------|-----------|------------|
|User find: | 261.729682  |32.508771| 294.238453 |(347.748505)|
|User new: |245.734417   |0.286051 |246.020468 |(1029.572272)|
|total: |507.464099 | 32.794822| 540.258921 |(1377.320777)|
|avg:   |253.732050 | 16.397411 |270.129460 |(688.660388)|

