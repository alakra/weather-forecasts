# National Digital Forecast Database (NDFD) API Client for Ruby
--------------------------------------------------------------------------------

[![Build Status](https://travis-ci.org/alakra/ndfd-weather-forecast-client.png?branch=master)](https://travis-ci.org/alakra/ndfd-weather-forecast-client)
[![Code Climate](https://codeclimate.com/github/alakra/ndfd-weather-forecast-client.png)](https://codeclimate.com/github/alakra/ndfd-weather-forecast-client)
[![Inline docs](http://inch-pages.github.io/github/alakra/ndfd-weather-forecast-client.png)](http://inch-pages.github.io/github/alakra/ndfd-weather-forecast-client)
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
Validates requests and data types on execution of requests (will raise contextual errors on poorly formed data in queries)

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

This will return an `Array`, `Hash` or `Nokogiri::XML::Document` containing
the data from the response depending on the type of the request.

**NOTE**: Dates and times passed to the `where` must be
ActiveSupport::TimeWithZone objects.

**NOTE**: `NDFDgen` and `NDFDgenByDay` are not implemented in favor of
using the equivalent collection-based functions.

<table>
  <tr>
    <th>Query Method</th>
    <th>API server function</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><code>select</code></td>
    <td><code>NDFDgenLatLonList</code></td>
    <td>Returns a <code>Hash</code> of forecast metrics for multiple latitudes/longitudes.</td>
  </tr>
  <tr>
    <td><code>select_gml</code></td>
    <td><code>GmlLatLonList</code></td>
    <td>Returns a <code>Nokogiri::XML::Document</code> of forecast metrics in GML format for multiple latitudes/longitudes.</td>
  </tr>
  <tr>
    <td><code>select_gml_on_time_series</code></td>
    <td><code>GmlTimeSeries</code></td>
    <td>Returns a <code>Nokogiri::XML::Document</code> of forecast metrics in GML format for multiple latitudes/longitudes over a specific time period.</td>
  </tr>
  <tr>
    <td><code>select_by_days</code></td>
    <td><code>NDFDgenByDayLatLonList</code></td>
    <td>Returns a <code>Hash</code> of forecast metrics for multiple latitudes/longitudes in a 24/12 hour period for a number of days.</td>
  </tr>
  <tr>
    <td><code>select_coordinates_by_zip</code></td>
    <td><code>LatLonListZipCode</code></td>
    <td>Returns a <code>Hash</code> of latitudes/longitudes for every zip code requested.</td>
  </tr>
  <tr>
    <td><code>select_coordinates_by_cities</code></td>
    <td><code>LatLonListCityNames</code></td>
    <td>Returns a <code>Hash</code> of latitudes/longitudes for a pre-defined set of cities.</td>
  </tr>
  <tr>
    <td><code>select_square_coordinates</code></td>
    <td><code>LatLonListSquare</code></td>
    <td>Returns a <code>Array</code> of latitudes/longitudes for the requested rectangular area.</td>
  </tr>
  <tr>
    <td><code>select_gridpoint_coordinates</code></td>
    <td><code>LatLonListSubgrid</code></td>
    <td>Returns a <code>Array</code> of latitudes/longitudes for the requested subgrid.</td>
  </tr>
  <tr>
    <td><code>select_linepoint_coordinates</code></td>
    <td><code>LatLonListLine</code></td>
    <td>Returns a <code>Array</code> of latitudes/longitudes between a start and end coordinate.</td>
  </tr>
  <tr>
    <td><code>select_corner_coordinates</code></td>
    <td><code>CornerPoints</code></td>
    <td>Returns a <code>Array</code> of latitudes/longitudes of the corners of one of the NDFD grids.</td>
  </tr>
</table>

To see a description of the NDFD Spatial Reference System (used for collecting lat/longs in an area)
http://graphical.weather.gov/docs/ndfdSRS.htm

To see more detailed documention, view the [API Documentation](http://rdoc.info/github/alakra/ndfd-weather-forecast-client/frames)

## Special Thanks

  * To [greencoder](https://github.com/greencoder) for [noaa-dwml-to-json-xslt](https://github.com/greencoder/noaa-dwml-to-json-xslt)
