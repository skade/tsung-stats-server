require 'rubygems'
gem 'inochi', '~> 0'
require 'inochi'

Inochi.init :TsungStatsServer,
  :project => 'tsung_stats_server',
  :version => '0.0.0',
  :release => '2009-02-13',
  :website => 'http://skadesgems.rubyforge.org',
  :tagline => 'A simple webserver serving tsung stats',
  :require => {
    'sinatra' => '~> 0.9',
    'rubyzip' => '~> 0.9',
    'markaby' => '~> 0.5'
  }
