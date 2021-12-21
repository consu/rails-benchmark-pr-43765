# README

Just a little benchmark.
This benchmark uses postgresql & a btree index.
btree seems to [leak](https://dba.stackexchange.com/questions/285739/prevent-timing-attacks-in-postgres) informations, so I used it for a faster demo



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

The "attack"-password-length is also important within `script/benchmark.rb.
It seems like the shorter the password, the larger the timediff.

If you choose a larger password, try to create "insert-load"
and let run `rails db:seed` once again during benchmarking.


My benchmark (password = "", BCrypt::Engine.cost = 12):

```bash
              user     system      total        real
User exists:239.407672   0.433387 239.841059 (240.785424)
User does not exists (near misss):  0.162870   0.030302   0.193172 (  0.364542)
User does not exists:  0.180701   0.032199   0.212900 (  0.357160)
User exists (hmac):239.284260   0.535508 239.819768 (240.647700)
User does not exists (near misss, hmac):  0.187196   0.031542   0.218738 (  0.367959)
User does not exists (hmac):  0.162954   0.030500   0.193454 (  0.318629)
>total: 479.385653   1.093438 480.479091 (482.841414)
>avg:    79.897609   0.182240  80.079848 ( 80.473569)
              user     system      total        real
User find:239.430127   0.508720 239.938847 (289.751821)
User new:  0.015060   0.000480   0.015540 (  0.015545)
>total: 239.445187   0.509200 239.954387 (289.767366)
>avg:   119.722594   0.254600 119.977194 (144.883683)
```
