# National Digital Forecast Database (NDFD) API Client for Ruby
--------------------------------------------------------------------------------

[![Build Status](https://travis-ci.org/alakra/ndfd-weather-forecast-client.png?branch=master)](https://travis-ci.org/alakra/ndfd-weather-forecast-client)
[![Code Climate](https://codeclimate.com/github/alakra/ndfd-weather-forecast-client.png)](https://codeclimate.com/github/alakra/ndfd-weather-forecast-client)
[![Dependency Status](https://gemnasium.com/alakra/ndfd-weather-forecast-client.png)](https://gemnasium.com/alakra/ndfd-weather-forecast-client)
[![Coverage Status](https://coveralls.io/repos/alakra/ndfd-weather-forecast-client/badge.png)](https://coveralls.io/r/alakra/ndfd-weather-forecast-client)
[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/alakra/ndfd-weather-forecast-client/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

## Summary

This library provides API client access to NOAA's NDFD database
for access to weather forecast information via Ruby.

## NDFD Features

You can [see the available forecast information](http://www.nws.noaa.gov/ndfd/technical.htm#elements) that is accessible via the API on the NDFD technical description page.

In general, you can get the following:

  * Specific forecast dimensions (min/max temperature, wind speed, etc.) out to 168 hours.
  * Climate outlook probabilities (estimated averages/totals of temperature and precipitation)
  * Convective Outlook Hazard Probabilities (hazard outlook, tornadoes, etc.)
  * Probabilistic Tropical Cyclone Surface Wind Speed (measured in knots)

## Client Features

The client offers a easy to use query interface and will hand back data to you in hashes, arrays and XML documents.

Other features:

  * Validates requests and data types on execution of requests (will
    raise contextual errors on poorly formed data in queries)

## Runtime Dependencies

Ruby versions supported:

  * 2.1.x
  * 2.0.x
  * 1.9.3

Ruby versions not supported (but will be):

  * JRuby 1.7+
  * Rubinius 2.2+

Ruby versions that will not be supported:

  * <= 1.9.2 (including REE)

Libraries used:

  * savon (for SOAP support)
  * active_support (for TimeWithZone support)
  * nokogiri (for XML/XSLT parsing)
  * http_logger (for controlling logging output from savon)

## Installation

    gem install ndfd-forecast-weather-client

## Usage

`NDFD.client` is the top-level start point from whence all API calls are executed.

Most calls follow the form of:

    NDFD.client.
          select(:maxt, :mint, :temp, etc.).
          where(conditions).
          execute

This will return an Array, Hash or Nokogiri::XML::Document containing
the data from the response depending on the type of the request.

NOTE: Dates and times passed to the `where` must be
ActiveSupport::TimeWithZone objects.

There are 8 API calls that can be made to NDFD:

<table>
  <tr>
    <th>Query Method</th>
    <th>API server function</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>`select`</td>
    <td>`NDFDgenLatLonList()`</td>
    <td>Returns a `Hash` of forecast metrics for multiple latitudes/longitudes.</td>
  </tr>
</table>

To see a description of the NDFD Spatial Reference System (used for collecting lat/longs in an area)
http://graphical.weather.gov/docs/ndfdSRS.htm
