# Weather Forecasts for Ruby

[![Gem Version](https://badge.fury.io/rb/weather-forecasts.svg)](http://badge.fury.io/rb/weather-forecasts)
[![Build Status](https://travis-ci.org/alakra/weather-forecasts.svg?branch=master)](https://travis-ci.org/alakra/weather-forecasts)
[![Dependency Status](https://gemnasium.com/alakra/weather-forecasts.png)](https://gemnasium.com/alakra/weather-forecasts)
[![Code Climate](https://codeclimate.com/github/alakra/weather-forecasts.png)](https://codeclimate.com/github/alakra/weather-forecasts)

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
  * activesupport (for TimeWithZone support)
  * nokogiri (for XML/XSLT parsing)
  * httpi (for interfacing with http clients)
  * http_logger (for controlling logging output from savon)

## Installation

    gem install weather-forecasts

## Usage

`WeatherForecasts.client` is the top-level start point from whence all API calls are executed.

Most calls follow the form of:

    WeatherForecasts.client.
          select(:maxt, :mint, :temp, etc.).
          where(conditions).
          execute

This will return an `Array` or `Hash` containing the data from the
response depending on the type of the request.

**NOTE**: Dates and times passed to the `where` must be
ActiveSupport::TimeWithZone objects.

**NOTE**: `NDFDgen` and `NDFDgenByDay` are not implemented in favor of
using the equivalent collection-based functions.

**NOTE**: `GmlLatLonList`, `GmlTimeSeries` are not implemented because
of their limited use (and my inability to figure out what parameters
to use to make a valid request).  It appears to be [discontinued](http://www.nws.noaa.gov/om/notification/tin10-59ending_wfs.htm).

<table>
  <tr>
    <th>Query Method</th>
    <th>API server function</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><code>select_hourly</code></td>
    <td><code>DigitalDWML from tabular data feed on [NWS](http://www.weather.gov/)</code></td>
    <td>Returns a <code>Hash</code> of hourly (1-hour) forecast metrics for a single latitude/longitude out to 7 days.</td>
  </tr>
  <tr>
    <td><code>select</code></td>
    <td><code>NDFDgenLatLonList</code></td>
    <td>Returns a <code>Hash</code> of forecast metrics for multiple latitudes/longitudes.</td>
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

To see more detailed documention, view the [API Documentation](http://rdoc.info/gems/weather-forecasts/frames)
