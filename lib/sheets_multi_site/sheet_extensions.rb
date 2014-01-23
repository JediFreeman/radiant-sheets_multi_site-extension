module SheetsMultiSite::SheetExtensions
  def self.included(base)
    base.class_eval {
      def self.root
        sheet_root ||= Site.default.homepage.children.first(:conditions => {:class_name => self.to_s})
      rescue NoMethodError => e
        e.extend Sheet::InvalidHomePage
        raise e
      end
      
      def self.create_root_with_sites
        s = self.new_with_defaults
        s.parent_id = Site.default.homepage.id
        s.created_by_id = ''
        s.slug = self.name == 'StylesheetPage' ? 'css' : 'js'
        s.save
      end
    }
  end
end