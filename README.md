CurrencyTracker
===============

CurrencyTracker allows you to track your personal collection of world currencies, by tagging the countries that you've visited along your travels.

Seed the database with currencies and countries by running:

```bash
rake db:seed
```

Testing
-------

Run all test with:

```bash
bundle exec rake travis
```

Run unit tests with:

```bash
bundle exec rake test
```

Cucumber features can be run with:

```bash
bundle exec rake cucumber
```

Features
--------

* Track Visited Countries
* Track Collected Currencies
* Charts show you how far along you are!

Assumptions
-----------

* Current approach does not handle the cases when currency can be collected in 
several countries. The same in real world in one country several currencies
could be collected. So, to handle those cases and simplify application interface
it better to display progress on single page. New approach allows to improve domain
models design as well and better adapt it for multi-tenantcy requirement.
