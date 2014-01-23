namespace :radiant do
  namespace :extensions do
    namespace :sheets_multi_site do
      
      desc "Runs the migration of the Sheets Multi Site extension"
      task :migrate => :environment do
        puts "This extension does not affect the database. Nothing done."
      end
      
      desc "Copies public assets of the Sheets Multi Site to the instance public/ directory."
      task :update => :environment do
        puts "This extension has no public assets. Nothing done."
      end  
      
      desc "Syncs all available translations for this ext to the English ext master"
      task :sync => :environment do
        puts "This extension has translations. Nothing done."
      end
    end
  end
end
