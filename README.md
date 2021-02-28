# README

**ipfinder** is a straightforward app that uses GeoJS to find and cache IP Addresses. It presents a pair of endpoints available to the get method. One for searching for addresses, the other to see what addresses have been searched for.

In order to start it up, use ``rails s`` from the project's home directory.

You can then add addresses and get initial information via ``/addresses/find?ip=<ip address>``. For example: ``/addresses/find?ip=100.0.100.100``

Once you've found one or more addresses, you should use ``/addresses/show`` to see all the addresses you've searched thus far. You can also use ``/addresses/show?country="United States"``, ``/addresses/show?city="Los Angeles"``, or ``/addresses/show?city="Los Angeles"&country="United States"`` to filter down to a subset of the addresses you've looked up that match the included parameters.


ipfinder uses rspec for testing. Use ``bundle exec rspec`` from the project's home directory to see the current state of tests.