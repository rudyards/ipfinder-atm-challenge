# README

ipfinder is a straightforward app that uses GeoJS to find and cache IP Addresses.

In order to start it up, run ``rails s`` from the project's home directory.

You can then add addresses and get initial information via ``/addresses/find?ip=``.

Once you've found one or more addresses, you should use ``/addresses/show`` to see all the addresses you've searched thus far! You can also use ``/addresses/show?country="United States"``, ``/addresses/show?city="Los Angeles"``, or ``/addresses/show?city="Los Angeles"&country="United States"`` to filter down to a subset of the addresses you've looked up that match the included parameters.


ipfinder uses rspec for testing. Run ``bundle exec rspec`` from the project's home directory to see the current state of tests.