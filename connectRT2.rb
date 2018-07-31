
###################################################################################################
# Use the right paths to everything, basing them on this script's directory.
def getRealPath(path) Pathname.new(path).realpath.to_s; end
$homeDir    = ENV['HOME'] or raise("No HOME in env")
$scriptDir  = getRealPath "#{__FILE__}/.."
$subiDir    = getRealPath "#{$scriptDir}/.."
$espylib    = getRealPath "#{$subiDir}/lib/espylib"
$erepDir    = getRealPath "#{$subiDir}/xtf-erep"
$arkDataDir = getRealPath "#{$erepDir}/data"
$controlDir = getRealPath "#{$erepDir}/control"
$jscholDir  = getRealPath "#{$homeDir}/eschol5/jschol"

# Go to the right URLs for the front-end+api and submission systems
$hostname = `/bin/hostname`.strip
$escholServer, $submitServer = case $hostname
  when /pub-submit-stg/; ["http://pub-jschol-stg.escholarship.org", "https://pub-submit-stg.escholarship.org"]
  when /pub-submit-prd/; ["https://escholarship.org",               "https://submit.escholarship.org"]
  otherwise raise("unrecognized host")
end

###################################################################################################
# External code modules
require 'date'
require 'httparty'
require 'json'
require 'nokogiri'
require 'pp'
require 'sinatra'
require 'time'
require_relative "./rest.rb"
require_relative "./deposit.rb"

# Flush stdout after each write
STDOUT.sync = true

