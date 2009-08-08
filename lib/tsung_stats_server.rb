require 'rubygems'
#gem 'inochi', '~> 0'
require 'inochi'

Inochi.init :TsungStatsServer,
  :project => 'skadesgems',
  :version => '0.0.1',
  :release => '2009-03-14',
  :website => 'http://skadesgems.rubyforge.org',
  :tagline => 'A simple webserver serving tsung stats',
  :require => {
    'sinatra' => '~> 0.9',
    'zipruby' => '~> 0.3',
    'markaby' => '~> 0.5'
  }
