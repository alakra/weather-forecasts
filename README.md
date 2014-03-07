# National Digital Forecast Database (NDFD) API Client for Ruby
--------------------------------------------------------------------------------

[![Build Status](https://travis-ci.org/alakra/ndfd-weather-forecast-client.png?branch=master)](https://travis-ci.org/alakra/ndfd-weather-forecast-client)
[![Code Climate](https://codeclimate.com/github/alakra/ndfd-weather-forecast-client.png)](https://codeclimate.com/github/alakra/ndfd-weather-forecast-client)
[![Dependency Status](https://gemnasium.com/alakra/ndfd-weather-forecast-client.png)](https://gemnasium.com/alakra/ndfd-weather-forecast-client)
[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/alakra/ndfd-weather-forecast-client/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

## Summary

This library provides API client access to NOAA's NDFD database
for access to weather forecast information via Ruby.

## NDFD Features

It's not apparent what the NDFD API gives you unless you delve into
their API docs so here is a quick rundown of what weather metrics you
can get out of it:

  * 3-hour interval current temperature forecasts
  * Max. Temperature
  * Min. Temperature
  * Dewpoint Temperature
  * Apparent Temperature
  * 12 Hour Probability of Precipitation
  * Liquid Precipitation Amount
  * Snowfall Amount
  * Cloud Cover Amount
  * Relative Humidity
  * Wind Speed
  * Wind Direction
  * Weather
  * Weather Icons
  * Wave Height
  * Probabilistic Tropical Cyclone Wind Speed >34 Knots (Incremental)
  * Probabilistic Tropical Cyclone Wind Speed >50 Knots (Incremental)
  * Probabilistic Tropical Cyclone Wind Speed >64 Knots (Incremental)
  * Probabilistic Tropical Cyclone Wind Speed >34 Knots (Cumulative)
  * Probabilistic Tropical Cyclone Wind Speed >50 Knots (Cumulative)
  * Probabilistic Tropical Cyclone Wind Speed >64 Knots (Cumulative)
  * Wind Gust
  * Fire Weather from Wind and Relative Humidity
  * Fire Weather from Dry Thunderstorms
  * Convective Hazard Outlook
  * Probability of Tornadoes
  * Probability of Hail
  * Probability of Damaging Thunderstorm Winds
  * Probability of Extreme Tornadoes
  * Probability of Extreme Hail
  * Probability of Extreme Thunderstorm Winds
  * Probability of Severe Thunderstorms
  * Probability of Extreme Severe Thunderstorms
  * Probability of 8- To 14-Day Average Temperature Above Normal
  * Probability of 8- To 14-Day Average Temperature Below Normal
  * Probability of One-Month Average Temperature Above Normal
  * Probability of One-Month Average Temperature Below Normal
  * Probability of Three-Month Average Temperature Above Normal
  * Probability of Three-Month Average Temperature Below Normal
  * Probability of 8- To 14-Day Total Precipitation Above Median
  * Probability of 8- To 14-Day Total Precipitation Below Median
  * Probability of One-Month Total Precipitation Above Median
  * Probability of One-Month Total Precipitation Below Median
  * Probability of Three-Month Total Precipitation Above Median
  * Probability of Three-Month Total Precipitation Below Median
  * Real-time Mesoscale Analysis Precipitation
  * Real-time Mesoscale Analysis GOES Effective Cloud Amount
  * Real-time Mesoscale Analysis Dewpoint Temperature
  * Real-time Mesoscale Analysis Temperature
  * Real-time Mesoscale Analysis Wind Direction
  * Real-time Mesoscale Analysis Wind Speed
  * Watches, Warnings, and Advisories
  * Ice Accumulation
  * Maximum Relative Humidity
  * Minimum Relative Humidity

Forecast information is only up to ~7 days in the future in most cases.

See the usage section for details on each specifc method.

## Client Features

The client offers a easy to use query interface and will hand back data to you as Ruby objects.

Other features:

  * Validates requests and data types on execution of requests (will
    raise contextual errors on poorly formed data in queries)

## Runtime Dependencies

Ruby versions supported:

  * 2.1.0
  * 2.0.0
  * 1.9.3

Ruby versions not supported (but will be):

  * JRuby 1.7+
  * Rubinius 2.2+

Ruby versions that will not be supported:

  * <= 1.9.2 (including REE)

Libraries used:

  * savonrb

## Installation

    gem install ndfd-forecast-weather-client

## Usage

`NDFD.client` is the top-level client object from whence all API calls are executed.

Most calls follow the form of:

    NDFD.client.
          select(:maxt, :mint, :temp).
          where().
          execute

This will return a `NDFD::Response` object where the raw xml and a
hash of the selected attributes of interested are stored.

The hash in the previous query is structured like this:

    [
      { maxt: 82, mint: 67, temp: 77, timestamp: '2014-02-28T00:00:00' },
      { maxt: 82, mint: 67, temp: 77, timestamp: '2014-02-28T03:00:00' },
      { maxt: 82, mint: 67, temp: 77, timestamp: '2014-02-28T06:00:00' }
      etc...
    ]

NOTE: `timestamp` are actually ActiveSupport::TimeWithZone objects

There are 8 API calls that can be made to NDFD:

<table>
    <tr>
        <th>Query Method</th>
        <th>Selectable Attributes</th>
        <th>Valid Options</th>
        <th>Default Value</th>
        <th>Required</th>
        <th>Required Keys</th>
        <th>Example</th>
    </tr>
    <tr class="query-method-definitions">

    </tr>
</table>

To see a description of the NDFD Spatial Reference System (used for collecting lat/longs in an area)
http://graphical.weather.gov/docs/ndfdSRS.htm
