# Uncomment this if you reference any of your controllers in activate
# require_dependency "application_controller"
require "radiant-sheets_multi_site-extension"

class SheetsMultiSiteExtension < Radiant::Extension
  version     RadiantSheetsMultiSiteExtension::VERSION
  description RadiantSheetsMultiSiteExtension::DESCRIPTION
  url         RadiantSheetsMultiSiteExtension::URL

  # See your config/routes.rb file in this extension to define custom routes

  extension_config do |config|
    # config is the Radiant.configuration object
  end

  def activate
    raise "The SheetsMultiSite Extension requires the Sheets extension to be loaded first" unless defined?(SheetsExtension)
    raise "The SheetsMultiSite Extension requires the MultiSite extension to be loaded first" unless defined?(MultiSite)
    
    StylesheetPage.send :include, SheetsMultiSite::SheetExtensions
    JavascriptPage.send :include, SheetsMultiSite::SheetExtensions

    Admin::SheetResourceController.send :include, MultiSite::ResourceControllerExtensions
    
    Page.send :include, SheetsMultiSite::StylesheetTags
  end
end
