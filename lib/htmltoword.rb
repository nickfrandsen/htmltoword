# encoding: UTF-8
require "action_controller"
require "action_view"
require "nokogiri"
require "zip"

module Htmltoword
  def self.root
    File.expand_path '../..', __FILE__
  end

  def self.templates_path
    File.join root, "templates"
  end
end

require "htmltoword/version"
require "htmltoword/htmltoword_helper"
require "htmltoword/document"
